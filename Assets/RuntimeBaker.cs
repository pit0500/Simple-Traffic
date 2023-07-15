using UnityEngine;
using System.Collections;
using UnityEngine.AI;

public class RuntimeBaker : MonoBehaviour
{

    public NavMeshSurface[] surfaces;

    private void Awake()
    {
        StartCoroutine(BuildNavMeshAsync());
    }

    private IEnumerator BuildNavMeshAsync()
    {
        yield return new WaitForSeconds(10);

        UnityMainThreadDispatcher.Instance().Enqueue(OnBuildNavMeshCompleted);
    }

    private void OnBuildNavMeshCompleted()
    {
        foreach (var surface in surfaces) surface.BuildNavMesh();
    }
}
