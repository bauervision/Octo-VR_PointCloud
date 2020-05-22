using UnityEngine;
public class InteractionsManager : MonoBehaviour
{
    public GameObject benches;
    public GameObject pavers;
    public GameObject roof;
    public GameObject signs;
    public GameObject trunk;
    public GameObject flood;



    public void Toggle_Benches()
    {
        benches.SetActive(!benches.activeInHierarchy);
    }

    public void Toggle_Pavers()
    {
        pavers.SetActive(!pavers.activeInHierarchy);
    }

    public void Toggle_Roof()
    {
        roof.SetActive(!roof.activeInHierarchy);
    }

    public void Toggle_Signs()
    {
        signs.SetActive(!signs.activeInHierarchy);
    }

    public void Toggle_Trunk()
    {
        trunk.SetActive(!trunk.activeInHierarchy);
    }

    public void SetFlood(float value)
    {
        flood.transform.position = new Vector3(flood.transform.position.x, value, flood.transform.position.z);
    }
}