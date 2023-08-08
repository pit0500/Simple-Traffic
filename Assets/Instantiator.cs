using ThinkEngine;
using ThinkEngine.it.unical.mat.objectsMapper.BrainsScripts.DCS;
using ThinkEngine.it.unical.mat.objectsMapper.BrainsScripts.Specializations.ASP;
using UnityEngine;

public class Instantiator : CustomInstantiator
{
    public PrefabInstantiator instantiator;

    private void Awake()
    {
        Debug.Log("Starting");
        instantiator = Utility.PrefabInstantiator;
    }

    public override void ParseLiteral(string predicateName, string[] arguments)
    {
        if (predicateName == "threeWayIntersection")
        {
            Debug.Log("Instantiating three-way intersection:\n");
            InstantiateThreeWayIntersection(arguments);
        }
        else if (predicateName == "turn")
        {
            Debug.Log("Instantiating turn:\n");
            InstantiateTurn(arguments);
        }
        else if (predicateName == "waypointFill")
        {
            Debug.Log("Instantiating waypoint-road:\n");
            InstantiateWaypointFill(arguments);
        }
        else if (predicateName == "fourWayIntersection")
        {
            Debug.Log("Instantiating four-way intersection:\n");
            InstantiateFourWayIntersection(arguments);
        }
        else if (predicateName == "straightRoad")
        {
            Debug.Log("Instantiating straight road:\n");
            InstantiateStraightRoad(arguments);
        }
    }

    private void InstantiateThreeWayIntersection(string[] arguments)
    {
        if (int.TryParse(arguments[0], out int index) &&
                int.TryParse(arguments[1], out int x) &&
                int.TryParse(arguments[2], out int z) &&
                int.TryParse(arguments[3], out int y))
        {
            Vector3 position = new(x * 3, 0, z * 3);
            Quaternion rotation = Quaternion.Euler(0, y, 0);
            instantiator.InstantiatePrefab(index, position, rotation);
        }
    }

    private void InstantiateTurn(string[] arguments)
    {
        if (int.TryParse(arguments[0], out int index) &&
                int.TryParse(arguments[1], out int x) &&
                int.TryParse(arguments[2], out int z) &&
                int.TryParse(arguments[3], out int y))
        {
            Vector3 position = new(x * 3, 0, z * 3);
            Quaternion rotation = Quaternion.Euler(0, y, 0);
            instantiator.InstantiatePrefab(index, position, rotation);
        }
    }

    private void InstantiateWaypointFill(string[] arguments)
    {
        if (int.TryParse(arguments[0], out int index) &&
                int.TryParse(arguments[1], out int x) &&
                int.TryParse(arguments[2], out int z) &&
                int.TryParse(arguments[3], out int y))
        {
            Vector3 position;
            position = y switch
            {
                0 => new(x * 3, 0, (z * 3) + 1.5f),
                _ => new((x * 3) + 1.5f, 0, z * 3)
            };
            Quaternion rotation = Quaternion.Euler(0, y, 0);
            instantiator.InstantiatePrefab(index, position, rotation);
        }
    }

    private void InstantiateFourWayIntersection(string[] arguments)
    {
        if (int.TryParse(arguments[0], out int index) &&
                int.TryParse(arguments[1], out int x) &&
                int.TryParse(arguments[2], out int z))
        {
            Vector3 position = new(x * 3, 0, z * 3);
            Quaternion rotation = Quaternion.Euler(0, 0, 0);
            instantiator.InstantiatePrefab(index, position, rotation);
        }
    }

    private void InstantiateStraightRoad(string[] arguments)
    {
        if (int.TryParse(arguments[0], out int index) &&
                int.TryParse(arguments[1], out int x) &&
                int.TryParse(arguments[2], out int z) &&
                int.TryParse(arguments[3], out int finish) &&
                int.TryParse(arguments[4], out int y))
        {
            Vector3 position;
            position = y switch
            {
                0 => new(x * 3, 0, finish * 3),
                _ => new(finish * 3, 0, z * 3)
            };
            Quaternion rotation = Quaternion.Euler(0, y, 0);
            instantiator.InstantiatePrefab(index, position, rotation);
        }
    }

}
