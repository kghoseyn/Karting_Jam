//this script helps you rotate objects in random -- APEX


using UnityEngine;
using System.Collections;

public class RandomRotation : MonoBehaviour {
	public bool rotateX = false;
	public bool rotateY = false;
	public bool rotateZ = false;
	float x;
	float y;
	float z;

	public float minRotation = 0;
	public float maxRotation = 360;

	void Awake() {		
		if(rotateX) {
			x = Random.Range(minRotation, maxRotation);
		}
		else {
			x = transform.localEulerAngles.x;
		}
		
		if(rotateY) {
			y = Random.Range(minRotation, maxRotation);
		}
		else {
			y = transform.localEulerAngles.y;
		}
		
		if(rotateZ) {
			z = Random.Range(minRotation, maxRotation);
		}
		else {
			z = transform.localEulerAngles.z;
		}
		
		transform.localEulerAngles = new Vector3(x, y, z);
	}
}
