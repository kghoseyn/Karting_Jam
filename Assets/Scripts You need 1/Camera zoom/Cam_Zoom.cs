using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cam_Zoom : MonoBehaviour
{
    void Update()
    {
        if (Input.GetAxis("Mouse ScrollWheel") < 0) // zoom in
        {
            if (Camera.main.fieldOfView <= 125)
                Camera.main.fieldOfView += 5;

        }
        if (Input.GetAxis("Mouse ScrollWheel") > 0) // zoom out
        {

            if (Camera.main.fieldOfView > 5)
                Camera.main.fieldOfView -= 5;
        }
    }
}
