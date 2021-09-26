using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyAfterTime : MonoBehaviour
{

    public float time = 10.0f;
    
    void Start()
    {
        Destroy(gameObject, time);
    }

   
    void Update()
    {
        //nothing to update 
    }
}
