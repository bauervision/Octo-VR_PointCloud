using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelectionMesh : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }

    // private bool IsPointInside(this Mesh aMesh, Vector3 aLocalPoint)
    // {
    //     var verts = aMesh.vertices;
    //     var tris = aMesh.triangles;
    //     int triangleCount = tris.Length / 3;
    //     for (int i = 0; i < triangleCount; i++)
    //     {
    //         var V1 = verts[tris[i * 3]];
    //         var V2 = verts[tris[i * 3 + 1]];
    //         var V3 = verts[tris[i * 3 + 2]];
    //         var P = new Plane(V1, V2, V3);
    //         if (P.GetSide(aLocalPoint))
    //             return false;
    //     }
    //     return true;
    // }
}
