// Pcx - Point cloud importer & renderer for Unity
// https://github.com/keijiro/Pcx

Shader "Point Cloud/Point"
{
    Properties
    {
        _Tint("Tint", Color) = (0.5, 0.5, 0.5, 1)
        _PointSize("Point Size", Float) = 0.05
        _ForceField ("Force Field Position", Vector) = (0, 0, 0)
        _Radius("Radius", Float) = 0.5

        [Toggle] _Distance("Apply Distance", Float) = 1
    }
    SubShader
    {
        Tags { "Queue" = "Geometry" "RenderType"="Opaque" }
        
        Pass
        {
            CGPROGRAM

            #pragma vertex Vertex
            #pragma fragment Fragment

            #pragma multi_compile_fog
            #pragma multi_compile _ UNITY_COLORSPACE_GAMMA
            #pragma multi_compile _ _DISTANCE_ON
            #pragma multi_compile _ _COMPUTE_BUFFER

            #include "UnityCG.cginc"
            #include "Common.cginc"

            struct Attributes
            {
                float4 position : POSITION;
                float4 worldPos : TEXCOORD0;
                float4 color : COLOR;
            };

            struct vertexOutput
            {
                float4 position : SV_Position;
                float4 worldPos : TEXCOORD0;
                float3 color : COLOR;
                half psize : PSIZE;
                UNITY_FOG_COORDS(0)
            };

            float4 _Tint;
            float4x4 _Transform;
            half _PointSize;
            uniform float4 _ForceField;
            uniform float _Radius;

            struct vertexInput{
                float4 vertex : POSITION;
                half4 worldPos : TEXCOORD0;
                float4 color: COLOR;
             };
 
             vertexOutput Vertex (vertexInput input){
                 vertexOutput output;
 
                 float4x4 modelMatrix = unity_ObjectToWorld;
 
                 output.position = UnityObjectToClipPos(input.vertex);
                 output.worldPos = mul(modelMatrix, input.vertex);
                
                 return output;
             }

        #if _COMPUTE_BUFFER
            StructuredBuffer<float4> _PointBuffer;
        #endif

        #if _COMPUTE_BUFFER
            vertexOutput Vertex(uint vid : SV_VertexID)
        #else
            vertexOutput Vertex(Attributes input)
        #endif
            {
            #if _COMPUTE_BUFFER
                float4 pt = _PointBuffer[vid];
                float4 pos = mul(_Transform, float4(pt.xyz, 1));
                float4  color = PcxDecodeColor(asuint(pt.w));
                return color
                
            #else
                float4 pos = input.position;
                float3 col = input.color;
            #endif

            // #ifdef UNITY_COLORSPACE_GAMMA
            //     col *= _Tint.rgb * 2;
            // #else
            //     // col *= LinearToGammaSpace(_Tint.rgb) * 2;
            //     col = GammaToLinearSpace(col);
           // #endif

                vertexOutput o;
                o.position = UnityObjectToClipPos(pos);
                o.color = col;
            #ifdef _DISTANCE_ON
                o.psize = _PointSize / o.position.w * _ScreenParams.y;
            #else
                o.psize = _PointSize;
            #endif
                UNITY_TRANSFER_FOG(o, o.position);
                return o;
            }


            float3 Fragment(vertexOutput input) : COLOR
            {
                // half4 c = half4(input.color, _Tint.a);
                // UNITY_APPLY_FOG(input.fogCoord, c);
                // return c;
                float3 color = input.color;
                //UNITY_APPLY_FOG(input.fogCoord, color);
                 if (distance (input.worldPos, _ForceField) < _Radius){
                     color *= _Tint.rgb * 2;
                 }
                return color;
            }

            ENDCG
        }
    }
    CustomEditor "Pcx.PointMaterialInspector"
}
