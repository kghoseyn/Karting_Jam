//Scripts helps you create a moving platform both direction using enumeration -- APEX

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovingPlatform : MonoBehaviour
{
    
    public enum dir { Horizontal, Vertical } // choose options to change to direction
    public dir movement = dir.Horizontal; //normal

    public float dist = 10f; //distance to move
    public float Speed = 3.0f; // moving speed
    private float startPos; //where to start --- not imp in editor

    void Start()
    {
        if (movement == dir.Horizontal)
            startPos = transform.position.x; //horizontal
        else
            startPos = transform.position.y; // vertical
    }

    void Update()
    {
        if (movement == dir.Horizontal)
            transform.position = new Vector3(startPos + Mathf.PingPong(Time.time * Speed, dist), transform.position.y, transform.position.z); //moves and comesback 
        else
            transform.position = new Vector3(transform.position.x, startPos + Mathf.PingPong(Time.time * Speed, dist), transform.position.z); //moves and comesback 
   }



}
