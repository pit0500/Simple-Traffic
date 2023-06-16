using System.Collections;
using System.Collections.Generic;
using ThinkEngine;
using ThinkEngine.it.unical.mat.objectsMapper.BrainsScripts.DCS;
using ThinkEngine.it.unical.mat.objectsMapper.BrainsScripts.Specializations.ASP;
using UnityEngine;
using UnityEngine.AI;

public class Instantiator : CustomInstantiator
{

    public PrefabInstantiator prefabInstantiator;

    public NavMeshSurface[] surfaces;

    void Start()
    {
        Debug.Log("Starting instantiation");
        prefabInstantiator = Utility.PrefabInstantiator;
    }

    public override void ParseLiteral(string predicateName, string[] arguments)
    {
        if (predicateName == "threeWayIntersection")
        {
            if (int.TryParse(arguments[0], out int index) && int.TryParse(arguments[1], out int x) && int.TryParse(arguments[2], out int z))
            {
                prefabInstantiator.InstantiatePrefab(index, new Vector3(x, 0, z), new Quaternion(0, 0, 0, 0));
            }
            foreach (var surface in surfaces) surface.BuildNavMesh();
        }
    }

}

