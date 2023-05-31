using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class RuntimeBaker : MonoBehaviour
{

    public NavMeshSurface[] surfaces;

    // Start is called before the first frame update
    void Start()
    {
        foreach (NavMeshSurface surface in surfaces)
        {
            surface.BuildNavMesh();
        }
    }
}
