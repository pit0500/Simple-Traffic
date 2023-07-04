﻿using ThinkEngine;
using ThinkEngine.it.unical.mat.objectsMapper.BrainsScripts.DCS;
using ThinkEngine.it.unical.mat.objectsMapper.BrainsScripts.Specializations.ASP;
using UnityEngine;

public class Instantiator : CustomInstantiator
{

    public PrefabInstantiator instantiator;

    private void Start()
    {
        Debug.Log("Starting");
        instantiator = Utility.PrefabInstantiator;
    }

    public override void ParseLiteral(string predicateName, string[] arguments)
    {
        if (predicateName == "threeWayIntersection")
        {
            Debug.Log("Instantiating three-way intersection:\n");
            if (int.TryParse(arguments[0], out int index) && int.TryParse(arguments[1], out int x) && int.TryParse(arguments[2], out int z) && int.TryParse(arguments[3], out int y))
            {
                instantiator.InstantiatePrefab(index, new Vector3(x, 0, z), new Quaternion(0, y, 0, 0));
            }
        }
        else if (predicateName == "turn")
        {
            Debug.Log("Instantiating turn:\n");
            if (int.TryParse(arguments[0], out int index) && int.TryParse(arguments[1], out int x) && int.TryParse(arguments[2], out int z))
            {
                instantiator.InstantiatePrefab(index, new Vector3(x, 0, z), new Quaternion(0, 0, 0, 0));
            }
        }
        else if (predicateName == "waypointFill")
        {
            Debug.Log("Instantiating waypoint-road:\n");
            if (int.TryParse(arguments[0], out int index) && int.TryParse(arguments[1], out int x) && int.TryParse(arguments[2], out int z) && int.TryParse(arguments[3], out int y))
            {
                instantiator.InstantiatePrefab(index, new Vector3(x, 0, z), new Quaternion(0, y, 0, 0));
            }
        }
        else if (predicateName == "fourWayIntersection")
        {
            Debug.Log("Instantiating four-way intersection:\n");
            if (int.TryParse(arguments[0], out int index) && int.TryParse(arguments[1], out int x) && int.TryParse(arguments[2], out int z))
            {
                instantiator.InstantiatePrefab(index, new Vector3(x, 0, z), new Quaternion(0, 0, 0, 0));
            }
        }
    }

}

