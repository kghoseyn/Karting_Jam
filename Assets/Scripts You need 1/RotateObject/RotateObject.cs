using UnityEngine;
using System.Collections;

public class RotateObject : MonoBehaviour
{
	public float rotatespeed = 10.0f;

	
	void Start()
	{
		transform.Rotate(new Vector3(0, Random.Range(0.0f, 360.0f), 0));
	}

	
	void Update()
	{
		transform.Rotate(new Vector3(0, rotatespeed * Time.deltaTime, 0));
	}
}
