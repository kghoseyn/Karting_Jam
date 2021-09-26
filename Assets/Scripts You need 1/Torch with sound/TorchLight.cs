using UnityEngine;

public class TorchLight : MonoBehaviour
{
    public Light linkedLight;
    public AudioClip snd_on; // plays when light is on

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F))
        {
            linkedLight.enabled = !linkedLight.enabled;
            GetComponent<AudioSource>().PlayOneShot(snd_on);
        }
    }

    void LightOff()
    {
        linkedLight.enabled = false;
    }
}