using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerEvents : MonoBehaviour
{

	public Light red_light;
	public GameObject obj;
	public AudioClip clip;
	

	void OnTriggerEnter(Collider other)
	{

		if (other.CompareTag("Player"))
			//Application.loadedLevel(scenename_here);
			red_light.enabled = !red_light.enabled;
		    Destroy(obj);
		    GetComponent<AudioSource>().PlayOneShot(clip);

	}

}
