using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cam_Switch : MonoBehaviour
{
   
   
    void Update()
    {
        if (Input.GetKeyUp(KeyCode.Z))
        {
            if (Camera.main.orthographic == true)
               
                Camera.main.orthographic = false;
            else
                
                Camera.main.orthographic = true;
        }
    }
}
