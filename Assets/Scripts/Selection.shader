// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Field" {
     Properties{
         _SelectedColor ("Color (RGBA)", Color) = (1, 1, 1, 1) // add _Color property
         _Color ("Color (RGBA)", Color) = (1, 1, 1, 1) // add _Color property
         _ForceField ("Force Field Position", Vector) = (0, 0, 0)
         _Radius("Radius", Float) = 2.3
         
     }
     SubShader {
         Tags{ "Queue" = "Geometry" "RenderType"="Transparent"}
         Blend SrcAlpha OneMinusSrcAlpha
         Pass{
 
             CGPROGRAM
 
             #pragma vertex vert alpha
             #pragma fragment frag alpha
             #include "UnityCG.cginc"
 
             uniform float4 _SelectedColor;
             uniform float4 _Color;
             uniform float4 _ForceField;
             uniform float _Radius;
             
 
             struct vertexInput{
                 float4 vertex : POSITION;
             };
 
             struct vertexOutput{
                 float4 pos : SV_POSITION;
                 float4 worldPos : TEXCOORD0;
             };
 
             vertexOutput vert (vertexInput input){
                 vertexOutput output;
 
                 float4x4 modelMatrix = unity_ObjectToWorld;
 
                 output.pos = UnityObjectToClipPos(input.vertex);
                 output.worldPos = mul(modelMatrix, input.vertex);
 
                 return output;
             }
 
             float4 frag(vertexOutput input) : COLOR{
                 float4 color = _Color;
                 if (distance (input.worldPos, _ForceField) < _Radius)
                     color = _SelectedColor;
                 return float4 (color);
             }
             ENDCG
         }
     } 
 }