using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class SelectionZone : MonoBehaviour
{
    public GameObject MeshToAffect;
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

    public void SetMeshVector(Vector3 value)
    {
        meshOffset = value;
    }

    // Update is called once per frame
    void Update()
    {
        handleShaderUpdate();
        SetMeshVector(this.transform.position);
    }
}
