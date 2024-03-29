﻿//// Simplified Bumped shader. Differences from regular Bumped one:
// - Normalmap uses Tiling/Offset of the Base texture
// - fully supports only 1 directional light. Other lights can affect it, but it will be per-vertex/SH.
// - No Main Color

Shader "Camo/Mobile/Bumped" 
{
	Properties 
	{
		// Main
		_MainTex("Albedo (RGB) Transparency (A)", 2D) = "white" {}

		// Camo
		_CamoBlackTint("Camo Pattern Black Tint", Color) = (0.41, 0.41, 0.21, 1.0)
		_CamoRedTint("Camo Pattern Red Tint", Color) = (0.19, 0.20, 0.13, 1.0)
		_CamoGreenTint("Camo Pattern Green Tint", Color) = (0.75, 0.64, 0.31, 1.0)
		_CamoBlueTint("Camo Pattern Blue Tint", Color) = (0.34, 0.23, 0.10, 1.0)
		_CamoPatternMap("Camo Pattern (RGB)", 2D) = "black" {}
		[KeywordEnum(UV1, UV2)] _UV_CHANNEL ("Pattern UV-Channel", Float) = 0

		// Normal
		[NoScaleOffset] _BumpMap("Normal (RGB)", 2D) = "bump" {}
	}

	SubShader 
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 250
		
		CGPROGRAM
		#pragma surface surf Lambert noforwardadd
		#pragma shader_feature _UV_CHANNEL_UV1 _UV_CHANNEL_UV2

		// Main
		sampler2D _MainTex;

		// Camo
		fixed4 _CamoBlackTint;
		fixed4 _CamoRedTint;
		fixed4 _CamoGreenTint;
		fixed4 _CamoBlueTint;
		sampler2D _CamoPatternMap;

		// Normal
		sampler2D _BumpMap;

		struct Input 
		{
			fixed2 uv_MainTex;

			#if _UV_CHANNEL_UV1
				fixed2 uv_CamoPatternMap;
			#else
				fixed2 uv2_CamoPatternMap;
			#endif
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			// Textures
			fixed4 main = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 bump = tex2D(_BumpMap, IN.uv_MainTex);

			#if _UV_CHANNEL_UV1
				fixed4 camoPattern = tex2D(_CamoPatternMap, IN.uv_CamoPatternMap);
			#else
				fixed4 camoPattern = tex2D(_CamoPatternMap, IN.uv2_CamoPatternMap);
			#endif

			// Camo 
			fixed4 camo = lerp(_CamoBlackTint, _CamoRedTint, camoPattern.r);
			camo = lerp(camo, _CamoGreenTint, camoPattern.g);
			camo = lerp(camo, _CamoBlueTint, camoPattern.b);

			// Albedo
			o.Albedo = lerp(main, camo, main.a * camoPattern.a);

			// Normal
			o.Normal = UnpackNormal(bump);

			// Alpha
			o.Alpha = main.a;
		}
	
		ENDCG
	} 

	FallBack "Mobile/VertexLit"
}
