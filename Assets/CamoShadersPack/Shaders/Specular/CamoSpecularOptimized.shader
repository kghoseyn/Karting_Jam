﻿//// Optimized Camo Specular Opaque shader. Differences from regular Camo Specular Opaque one:
// - All maps uses Tiling/Offset of the Base texture
// - No Main Color

Shader "Camo/Specular/Optimized" 
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
		_CamoPatternMap("Camo Pattern (RGB) Mask (A)", 2D) = "black" {}
		[KeywordEnum(UV1, UV2)] _UV_CHANNEL ("Pattern UV-Channel", Float) = 0

		// Specular and Glossiness
		_SpecColor("Specular Color", Color) = (0.2, 0.2, 0.2, 1.0)
		_Glossiness("Smoothness", Range(0.0, 1.0)) = 0.5
		[NoScaleOffset] _SpecGlossMap("Specular Color (RGB) Smoothness (A)", 2D) = "white" {}

		// Normal and Occlusion
		[NoScaleOffset] _BumpMap("Normal (RGB)", 2D) = "bump" {}
		[NoScaleOffset] _OcclusionMap("Occlusion (G)", 2D) = "white" {}
	}

	SubShader 
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 400
		
		CGPROGRAM
		#pragma surface surf StandardSpecular fullforwardshadows
		#pragma target 3.0
		#pragma shader_feature _UV_CHANNEL_UV1 _UV_CHANNEL_UV2

		// Main
		sampler2D _MainTex;

		// Camo
		fixed4 _CamoBlackTint;
		fixed4 _CamoRedTint;
		fixed4 _CamoGreenTint;
		fixed4 _CamoBlueTint;
		sampler2D _CamoPatternMap;

		// Specular and Glossiness 
		fixed _Glossiness;
		sampler2D _SpecGlossMap;

		// Normal and Occlusion
		sampler2D _BumpMap;
		sampler2D _OcclusionMap;

		struct Input 
		{
			fixed2 uv_MainTex;
			
			#if _UV_CHANNEL_UV1
				fixed2 uv_CamoPatternMap;
			#else
				fixed2 uv2_CamoPatternMap;
			#endif
		};

		void surf(Input IN, inout SurfaceOutputStandardSpecular o)
		{
			// Textures
			fixed4 main = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 specGloss = tex2D(_SpecGlossMap, IN.uv_MainTex);
			fixed4 bump = tex2D(_BumpMap, IN.uv_MainTex);
			fixed4 occlusion = tex2D(_OcclusionMap, IN.uv_MainTex);

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
		
			// Specular and Glossiness 
			o.Specular = specGloss.rgb * _SpecColor.rgb;
			o.Smoothness = specGloss.a * _Glossiness;

			// Normal and Occlusion
			o.Normal = UnpackNormal(bump);
			o.Occlusion = occlusion.g;

			// Alpha
			o.Alpha = main.a;
		}
	
		ENDCG
	} 

	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 400

		CGPROGRAM
		#pragma surface surf BlinnPhong
		#pragma shader_feature _UV_CHANNEL_UV1 _UV_CHANNEL_UV2

		// Main
		sampler2D _MainTex;

		// Camo
		fixed4 _CamoBlackTint;
		fixed4 _CamoRedTint;
		fixed4 _CamoGreenTint;
		fixed4 _CamoBlueTint;
		sampler2D _CamoPatternMap;

		// Specular and Glossiness 
		fixed _Glossiness;
		sampler2D _SpecGlossMap;

		// Normal and Occlusion
		sampler2D _BumpMap;
		sampler2D _OcclusionMap;

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
			fixed4 specGloss = tex2D(_SpecGlossMap, IN.uv_MainTex);
			fixed4 bump = tex2D(_BumpMap, IN.uv_MainTex);
			fixed4 occlusion = tex2D(_OcclusionMap, IN.uv_MainTex);

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
			o.Albedo = lerp(main, camo, main.a * camoPattern.a) * occlusion.g;

			// Specular and Glossiness 
			o.Specular = specGloss.rgb * _SpecColor.rgb;
			o.Gloss = specGloss.a * _Glossiness;

			// Normal
			o.Normal = UnpackNormal(bump);

			// Alpha
			o.Alpha = main.a;
		}

		ENDCG
	}

	Fallback "Legacy Shaders/VertexLit"
}
