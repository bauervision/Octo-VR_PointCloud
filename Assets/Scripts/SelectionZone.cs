using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class SelectionZone : MonoBehaviour
{
    public GameObject MeshToAffect;
    //public Color SelectionColor;
    public float SelectionRadius = 0.5f;

    private Material shader;
    private Vector3 meshOffset;

    private void Awake()
    {
        shader = MeshToAffect.GetComponent<Renderer>().sharedMaterial;
    }


    private void handleShaderUpdate()
    {
        shader.SetVector("_ForceField", meshOffset);
    }

    private void handleRadiusUpdate()
    {
        shader.SetFloat("_Radius", SelectionRadius);
    }

    // private void handleColorUpdate()
    // {
    //     shader.SetColor("_Tint", SelectionColor);
    // }

    public void SetMeshVector(Vector3 value)
    {
        meshOffset = value;
    }

    // Update is called once per frame
    void Update()
    {
        handleShaderUpdate();
        handleRadiusUpdate();
        //handleColorUpdate();
        SetMeshVector(this.transform.position);
    }
}
