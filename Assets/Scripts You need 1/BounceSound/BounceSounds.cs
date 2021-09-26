using UnityEngine;

public class BounceSounds : MonoBehaviour
{
    public AudioClip[] clips;
    public AudioSource src;

    void OnCollisionEnter(Collision collision)
    {
        Bounce();
    }

    void Bounce()
    {
        src.clip = clips[Random.Range(0, clips.Length)];
        src.volume = 0.8f;
        src.Play();
    }
}