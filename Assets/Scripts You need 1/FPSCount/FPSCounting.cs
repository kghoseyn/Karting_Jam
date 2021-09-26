using UnityEngine;
using UnityEngine.UI;

public class FPSCounting : MonoBehaviour 
{
	float upInterval = 1.0f;
	float acc = 0.0f; 
	int frames = 0; 
	float t;
	int framerate;
	public Text txt;

	void Update () 
	{
		t -= Time.deltaTime;

		acc += Time.timeScale/Time.deltaTime;
		frames ++;
	 
		if(t <= 0.0f)
		{
			framerate = Mathf.FloorToInt(acc/frames);
			txt.text = framerate.ToString("F0");
			t = upInterval;

			acc = 0.0f;
			frames = 0;
		}	
	}
}
