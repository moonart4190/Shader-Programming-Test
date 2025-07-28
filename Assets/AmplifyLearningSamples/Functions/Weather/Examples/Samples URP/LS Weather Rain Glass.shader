// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LS/Weather/Rain Glass"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[LS_DrawerCategory(SURFACE SETTINGS,true,_Cull,0,0)] _CATEGORY_SURFACESETTINGS( "CATEGORY_SURFACE SETTINGS", Float ) = 1
		[Enum(Front,2,Back,1,Both,0)] _Cull( "Render Face", Int ) = 2
		[LS_DrawerCategorySpace(10)] _SPACE_SURFACESETTINGS( "SPACE_SURFACE SETTINGS", Float ) = 0
		[LS_DrawerCategory(REFRACTION,true,_Ior,0,0)] _CATEGORY_REFRACTION( "CATEGORY_REFRACTION", Float ) = 1
		_Ior( "Index of Refraction", Range( 0, 2.5 ) ) = 0.01
		[HDR] _TransmittanceColor( "Transmittance Color", Color ) = ( 0.8235294, 0.8235294, 0.8235294, 0 )
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_REFRACTION( "CATEGORYSPACE_REFRACTION", Float ) = 0
		[LS_DrawerCategory(SURFACE INPUTS,true,_Brightness,0,0)] _CATEGORY_SURFACEINPUTS( "CATEGORY_SURFACE INPUTS", Float ) = 1
		_GlassOpacity( "Opacity", Range( 0, 1 ) ) = 0.85
		_BaseColor( "Base Color", Color ) = ( 0.4745098, 0.4745098, 0.4745098, 0 )
		_Brightness( "Brightness", Range( 0, 2 ) ) = 1
		[Header(NORMAL)][Normal][LS_DrawerTextureSingleLine][Space(10)] _BumpMap( "Normal Map", 2D ) = "bump" {}
		[LS_DrawerTextureScaleOffset] _BumpMap_ST( "Main UVs", Vector ) = ( 1, 1, 0, 0 )
		_BumpScale( "Normal Scale", Float ) = 1
		[Header(SMOOTHNESS)][LS_DrawerTextureSingleLine][Space(10)] _SmoothnessMap( "Smoothness Map", 2D ) = "white" {}
		[LS_DrawerTextureScaleOffset] _SmoothnessMap_ST( "Main UVs", Vector ) = ( 1, 1, 0, 0 )
		_SmoothnessStrength( "Smoothness Strength", Range( 0, 1 ) ) = 0.75
		[Header(SPECULAR)][LS_DrawerToggleLeft] _SpecularEnable( "ENABLE SPECULAR", Float ) = 0
		_SpecularColor( "Specular Color", Color ) = ( 0.2, 0.2, 0.2, 0 )
		_SpecularStrengthDielectricIOR( "Specular Strength Dielectric IOR", Range( 1, 2.5 ) ) = 1.1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_SURFACEINPUTS( "CATEGORYSPACE_SURFACE INPUTS", Float ) = 0
		[LS_DrawerCategory(COAT MASK,true,_ClearCoat,0,0)] _CATEGORY_COATMASK( "CATEGORY_COATMASK", Float ) = 1
		[LS_DrawerToggleLeft] _ClearCoat( "ENABLE COAT MASK", Float ) = 0
		[LS_DrawerTextureSingleLine] _ClearCoatMap( "Clear Coat Map", 2D ) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _ClearCoatUVMapping( "UV Set", Float ) = 0
		[LS_DrawerTextureScaleOffset] _ClearCoatMap_ST( "Clear Coat UVs", Vector ) = ( 1, 1, 0, 0 )
		_ClearCoatMask( "Clear Coat Mask", Range( 0, 1 ) ) = 0.75
		_ClearCoatSmoothness( "Clear Coat Smoothness", Range( 0, 1 ) ) = 0.95
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_COATMASK( "CATEGORYSPACE_COATMASK", Float ) = 0
		[LS_DrawerCategory(RAIN,true,_ENABLERAIN,0,0)] _CATEGORY_RAIN( "CATEGORY_RAIN", Float ) = 0
		[LS_DrawerToggleLeft] _ENABLERAIN( "ENABLE RAIN", Float ) = 1
		_GlobalRainIntensity( "Global Rain Intensity", Float ) = 1
		_GlobalRainWetness( "Global Rain Wetness", Float ) = 1
		_GlobalRainWindDirection( "Global Rain Wind Direction", Range( 0, 360 ) ) = 1
		[Header(RAIN DROP)][LS_DrawerToggleLeft] _ENABLEDROPS( "ENABLE DROPS", Float ) = 1
		[Space(5)][LS_DrawerTextureSingleLine] _RainDrop( "Rain Drop", 2D ) = "white" {}
		[LS_DrawerTextureScaleOffset] _RainDrop_ST( "Tilling Offset", Vector ) = ( 10, 10, 0, 0 )
		_RainDropNormalScale( "Rain Drop Normal Scale", Float ) = 1
		[Enum(Flip,0,Mirror,1,None,2)] _RainDropNormalMode( "Normal Mode", Float ) = 2
		_RainDropStaticScale( "Rain Drop Static Scale", Range( 0, 1 ) ) = 0.75
		_RainDropSpeed( "Rain Drop Speed", Float ) = 0.7
		_RainDropSmoothness( "Rain Drop Smoothness", Range( 0, 1 ) ) = 1
		[Header(RAIN DRIP)][LS_DrawerToggleLeft] _ENABLEDRIPS( "ENABLE DRIPS", Float ) = 1
		[Space(5)][LS_DrawerTextureSingleLine] _RainDripMask( "Rain Drip Mask", 2D ) = "white" {}
		[Toggle] _RainDripMaskInvert( "Invert Rain Drip Mask", Float ) = 0
		[LS_DrawerTextureSingleLine] _RainDrip( "Rain Drip", 2D ) = "white" {}
		[LS_DrawerTextureScaleOffset] _RainDrip_ST( "Tilling Offset", Vector ) = ( 2, 2, 0, 0 )
		_RainDripIntensity( "Rain Drip Intensity", Float ) = 1
		_RainDripNormalScale( "Rain Drip Normal Scale", Float ) = 1
		_RainDripSpeed( "Rain Drip Speed", Float ) = 1
		_RainDripSmoothness( "Rain Drip Smoothness", Range( 0, 1 ) ) = 1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_RAIN( "CATEGORYSPACE_RAIN", Float ) = 0
		[LS_DrawerCategory(RAIN MASK,true,_EnableRainMask,0,0)] _CATEGORY_RAINMASK( "CATEGORY_RAIN MASK", Float ) = 0
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_RAINMASK( "CATEGORYSPACE_RAIN MASK", Float ) = 0


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1
		[HideInInspector][ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1
		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
	}

	SubShader
	{
		LOD 0

		

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="Transparent" "UniversalMaterialType"="Lit" }

		Cull [_Cull]
		ZWrite Off
		ZTest LEqual
		Offset 0 , 0
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForwardOnly" }

			Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define shader_feature_local_fragment _ _CLEARCOAT
			#define _CLEARCOAT 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS

			
            #pragma multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX
		

			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION

			

			
			#pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
           

			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ _FORWARD_PLUS

			

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_FORWARD

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			
			#if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					float4 texcoord1 : TEXCOORD1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					float4 texcoord2 : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				half4 tangentWS : TEXCOORD2;
				float4 lightmapUVOrVertexSH : TEXCOORD3;
				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					half4 fogFactorAndVertexLight : TEXCOORD4;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD5;
				#endif
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_SmoothnessMap);
			SAMPLER(sampler_SmoothnessMap);
			TEXTURE2D(_ClearCoatMap);
			SAMPLER(sampler_ClearCoatMap);


			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 _NormalModefloat3switch( float m_switch, float3 m_Flip, float3 m_Mirror, float3 m_None )
			{
				if(m_switch ==0)
					return m_Flip;
				else if(m_switch ==1)
					return m_Mirror;
				else if(m_switch ==2)
					return m_None;
				else
				return float3(0,0,0);
			}
			
			float2 float2switchUVMode3404_g61178( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
			{
				if(m_switch ==0)
					return m_UV0;
				else if(m_switch ==1)
					return m_UV1;
				else if(m_switch ==2)
					return m_UV2;
				else if(m_switch ==3)
					return m_UV3;
				else
				return float2(0,0);
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				output.ase_texcoord6.xy = input.texcoord.xy;
				output.ase_texcoord6.zw = input.texcoord1.xy;
				output.ase_texcoord7.xy = input.texcoord2.xy;
				output.ase_texcoord7.zw = input.ase_texcoord3.xy;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif
				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(input.texcoord1, unity_LightmapST, output.lightmapUVOrVertexSH.xy);
				#else
					OUTPUT_SH(normalInput.normalWS.xyz, output.lightmapUVOrVertexSH.xyz);
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					output.dynamicLightmapUV.xy = input.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					output.lightmapUVOrVertexSH.zw = input.texcoord.xy;
					output.lightmapUVOrVertexSH.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					output.fogFactorAndVertexLight = 0;
					#if defined(ASE_FOG) && !defined(_FOG_FRAGMENT)
						output.fogFactorAndVertexLight.x = ComputeFogFactor(vertexInput.positionCS.z);
					#endif
					#ifdef _ADDITIONAL_LIGHTS_VERTEX
						half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );
						output.fogFactorAndVertexLight.yzw = vertexLight;
					#endif
				#endif

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				output.normalWS = normalInput.normalWS;
				output.tangentWS = float4( normalInput.tangentWS, ( input.tangentOS.w > 0.0 ? 1.0 : -1.0 ) * GetOddNegativeScale() );
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					float4 texcoord1 : TEXCOORD1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					float4 texcoord2 : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.texcoord = input.texcoord;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					output.texcoord1 = input.texcoord1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					output.texcoord2 = input.texcoord2;
				#endif
				output.texcoord = input.texcoord;
				output.ase_texcoord3 = input.ase_texcoord3;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					output.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					output.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				#endif
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag ( PackedVaryings input
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						, bool ase_vface : SV_IsFrontFace ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					float4 shadowCoord = TransformWorldToShadowCoord( input.positionWS );
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				// @diogo: mikktspace compliant
				float renormFactor = 1.0 / max( FLT_MIN, length( input.normalWS ) );

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float3 ViewDirWS = GetWorldSpaceNormalizeViewDir( PositionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 TangentWS = input.tangentWS.xyz * renormFactor;
				float3 BitangentWS = cross( input.normalWS, input.tangentWS.xyz ) * input.tangentWS.w * renormFactor;
				float3 NormalWS = input.normalWS * renormFactor;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (input.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					BitangentWS = cross(NormalWS, -TangentWS);
				#endif

				float3 temp_output_2628_0_g61175 = ( saturate( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) ) * 0.2 );
				float temp_output_386_0_g61175 = ( 1.0 - saturate( max( 0.5 , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float temp_output_2631_0_g61175 = saturate( max( temp_output_386_0_g61175 , min( _GlobalRainWetness , 0.94 ) ) );
				float3 lerpResult4144_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , temp_output_2628_0_g61175 , ( ( _GlobalRainWetness * 0.85 ) * temp_output_2631_0_g61175 ));
				float Wind_Direction2547_g61175 = _GlobalRainWindDirection;
				float temp_output_4713_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 temp_output_183_0_g61175 = (PositionWS).yx;
				float2 lerpResult4672_g61175 = lerp( temp_output_183_0_g61175 , ( 1.0 - temp_output_183_0_g61175 ) , _RainDripMaskInvert);
				float2 break4707_g61175 = ( lerpResult4672_g61175 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4717_g61175 = (float2(( ( temp_output_4713_0_g61175 * break4707_g61175.x ) + ( temp_output_4712_0_g61175 * break4707_g61175.y ) ) , ( ( temp_output_4713_0_g61175 * break4707_g61175.y ) - ( temp_output_4712_0_g61175 * break4707_g61175.x ) )));
				float Permeability387_g61175 = temp_output_386_0_g61175;
				float lerpResult193_g61175 = lerp( 0.2 , 0.03 , Permeability387_g61175);
				float lerpResult194_g61175 = lerp( 0.0 , 0.0125 , Permeability387_g61175);
				float temp_output_4405_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61175 = ( input.ase_texcoord6.xy - _Anchor );
				float temp_output_4406_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4415_g61175 = (float2(( ( temp_output_4405_0_g61175 * break4413_g61175.x ) + ( temp_output_4406_0_g61175 * break4413_g61175.y ) ) , ( ( temp_output_4405_0_g61175 * break4413_g61175.y ) - ( temp_output_4406_0_g61175 * break4413_g61175.x ) )));
				float4 tex2DNode172_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float lerpResult185_g61175 = lerp( lerpResult193_g61175 , lerpResult194_g61175 , tex2DNode172_g61175.a);
				float Time1591_g61175 = _TimeParameters.x;
				float temp_output_186_0_g61175 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61175 + ( lerpResult185_g61175 * ( ( Time1591_g61175 * _RainDripSpeed ) + tex2DNode172_g61175.a ) ) ) ).r * tex2DNode172_g61175.b );
				float3 temp_cast_0 = (0.5).xxx;
				float3 break3837_g61175 = ( abs( NormalWS ) - temp_cast_0 );
				float smoothstepResult3838_g61175 = smoothstep( 0.1 , 1.0 , ( break3837_g61175.z + 0.5 ));
				float ENABLE_RAIN363_g61175 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61175 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61175 );
				float Mask_Vertical_Z3918_g61175 = ( smoothstepResult3838_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3929_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_Z3918_g61175);
				float smoothstepResult3864_g61175 = smoothstep( 0.0 , 1.0 , ( break3837_g61175.x + 0.45 ));
				float Mask_Vertical_X3920_g61175 = ( smoothstepResult3864_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3930_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_X3920_g61175);
				float smoothstepResult3839_g61175 = smoothstep( 0.0 , 1.0 , ( -break3837_g61175.y + 0.45 ));
				float Mask_Vertical_Y3919_g61175 = ( smoothstepResult3839_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3931_g61175 = lerp( lerpResult3929_g61175 , ( lerpResult3929_g61175 + lerpResult3930_g61175 ) , Mask_Vertical_Y3919_g61175);
				float temp_output_1689_0_g61175 = ( lerpResult3931_g61175 * _RainDripIntensity );
				float lerpResult1663_g61175 = lerp( 0.0 , temp_output_1689_0_g61175 , _ENABLEDRIPS);
				float Drips3491_g61175 = saturate( lerpResult1663_g61175 );
				float3 lerpResult3462_g61175 = lerp( lerpResult4144_g61175 , temp_output_2628_0_g61175 , saturate( ( temp_output_2631_0_g61175 * Drips3491_g61175 ) ));
				float3 lerpResult3546_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , lerpResult3462_g61175 , Global_Rain_Intensity1484_g61175);
				float2 temp_output_1355_0_g61175 = ( ( input.ase_texcoord6.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61175, ddx( temp_output_1355_0_g61175 ), ddy( temp_output_1355_0_g61175 ) );
				float temp_output_3696_0_g61175 = ( ( tex2DNode257_g61175.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61175 = ( frac( ( tex2DNode257_g61175.b - ( Time1591_g61175 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61175 ) );
				float lerpResult4471_g61175 = lerp( ( temp_output_1818_0_g61175 + saturate( -temp_output_3696_0_g61175 ) ) , temp_output_1818_0_g61175 , _RainDropStaticScale);
				float temp_output_3691_0_g61175 = ( lerpResult4471_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult1664_g61175 = lerp( 0.0 , (temp_output_3691_0_g61175*2.0 + -1.0) , _ENABLEDROPS);
				float Drops3492_g61175 = saturate( lerpResult1664_g61175 );
				float temp_output_3457_0_g61175 = saturate( ( temp_output_2631_0_g61175 * Drops3492_g61175 ) );
				float3 lerpResult3399_g61175 = lerp( lerpResult4144_g61175 , temp_output_2628_0_g61175 , temp_output_3457_0_g61175);
				float3 lerpResult3547_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , lerpResult3399_g61175 , Global_Rain_Intensity1484_g61175);
				float3 weightedBlendVar3481_g61175 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend3481_g61175 = ( weightedBlendVar3481_g61175.x*temp_output_2628_0_g61175 + weightedBlendVar3481_g61175.y*lerpResult3546_g61175 + weightedBlendVar3481_g61175.z*lerpResult3547_g61175 );
				float3 lerpResult799_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , weightedBlend3481_g61175 , ENABLE_RAIN363_g61175);
				
				float2 temp_output_3808_0_g61174 = ( (_BumpMap_ST).xy / 1.0 );
				float2 _Vector10 = float2(0.5,0.5);
				float3 unpack268_g61174 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, ( ( ( input.ase_texcoord6.xy * temp_output_3808_0_g61174 ) + (_BumpMap_ST).zw ) - ( ( temp_output_3808_0_g61174 * _Vector10 ) - _Vector10 ) ) ), _BumpScale );
				unpack268_g61174.z = lerp( 1, unpack268_g61174.z, saturate(_BumpScale) );
				float3 temp_output_20_0_g61175 = unpack268_g61174;
				float2 _Vector4 = float2(1,1);
				float4 appendResult3784_g61175 = (float4(1.0 , tex2DNode172_g61175.r , 0.0 , tex2DNode172_g61175.g));
				float3 unpack3786_g61175 = UnpackNormalScale( appendResult3784_g61175, _RainDripNormalScale );
				unpack3786_g61175.z = lerp( 1, unpack3786_g61175.z, saturate(_RainDripNormalScale) );
				float3 normalizeResult3787_g61175 = ASESafeNormalize( unpack3786_g61175 );
				float3 lerpResult588_g61175 = lerp( temp_output_20_0_g61175 , normalizeResult3787_g61175 , temp_output_1689_0_g61175);
				float2 weightedBlendVar1635_g61175 = _Vector4;
				float3 weightedBlend1635_g61175 = ( weightedBlendVar1635_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1635_g61175.y*lerpResult588_g61175 );
				float ENABLE_DRIPS1644_g61175 = _ENABLEDRIPS;
				float3 lerpResult1640_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1635_g61175 , ENABLE_DRIPS1644_g61175);
				float4 appendResult3767_g61175 = (float4(1.0 , tex2DNode257_g61175.r , 0.0 , tex2DNode257_g61175.g));
				float3 unpack3768_g61175 = UnpackNormalScale( appendResult3767_g61175, _RainDropNormalScale );
				unpack3768_g61175.z = lerp( 1, unpack3768_g61175.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g61175 = ASESafeNormalize( unpack3768_g61175 );
				float m_switch4772_g61175 = _RainDropNormalMode;
				float3 m_Flip4772_g61175 = float3( -1, -1, -1 );
				float3 m_Mirror4772_g61175 = float3( 1, 1, -1 );
				float3 m_None4772_g61175 = float3( 1, 1, 1 );
				float3 local_NormalModefloat3switch4772_g61175 = _NormalModefloat3switch( m_switch4772_g61175 , m_Flip4772_g61175 , m_Mirror4772_g61175 , m_None4772_g61175 );
				float3 switchResult4768_g61175 = (((ase_vface>0)?(normalizeResult3770_g61175):(( normalizeResult3770_g61175 * local_NormalModefloat3switch4772_g61175 ))));
				float3 lerpResult1298_g61175 = lerp( switchResult4768_g61175 , temp_output_20_0_g61175 , (temp_output_3691_0_g61175*2.0 + -1.0));
				float2 weightedBlendVar1637_g61175 = _Vector4;
				float3 weightedBlend1637_g61175 = ( weightedBlendVar1637_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1637_g61175.y*lerpResult1298_g61175 );
				float ENABLE_DROPS1643_g61175 = _ENABLEDROPS;
				float3 lerpResult1641_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1637_g61175 , ENABLE_DROPS1643_g61175);
				float3 weightedBlendVar1305_g61175 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend1305_g61175 = ( weightedBlendVar1305_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1305_g61175.y*lerpResult1640_g61175 + weightedBlendVar1305_g61175.z*lerpResult1641_g61175 );
				float3 lerpResult2879_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1305_g61175 , Global_Rain_Intensity1484_g61175);
				float3 lerpResult790_g61175 = lerp( temp_output_20_0_g61175 , lerpResult2879_g61175 , ENABLE_RAIN363_g61175);
				
				float3 temp_output_3738_0_g61174 = (_SpecularColor).rgb;
				float3 lerpResult3756_g61174 = lerp( float3( 0, 0, 0 ) , saturate( ( temp_output_3738_0_g61174 * ( pow( ( _SpecularStrengthDielectricIOR - 1.0 ) , 2.0 ) / pow( ( _SpecularStrengthDielectricIOR + 1.0 ) , 2.0 ) ) ) ) , _SpecularEnable);
				
				float2 temp_output_3792_0_g61174 = ( (_SmoothnessMap_ST).xy / 1.0 );
				float2 _Vector8 = float2(0.5,0.5);
				float MaskDrips3024_g61175 = temp_output_1689_0_g61175;
				float saferPower3000_g61175 = abs( MaskDrips3024_g61175 );
				float lerpResult2986_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , _RainDripSmoothness , round( pow( saferPower3000_g61175 , 0.1 ) ));
				float lerpResult3013_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult2986_g61175 , Drips3491_g61175);
				float lerpResult3016_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult3013_g61175 , ENABLE_DRIPS1644_g61175);
				float lerpResult3253_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult3016_g61175 , Global_Rain_Intensity1484_g61175);
				float smoothstepResult3849_g61175 = smoothstep( 0.0 , 1.0 , ( NormalWS.y + 0.02 ));
				float Mask_Horizontal1481_g61175 = ( smoothstepResult3849_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3963_g61175 = lerp( 0.0001 , temp_output_3691_0_g61175 , Mask_Vertical_Z3918_g61175);
				float lerpResult3962_g61175 = lerp( 0.0001 , temp_output_3691_0_g61175 , Mask_Vertical_X3920_g61175);
				float lerpResult3964_g61175 = lerp( lerpResult3963_g61175 , ( lerpResult3963_g61175 + lerpResult3962_g61175 ) , Mask_Vertical_Y3919_g61175);
				float MaskDrops1847_g61175 = (( ( temp_output_3691_0_g61175 * Mask_Horizontal1481_g61175 ) + lerpResult3964_g61175 )*2.0 + -1.0);
				float saferPower1848_g61175 = abs( MaskDrops1847_g61175 );
				float lerpResult2673_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , _RainDropSmoothness , pow( saferPower1848_g61175 , 1E-05 ));
				float lerpResult2949_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult2673_g61175 , Drops3492_g61175);
				float lerpResult2649_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult2949_g61175 , ENABLE_DROPS1643_g61175);
				float lerpResult2869_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult2649_g61175 , Global_Rain_Intensity1484_g61175);
				float3 weightedBlendVar3316_g61175 = float3( 0.5, 0.5, 0.5 );
				float weightedBlend3316_g61175 = ( weightedBlendVar3316_g61175.x*( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x + weightedBlendVar3316_g61175.y*lerpResult3253_g61175 + weightedBlendVar3316_g61175.z*lerpResult2869_g61175 );
				float lerpResult801_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , weightedBlend3316_g61175 , ENABLE_RAIN363_g61175);
				
				float lerpResult308_g61175 = lerp( 0.5 , 0.5 , ( Drips3491_g61175 + Drops3492_g61175 ));
				float lerpResult2871_g61175 = lerp( 0.5 , lerpResult308_g61175 , Global_Rain_Intensity1484_g61175);
				float lerpResult802_g61175 = lerp( 0.5 , lerpResult2871_g61175 , ENABLE_RAIN363_g61175);
				
				float m_switch3404_g61178 = _ClearCoatUVMapping;
				float2 m_UV03404_g61178 = input.ase_texcoord6.xy;
				float2 m_UV13404_g61178 = input.ase_texcoord6.zw;
				float2 m_UV23404_g61178 = input.ase_texcoord7.xy;
				float2 m_UV33404_g61178 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode3404_g61178 = float2switchUVMode3404_g61178( m_switch3404_g61178 , m_UV03404_g61178 , m_UV13404_g61178 , m_UV23404_g61178 , m_UV33404_g61178 );
				float2 appendResult3396_g61178 = (float2(_ClearCoatMap_ST.x , _ClearCoatMap_ST.y));
				float2 appendResult3397_g61178 = (float2(_ClearCoatMap_ST.z , _ClearCoatMap_ST.w));
				float4 tex2DNode3387_g61178 = SAMPLE_TEXTURE2D( _ClearCoatMap, sampler_ClearCoatMap, ( ( localfloat2switchUVMode3404_g61178 * appendResult3396_g61178 ) + appendResult3397_g61178 ) );
				float temp_output_3752_0_g61178 = ( _ClearCoat + ( ( _CATEGORY_COATMASK + _CATEGORYSPACE_COATMASK ) * 0.0 ) );
				float lerpResult3385_g61178 = lerp( 0.0 , ( tex2DNode3387_g61178.r * _ClearCoatMask ) , temp_output_3752_0_g61178);
				
				float lerpResult3409_g61178 = lerp( 0.0 , ( tex2DNode3387_g61178.g * _ClearCoatSmoothness ) , temp_output_3752_0_g61178);
				

				float3 BaseColor = lerpResult799_g61175;
				float3 Normal = lerpResult790_g61175;
				float3 Specular = lerpResult3756_g61174;
				float Metallic = 0;
				float Smoothness = lerpResult801_g61175;
				float Occlusion = lerpResult802_g61175;
				float3 Emission = 0;
				float Alpha = ( 1.0 - _GlassOpacity );
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = (_TransmittanceColor).rgb;
				float RefractionIndex = ( 1.0 - ( _Ior + ( ( _CATEGORY_REFRACTION + _CATEGORYSPACE_REFRACTION ) * 0.0 ) ) );
				float3 Transmission = 1;
				float3 Translucency = 1;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = ClipPos.z;
				#endif

				#ifdef _CLEARCOAT
					float CoatMask = lerpResult3385_g61178;
					float CoatSmoothness = lerpResult3409_g61178;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_CHANGES_WORLD_POS)
					ShadowCoord = TransformWorldToShadowCoord( PositionWS );
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = PositionWS;
				inputData.positionCS = float4( input.positionCS.xy, ClipPos.zw / ClipPos.w );
				inputData.normalizedScreenSpaceUV = ScreenPosNorm.xy;
				inputData.viewDirectionWS = ViewDirWS;
				inputData.shadowCoord = ShadowCoord;

				#ifdef _NORMALMAP
						#if _NORMAL_DROPOFF_TS
							inputData.normalWS = TransformTangentToWorld(Normal, half3x3(TangentWS, BitangentWS, NormalWS));
						#elif _NORMAL_DROPOFF_OS
							inputData.normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							inputData.normalWS = Normal;
						#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = NormalWS;
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = InitializeInputDataFog(float4(inputData.positionWS, 1.0), input.fogFactorAndVertexLight.x);
				#endif
				#ifdef _ADDITIONAL_LIGHTS_VERTEX
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = input.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, input.dynamicLightmapUV.xy, SH, inputData.normalWS);
				#else
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, SH, inputData.normalWS);
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.dynamicLightmapUV.xy;
					#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				SurfaceData surfaceData;
				surfaceData.albedo              = BaseColor;
				surfaceData.metallic            = saturate(Metallic);
				surfaceData.specular            = Specular;
				surfaceData.smoothness          = saturate(Smoothness),
				surfaceData.occlusion           = Occlusion,
				surfaceData.emission            = Emission,
				surfaceData.alpha               = saturate(Alpha);
				surfaceData.normalTS            = Normal;
				surfaceData.clearCoatMask       = 0;
				surfaceData.clearCoatSmoothness = 1;

				#ifdef _CLEARCOAT
					surfaceData.clearCoatMask       = saturate(CoatMask);
					surfaceData.clearCoatSmoothness = saturate(CoatSmoothness);
				#endif

				#ifdef _DBUFFER
					ApplyDecalToSurfaceData(input.positionCS, surfaceData, inputData);
				#endif

				#ifdef ASE_LIGHTING_SIMPLE
					half4 color = UniversalFragmentBlinnPhong( inputData, surfaceData);
				#else
					half4 color = UniversalFragmentPBR( inputData, surfaceData);
				#endif

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;

					#define SUM_LIGHT_TRANSMISSION(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 transmission = max( 0, -dot( inputData.normalWS, Light.direction ) ) * atten * Transmission;\
						color.rgb += BaseColor * transmission;

					SUM_LIGHT_TRANSMISSION( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_FORWARD_PLUS
							for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSMISSION( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSMISSION( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_TRANSLUCENCY
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#define SUM_LIGHT_TRANSLUCENCY(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 lightDir = Light.direction + inputData.normalWS * normal;\
						half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );\
						half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;\
						color.rgb += BaseColor * translucency * strength;

					SUM_LIGHT_TRANSLUCENCY( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_FORWARD_PLUS
							for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSLUCENCY( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSLUCENCY( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_REFRACTION
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( NormalWS,0 ) ).xyz * ( 1.0 - dot( NormalWS, ViewDirWS ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3(0,0,0), inputData.fogCoord);
					#else
						color.rgb = MixFog(color.rgb, inputData.fogCoord);
					#endif
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = DeviceDepth;
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM

			

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			

			#pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			float3 _LightDirection;
			float3 _LightPosition;

			
			PackedVaryings VertexFunction( Attributes input )
			{
				PackedVaryings output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				float3 positionWS = TransformObjectToWorld( input.positionOS.xyz );
				float3 normalWS = TransformObjectToWorldDir(input.normalOS);

				#if _CASTING_PUNCTUAL_LIGHT_SHADOW
					float3 lightDirectionWS = normalize(_LightPosition - positionWS);
				#else
					float3 lightDirectionWS = _LightDirection;
				#endif

				float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));

				#if UNITY_REVERSED_Z
					positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#else
					positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#endif

				output.positionCS = positionCS;
				output.positionWS = positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(	PackedVaryings input
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );

				

				float Alpha = ( 1.0 - _GlassOpacity );
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = DeviceDepth;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask R
			AlphaToMask Off

			HLSLPROGRAM

			

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_DEPTHONLY

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			
			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(	PackedVaryings input
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );

				

				float Alpha = ( 1.0 - _GlassOpacity );
				float AlphaClipThreshold = 0.5;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = DeviceDepth;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma shader_feature EDITOR_VISUALIZATION

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				#ifdef EDITOR_VISUALIZATION
					float4 VizUV : TEXCOORD1;
					float4 LightCoord : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			
			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_normalWS = TransformObjectToWorldNormal( input.normalOS );
				output.ase_texcoord4.xyz = ase_normalWS;
				
				output.ase_texcoord3.xy = input.texcoord0.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.zw = 0;
				output.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				#ifdef EDITOR_VISUALIZATION
					float2 VizUV = 0;
					float4 LightCoord = 0;
					UnityEditorVizData(input.positionOS.xyz, input.texcoord0.xy, input.texcoord1.xy, input.texcoord2.xy, VizUV, LightCoord);
					output.VizUV = float4(VizUV, 0, 0);
					output.LightCoord = LightCoord;
				#endif

				output.positionCS = MetaVertexPosition( input.positionOS, input.texcoord1.xy, input.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );
				output.positionWS = TransformObjectToWorld( input.positionOS.xyz );
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;

				float3 temp_output_2628_0_g61175 = ( saturate( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) ) * 0.2 );
				float temp_output_386_0_g61175 = ( 1.0 - saturate( max( 0.5 , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float temp_output_2631_0_g61175 = saturate( max( temp_output_386_0_g61175 , min( _GlobalRainWetness , 0.94 ) ) );
				float3 lerpResult4144_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , temp_output_2628_0_g61175 , ( ( _GlobalRainWetness * 0.85 ) * temp_output_2631_0_g61175 ));
				float Wind_Direction2547_g61175 = _GlobalRainWindDirection;
				float temp_output_4713_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 temp_output_183_0_g61175 = (PositionWS).yx;
				float2 lerpResult4672_g61175 = lerp( temp_output_183_0_g61175 , ( 1.0 - temp_output_183_0_g61175 ) , _RainDripMaskInvert);
				float2 break4707_g61175 = ( lerpResult4672_g61175 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4717_g61175 = (float2(( ( temp_output_4713_0_g61175 * break4707_g61175.x ) + ( temp_output_4712_0_g61175 * break4707_g61175.y ) ) , ( ( temp_output_4713_0_g61175 * break4707_g61175.y ) - ( temp_output_4712_0_g61175 * break4707_g61175.x ) )));
				float Permeability387_g61175 = temp_output_386_0_g61175;
				float lerpResult193_g61175 = lerp( 0.2 , 0.03 , Permeability387_g61175);
				float lerpResult194_g61175 = lerp( 0.0 , 0.0125 , Permeability387_g61175);
				float temp_output_4405_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61175 = ( input.ase_texcoord3.xy - _Anchor );
				float temp_output_4406_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4415_g61175 = (float2(( ( temp_output_4405_0_g61175 * break4413_g61175.x ) + ( temp_output_4406_0_g61175 * break4413_g61175.y ) ) , ( ( temp_output_4405_0_g61175 * break4413_g61175.y ) - ( temp_output_4406_0_g61175 * break4413_g61175.x ) )));
				float4 tex2DNode172_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float lerpResult185_g61175 = lerp( lerpResult193_g61175 , lerpResult194_g61175 , tex2DNode172_g61175.a);
				float Time1591_g61175 = _TimeParameters.x;
				float temp_output_186_0_g61175 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61175 + ( lerpResult185_g61175 * ( ( Time1591_g61175 * _RainDripSpeed ) + tex2DNode172_g61175.a ) ) ) ).r * tex2DNode172_g61175.b );
				float3 ase_normalWS = input.ase_texcoord4.xyz;
				float3 temp_cast_0 = (0.5).xxx;
				float3 break3837_g61175 = ( abs( ase_normalWS ) - temp_cast_0 );
				float smoothstepResult3838_g61175 = smoothstep( 0.1 , 1.0 , ( break3837_g61175.z + 0.5 ));
				float ENABLE_RAIN363_g61175 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61175 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61175 );
				float Mask_Vertical_Z3918_g61175 = ( smoothstepResult3838_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3929_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_Z3918_g61175);
				float smoothstepResult3864_g61175 = smoothstep( 0.0 , 1.0 , ( break3837_g61175.x + 0.45 ));
				float Mask_Vertical_X3920_g61175 = ( smoothstepResult3864_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3930_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_X3920_g61175);
				float smoothstepResult3839_g61175 = smoothstep( 0.0 , 1.0 , ( -break3837_g61175.y + 0.45 ));
				float Mask_Vertical_Y3919_g61175 = ( smoothstepResult3839_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3931_g61175 = lerp( lerpResult3929_g61175 , ( lerpResult3929_g61175 + lerpResult3930_g61175 ) , Mask_Vertical_Y3919_g61175);
				float temp_output_1689_0_g61175 = ( lerpResult3931_g61175 * _RainDripIntensity );
				float lerpResult1663_g61175 = lerp( 0.0 , temp_output_1689_0_g61175 , _ENABLEDRIPS);
				float Drips3491_g61175 = saturate( lerpResult1663_g61175 );
				float3 lerpResult3462_g61175 = lerp( lerpResult4144_g61175 , temp_output_2628_0_g61175 , saturate( ( temp_output_2631_0_g61175 * Drips3491_g61175 ) ));
				float3 lerpResult3546_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , lerpResult3462_g61175 , Global_Rain_Intensity1484_g61175);
				float2 temp_output_1355_0_g61175 = ( ( input.ase_texcoord3.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61175, ddx( temp_output_1355_0_g61175 ), ddy( temp_output_1355_0_g61175 ) );
				float temp_output_3696_0_g61175 = ( ( tex2DNode257_g61175.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61175 = ( frac( ( tex2DNode257_g61175.b - ( Time1591_g61175 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61175 ) );
				float lerpResult4471_g61175 = lerp( ( temp_output_1818_0_g61175 + saturate( -temp_output_3696_0_g61175 ) ) , temp_output_1818_0_g61175 , _RainDropStaticScale);
				float temp_output_3691_0_g61175 = ( lerpResult4471_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult1664_g61175 = lerp( 0.0 , (temp_output_3691_0_g61175*2.0 + -1.0) , _ENABLEDROPS);
				float Drops3492_g61175 = saturate( lerpResult1664_g61175 );
				float temp_output_3457_0_g61175 = saturate( ( temp_output_2631_0_g61175 * Drops3492_g61175 ) );
				float3 lerpResult3399_g61175 = lerp( lerpResult4144_g61175 , temp_output_2628_0_g61175 , temp_output_3457_0_g61175);
				float3 lerpResult3547_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , lerpResult3399_g61175 , Global_Rain_Intensity1484_g61175);
				float3 weightedBlendVar3481_g61175 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend3481_g61175 = ( weightedBlendVar3481_g61175.x*temp_output_2628_0_g61175 + weightedBlendVar3481_g61175.y*lerpResult3546_g61175 + weightedBlendVar3481_g61175.z*lerpResult3547_g61175 );
				float3 lerpResult799_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , weightedBlend3481_g61175 , ENABLE_RAIN363_g61175);
				

				float3 BaseColor = lerpResult799_g61175;
				float3 Emission = 0;
				float Alpha = ( 1.0 - _GlassOpacity );
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = BaseColor;
				metaInput.Emission = Emission;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = input.VizUV.xy;
					metaInput.LightCoord = input.LightCoord;
				#endif

				return UnityMetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			
			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_TRANSFER_INSTANCE_ID( input, output );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float3 ase_normalWS = TransformObjectToWorldNormal( input.normalOS );
				output.ase_texcoord2.xyz = ase_normalWS;
				
				output.ase_texcoord1.xy = input.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord1.zw = 0;
				output.ase_texcoord2.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.ase_texcoord = input.ase_texcoord;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;

				float3 temp_output_2628_0_g61175 = ( saturate( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) ) * 0.2 );
				float temp_output_386_0_g61175 = ( 1.0 - saturate( max( 0.5 , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float temp_output_2631_0_g61175 = saturate( max( temp_output_386_0_g61175 , min( _GlobalRainWetness , 0.94 ) ) );
				float3 lerpResult4144_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , temp_output_2628_0_g61175 , ( ( _GlobalRainWetness * 0.85 ) * temp_output_2631_0_g61175 ));
				float Wind_Direction2547_g61175 = _GlobalRainWindDirection;
				float temp_output_4713_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 temp_output_183_0_g61175 = (PositionWS).yx;
				float2 lerpResult4672_g61175 = lerp( temp_output_183_0_g61175 , ( 1.0 - temp_output_183_0_g61175 ) , _RainDripMaskInvert);
				float2 break4707_g61175 = ( lerpResult4672_g61175 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4717_g61175 = (float2(( ( temp_output_4713_0_g61175 * break4707_g61175.x ) + ( temp_output_4712_0_g61175 * break4707_g61175.y ) ) , ( ( temp_output_4713_0_g61175 * break4707_g61175.y ) - ( temp_output_4712_0_g61175 * break4707_g61175.x ) )));
				float Permeability387_g61175 = temp_output_386_0_g61175;
				float lerpResult193_g61175 = lerp( 0.2 , 0.03 , Permeability387_g61175);
				float lerpResult194_g61175 = lerp( 0.0 , 0.0125 , Permeability387_g61175);
				float temp_output_4405_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61175 = ( input.ase_texcoord1.xy - _Anchor );
				float temp_output_4406_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4415_g61175 = (float2(( ( temp_output_4405_0_g61175 * break4413_g61175.x ) + ( temp_output_4406_0_g61175 * break4413_g61175.y ) ) , ( ( temp_output_4405_0_g61175 * break4413_g61175.y ) - ( temp_output_4406_0_g61175 * break4413_g61175.x ) )));
				float4 tex2DNode172_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float lerpResult185_g61175 = lerp( lerpResult193_g61175 , lerpResult194_g61175 , tex2DNode172_g61175.a);
				float Time1591_g61175 = _TimeParameters.x;
				float temp_output_186_0_g61175 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61175 + ( lerpResult185_g61175 * ( ( Time1591_g61175 * _RainDripSpeed ) + tex2DNode172_g61175.a ) ) ) ).r * tex2DNode172_g61175.b );
				float3 ase_normalWS = input.ase_texcoord2.xyz;
				float3 temp_cast_0 = (0.5).xxx;
				float3 break3837_g61175 = ( abs( ase_normalWS ) - temp_cast_0 );
				float smoothstepResult3838_g61175 = smoothstep( 0.1 , 1.0 , ( break3837_g61175.z + 0.5 ));
				float ENABLE_RAIN363_g61175 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61175 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61175 );
				float Mask_Vertical_Z3918_g61175 = ( smoothstepResult3838_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3929_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_Z3918_g61175);
				float smoothstepResult3864_g61175 = smoothstep( 0.0 , 1.0 , ( break3837_g61175.x + 0.45 ));
				float Mask_Vertical_X3920_g61175 = ( smoothstepResult3864_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3930_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_X3920_g61175);
				float smoothstepResult3839_g61175 = smoothstep( 0.0 , 1.0 , ( -break3837_g61175.y + 0.45 ));
				float Mask_Vertical_Y3919_g61175 = ( smoothstepResult3839_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3931_g61175 = lerp( lerpResult3929_g61175 , ( lerpResult3929_g61175 + lerpResult3930_g61175 ) , Mask_Vertical_Y3919_g61175);
				float temp_output_1689_0_g61175 = ( lerpResult3931_g61175 * _RainDripIntensity );
				float lerpResult1663_g61175 = lerp( 0.0 , temp_output_1689_0_g61175 , _ENABLEDRIPS);
				float Drips3491_g61175 = saturate( lerpResult1663_g61175 );
				float3 lerpResult3462_g61175 = lerp( lerpResult4144_g61175 , temp_output_2628_0_g61175 , saturate( ( temp_output_2631_0_g61175 * Drips3491_g61175 ) ));
				float3 lerpResult3546_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , lerpResult3462_g61175 , Global_Rain_Intensity1484_g61175);
				float2 temp_output_1355_0_g61175 = ( ( input.ase_texcoord1.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61175, ddx( temp_output_1355_0_g61175 ), ddy( temp_output_1355_0_g61175 ) );
				float temp_output_3696_0_g61175 = ( ( tex2DNode257_g61175.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61175 = ( frac( ( tex2DNode257_g61175.b - ( Time1591_g61175 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61175 ) );
				float lerpResult4471_g61175 = lerp( ( temp_output_1818_0_g61175 + saturate( -temp_output_3696_0_g61175 ) ) , temp_output_1818_0_g61175 , _RainDropStaticScale);
				float temp_output_3691_0_g61175 = ( lerpResult4471_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult1664_g61175 = lerp( 0.0 , (temp_output_3691_0_g61175*2.0 + -1.0) , _ENABLEDROPS);
				float Drops3492_g61175 = saturate( lerpResult1664_g61175 );
				float temp_output_3457_0_g61175 = saturate( ( temp_output_2631_0_g61175 * Drops3492_g61175 ) );
				float3 lerpResult3399_g61175 = lerp( lerpResult4144_g61175 , temp_output_2628_0_g61175 , temp_output_3457_0_g61175);
				float3 lerpResult3547_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , lerpResult3399_g61175 , Global_Rain_Intensity1484_g61175);
				float3 weightedBlendVar3481_g61175 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend3481_g61175 = ( weightedBlendVar3481_g61175.x*temp_output_2628_0_g61175 + weightedBlendVar3481_g61175.y*lerpResult3546_g61175 + weightedBlendVar3481_g61175.z*lerpResult3547_g61175 );
				float3 lerpResult799_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , weightedBlend3481_g61175 , ENABLE_RAIN363_g61175);
				

				float3 BaseColor = lerpResult799_g61175;
				float Alpha = ( 1.0 - _GlassOpacity );
				float AlphaClipThreshold = 0.5;

				half4 color = half4(BaseColor, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormalsOnly" }

			ZWrite On
			Blend One Zero
			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

			

			

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			

			

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
			//#define SHADERPASS SHADERPASS_DEPTHNORMALS

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			
			#if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				half4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 _NormalModefloat3switch( float m_switch, float3 m_Flip, float3 m_Mirror, float3 m_None )
			{
				if(m_switch ==0)
					return m_Flip;
				else if(m_switch ==1)
					return m_Mirror;
				else if(m_switch ==2)
					return m_None;
				else
				return float3(0,0,0);
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				output.ase_texcoord3.xy = input.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				output.normalWS = normalInput.normalWS;
				output.tangentWS = float4( normalInput.tangentWS, ( input.tangentOS.w > 0.0 ? 1.0 : -1.0 ) * GetOddNegativeScale() );
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.ase_texcoord = input.ase_texcoord;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			void frag(	PackedVaryings input
						, out half4 outNormalWS : SV_Target0
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						, bool ase_vface : SV_IsFrontFace )
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				// @diogo: mikktspace compliant
				float renormFactor = 1.0 / max( FLT_MIN, length( input.normalWS ) );

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 TangentWS = input.tangentWS.xyz * renormFactor;
				float3 BitangentWS = cross( input.normalWS, input.tangentWS.xyz ) * input.tangentWS.w * renormFactor;
				float3 NormalWS = input.normalWS * renormFactor;

				float2 temp_output_3808_0_g61174 = ( (_BumpMap_ST).xy / 1.0 );
				float2 _Vector10 = float2(0.5,0.5);
				float3 unpack268_g61174 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, ( ( ( input.ase_texcoord3.xy * temp_output_3808_0_g61174 ) + (_BumpMap_ST).zw ) - ( ( temp_output_3808_0_g61174 * _Vector10 ) - _Vector10 ) ) ), _BumpScale );
				unpack268_g61174.z = lerp( 1, unpack268_g61174.z, saturate(_BumpScale) );
				float3 temp_output_20_0_g61175 = unpack268_g61174;
				float2 _Vector4 = float2(1,1);
				float Wind_Direction2547_g61175 = _GlobalRainWindDirection;
				float temp_output_4405_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61175 = ( input.ase_texcoord3.xy - _Anchor );
				float temp_output_4406_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4415_g61175 = (float2(( ( temp_output_4405_0_g61175 * break4413_g61175.x ) + ( temp_output_4406_0_g61175 * break4413_g61175.y ) ) , ( ( temp_output_4405_0_g61175 * break4413_g61175.y ) - ( temp_output_4406_0_g61175 * break4413_g61175.x ) )));
				float4 tex2DNode172_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float4 appendResult3784_g61175 = (float4(1.0 , tex2DNode172_g61175.r , 0.0 , tex2DNode172_g61175.g));
				float3 unpack3786_g61175 = UnpackNormalScale( appendResult3784_g61175, _RainDripNormalScale );
				unpack3786_g61175.z = lerp( 1, unpack3786_g61175.z, saturate(_RainDripNormalScale) );
				float3 normalizeResult3787_g61175 = ASESafeNormalize( unpack3786_g61175 );
				float temp_output_4713_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 temp_output_183_0_g61175 = (PositionWS).yx;
				float2 lerpResult4672_g61175 = lerp( temp_output_183_0_g61175 , ( 1.0 - temp_output_183_0_g61175 ) , _RainDripMaskInvert);
				float2 break4707_g61175 = ( lerpResult4672_g61175 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4717_g61175 = (float2(( ( temp_output_4713_0_g61175 * break4707_g61175.x ) + ( temp_output_4712_0_g61175 * break4707_g61175.y ) ) , ( ( temp_output_4713_0_g61175 * break4707_g61175.y ) - ( temp_output_4712_0_g61175 * break4707_g61175.x ) )));
				float temp_output_386_0_g61175 = ( 1.0 - saturate( max( 0.5 , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float Permeability387_g61175 = temp_output_386_0_g61175;
				float lerpResult193_g61175 = lerp( 0.2 , 0.03 , Permeability387_g61175);
				float lerpResult194_g61175 = lerp( 0.0 , 0.0125 , Permeability387_g61175);
				float lerpResult185_g61175 = lerp( lerpResult193_g61175 , lerpResult194_g61175 , tex2DNode172_g61175.a);
				float Time1591_g61175 = _TimeParameters.x;
				float temp_output_186_0_g61175 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61175 + ( lerpResult185_g61175 * ( ( Time1591_g61175 * _RainDripSpeed ) + tex2DNode172_g61175.a ) ) ) ).r * tex2DNode172_g61175.b );
				float3 temp_cast_1 = (0.5).xxx;
				float3 break3837_g61175 = ( abs( NormalWS ) - temp_cast_1 );
				float smoothstepResult3838_g61175 = smoothstep( 0.1 , 1.0 , ( break3837_g61175.z + 0.5 ));
				float ENABLE_RAIN363_g61175 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61175 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61175 );
				float Mask_Vertical_Z3918_g61175 = ( smoothstepResult3838_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3929_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_Z3918_g61175);
				float smoothstepResult3864_g61175 = smoothstep( 0.0 , 1.0 , ( break3837_g61175.x + 0.45 ));
				float Mask_Vertical_X3920_g61175 = ( smoothstepResult3864_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3930_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_X3920_g61175);
				float smoothstepResult3839_g61175 = smoothstep( 0.0 , 1.0 , ( -break3837_g61175.y + 0.45 ));
				float Mask_Vertical_Y3919_g61175 = ( smoothstepResult3839_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3931_g61175 = lerp( lerpResult3929_g61175 , ( lerpResult3929_g61175 + lerpResult3930_g61175 ) , Mask_Vertical_Y3919_g61175);
				float temp_output_1689_0_g61175 = ( lerpResult3931_g61175 * _RainDripIntensity );
				float3 lerpResult588_g61175 = lerp( temp_output_20_0_g61175 , normalizeResult3787_g61175 , temp_output_1689_0_g61175);
				float2 weightedBlendVar1635_g61175 = _Vector4;
				float3 weightedBlend1635_g61175 = ( weightedBlendVar1635_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1635_g61175.y*lerpResult588_g61175 );
				float ENABLE_DRIPS1644_g61175 = _ENABLEDRIPS;
				float3 lerpResult1640_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1635_g61175 , ENABLE_DRIPS1644_g61175);
				float2 temp_output_1355_0_g61175 = ( ( input.ase_texcoord3.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61175, ddx( temp_output_1355_0_g61175 ), ddy( temp_output_1355_0_g61175 ) );
				float4 appendResult3767_g61175 = (float4(1.0 , tex2DNode257_g61175.r , 0.0 , tex2DNode257_g61175.g));
				float3 unpack3768_g61175 = UnpackNormalScale( appendResult3767_g61175, _RainDropNormalScale );
				unpack3768_g61175.z = lerp( 1, unpack3768_g61175.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g61175 = ASESafeNormalize( unpack3768_g61175 );
				float m_switch4772_g61175 = _RainDropNormalMode;
				float3 m_Flip4772_g61175 = float3( -1, -1, -1 );
				float3 m_Mirror4772_g61175 = float3( 1, 1, -1 );
				float3 m_None4772_g61175 = float3( 1, 1, 1 );
				float3 local_NormalModefloat3switch4772_g61175 = _NormalModefloat3switch( m_switch4772_g61175 , m_Flip4772_g61175 , m_Mirror4772_g61175 , m_None4772_g61175 );
				float3 switchResult4768_g61175 = (((ase_vface>0)?(normalizeResult3770_g61175):(( normalizeResult3770_g61175 * local_NormalModefloat3switch4772_g61175 ))));
				float temp_output_3696_0_g61175 = ( ( tex2DNode257_g61175.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61175 = ( frac( ( tex2DNode257_g61175.b - ( Time1591_g61175 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61175 ) );
				float lerpResult4471_g61175 = lerp( ( temp_output_1818_0_g61175 + saturate( -temp_output_3696_0_g61175 ) ) , temp_output_1818_0_g61175 , _RainDropStaticScale);
				float temp_output_3691_0_g61175 = ( lerpResult4471_g61175 * Global_Rain_Intensity1484_g61175 );
				float3 lerpResult1298_g61175 = lerp( switchResult4768_g61175 , temp_output_20_0_g61175 , (temp_output_3691_0_g61175*2.0 + -1.0));
				float2 weightedBlendVar1637_g61175 = _Vector4;
				float3 weightedBlend1637_g61175 = ( weightedBlendVar1637_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1637_g61175.y*lerpResult1298_g61175 );
				float ENABLE_DROPS1643_g61175 = _ENABLEDROPS;
				float3 lerpResult1641_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1637_g61175 , ENABLE_DROPS1643_g61175);
				float3 weightedBlendVar1305_g61175 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend1305_g61175 = ( weightedBlendVar1305_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1305_g61175.y*lerpResult1640_g61175 + weightedBlendVar1305_g61175.z*lerpResult1641_g61175 );
				float3 lerpResult2879_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1305_g61175 , Global_Rain_Intensity1484_g61175);
				float3 lerpResult790_g61175 = lerp( temp_output_20_0_g61175 , lerpResult2879_g61175 , ENABLE_RAIN363_g61175);
				

				float3 Normal = lerpResult790_g61175;
				float Alpha = ( 1.0 - _GlassOpacity );
				float AlphaClipThreshold = 0.5;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = DeviceDepth;
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float2 octNormalWS = PackNormalOctQuadEncode(NormalWS);
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);
					outNormalWS = half4(packedNormalWS, 0.0);
				#else
					#if defined(_NORMALMAP)
						#if _NORMAL_DROPOFF_TS
							float3 normalWS = TransformTangentToWorld(Normal, half3x3(TangentWS, BitangentWS, NormalWS));
						#elif _NORMAL_DROPOFF_OS
							float3 normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							float3 normalWS = Normal;
						#endif
					#else
						float3 normalWS = NormalWS;
					#endif
					outNormalWS = half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4(EncodeMeshRenderingLayer(renderingLayers), 0, 0, 0);
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }

			Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM

			

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION

			

			
			#pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
           

			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

			

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_GBUFFER

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			
			#if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					float4 texcoord1 : TEXCOORD1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					float4 texcoord2 : TEXCOORD2;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				half4 tangentWS : TEXCOORD2;
				float4 lightmapUVOrVertexSH : TEXCOORD3;
				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					half4 fogFactorAndVertexLight : TEXCOORD4;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD5;
				#endif
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_SmoothnessMap);
			SAMPLER(sampler_SmoothnessMap);


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 _NormalModefloat3switch( float m_switch, float3 m_Flip, float3 m_Mirror, float3 m_None )
			{
				if(m_switch ==0)
					return m_Flip;
				else if(m_switch ==1)
					return m_Mirror;
				else if(m_switch ==2)
					return m_None;
				else
				return float3(0,0,0);
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				output.ase_texcoord6.xy = input.texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord6.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(input.texcoord1, unity_LightmapST, output.lightmapUVOrVertexSH.xy);
				#else
					OUTPUT_SH(normalInput.normalWS.xyz, output.lightmapUVOrVertexSH.xyz);
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					output.dynamicLightmapUV.xy = input.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					output.lightmapUVOrVertexSH.zw = input.texcoord.xy;
					output.lightmapUVOrVertexSH.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					output.fogFactorAndVertexLight = 0;
					#if defined(ASE_FOG) && !defined(_FOG_FRAGMENT)
						// @diogo: no fog applied in GBuffer
					#endif
					#ifdef _ADDITIONAL_LIGHTS_VERTEX
						half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );
						output.fogFactorAndVertexLight.yzw = vertexLight;
					#endif
				#endif

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				output.normalWS = normalInput.normalWS;
				output.tangentWS = float4( normalInput.tangentWS, ( input.tangentOS.w > 0.0 ? 1.0 : -1.0 ) * GetOddNegativeScale() );
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					float4 texcoord1 : TEXCOORD1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					float4 texcoord2 : TEXCOORD2;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.texcoord = input.texcoord;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					output.texcoord1 = input.texcoord1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					output.texcoord2 = input.texcoord2;
				#endif
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					output.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					output.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				#endif
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			FragmentOutput frag ( PackedVaryings input
								#if defined( ASE_DEPTH_WRITE_ON )
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								, bool ase_vface : SV_IsFrontFace )
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					float4 shadowCoord = TransformWorldToShadowCoord( input.positionWS );
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				// @diogo: mikktspace compliant
				float renormFactor = 1.0 / max( FLT_MIN, length( input.normalWS ) );

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float3 ViewDirWS = GetWorldSpaceNormalizeViewDir( PositionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 TangentWS = input.tangentWS.xyz * renormFactor;
				float3 BitangentWS = cross( input.normalWS, input.tangentWS.xyz ) * input.tangentWS.w * renormFactor;
				float3 NormalWS = input.normalWS * renormFactor;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (input.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					BitangentWS = cross(NormalWS, -TangentWS);
				#endif

				float3 temp_output_2628_0_g61175 = ( saturate( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) ) * 0.2 );
				float temp_output_386_0_g61175 = ( 1.0 - saturate( max( 0.5 , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float temp_output_2631_0_g61175 = saturate( max( temp_output_386_0_g61175 , min( _GlobalRainWetness , 0.94 ) ) );
				float3 lerpResult4144_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , temp_output_2628_0_g61175 , ( ( _GlobalRainWetness * 0.85 ) * temp_output_2631_0_g61175 ));
				float Wind_Direction2547_g61175 = _GlobalRainWindDirection;
				float temp_output_4713_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 temp_output_183_0_g61175 = (PositionWS).yx;
				float2 lerpResult4672_g61175 = lerp( temp_output_183_0_g61175 , ( 1.0 - temp_output_183_0_g61175 ) , _RainDripMaskInvert);
				float2 break4707_g61175 = ( lerpResult4672_g61175 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4717_g61175 = (float2(( ( temp_output_4713_0_g61175 * break4707_g61175.x ) + ( temp_output_4712_0_g61175 * break4707_g61175.y ) ) , ( ( temp_output_4713_0_g61175 * break4707_g61175.y ) - ( temp_output_4712_0_g61175 * break4707_g61175.x ) )));
				float Permeability387_g61175 = temp_output_386_0_g61175;
				float lerpResult193_g61175 = lerp( 0.2 , 0.03 , Permeability387_g61175);
				float lerpResult194_g61175 = lerp( 0.0 , 0.0125 , Permeability387_g61175);
				float temp_output_4405_0_g61175 = cos( Wind_Direction2547_g61175 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61175 = ( input.ase_texcoord6.xy - _Anchor );
				float temp_output_4406_0_g61175 = sin( Wind_Direction2547_g61175 );
				float2 appendResult4415_g61175 = (float2(( ( temp_output_4405_0_g61175 * break4413_g61175.x ) + ( temp_output_4406_0_g61175 * break4413_g61175.y ) ) , ( ( temp_output_4405_0_g61175 * break4413_g61175.y ) - ( temp_output_4406_0_g61175 * break4413_g61175.x ) )));
				float4 tex2DNode172_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61175 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float lerpResult185_g61175 = lerp( lerpResult193_g61175 , lerpResult194_g61175 , tex2DNode172_g61175.a);
				float Time1591_g61175 = _TimeParameters.x;
				float temp_output_186_0_g61175 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61175 + ( lerpResult185_g61175 * ( ( Time1591_g61175 * _RainDripSpeed ) + tex2DNode172_g61175.a ) ) ) ).r * tex2DNode172_g61175.b );
				float3 temp_cast_0 = (0.5).xxx;
				float3 break3837_g61175 = ( abs( NormalWS ) - temp_cast_0 );
				float smoothstepResult3838_g61175 = smoothstep( 0.1 , 1.0 , ( break3837_g61175.z + 0.5 ));
				float ENABLE_RAIN363_g61175 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61175 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61175 );
				float Mask_Vertical_Z3918_g61175 = ( smoothstepResult3838_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3929_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_Z3918_g61175);
				float smoothstepResult3864_g61175 = smoothstep( 0.0 , 1.0 , ( break3837_g61175.x + 0.45 ));
				float Mask_Vertical_X3920_g61175 = ( smoothstepResult3864_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3930_g61175 = lerp( 0.0001 , temp_output_186_0_g61175 , Mask_Vertical_X3920_g61175);
				float smoothstepResult3839_g61175 = smoothstep( 0.0 , 1.0 , ( -break3837_g61175.y + 0.45 ));
				float Mask_Vertical_Y3919_g61175 = ( smoothstepResult3839_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3931_g61175 = lerp( lerpResult3929_g61175 , ( lerpResult3929_g61175 + lerpResult3930_g61175 ) , Mask_Vertical_Y3919_g61175);
				float temp_output_1689_0_g61175 = ( lerpResult3931_g61175 * _RainDripIntensity );
				float lerpResult1663_g61175 = lerp( 0.0 , temp_output_1689_0_g61175 , _ENABLEDRIPS);
				float Drips3491_g61175 = saturate( lerpResult1663_g61175 );
				float3 lerpResult3462_g61175 = lerp( lerpResult4144_g61175 , temp_output_2628_0_g61175 , saturate( ( temp_output_2631_0_g61175 * Drips3491_g61175 ) ));
				float3 lerpResult3546_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , lerpResult3462_g61175 , Global_Rain_Intensity1484_g61175);
				float2 temp_output_1355_0_g61175 = ( ( input.ase_texcoord6.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61175 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61175, ddx( temp_output_1355_0_g61175 ), ddy( temp_output_1355_0_g61175 ) );
				float temp_output_3696_0_g61175 = ( ( tex2DNode257_g61175.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61175 = ( frac( ( tex2DNode257_g61175.b - ( Time1591_g61175 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61175 ) );
				float lerpResult4471_g61175 = lerp( ( temp_output_1818_0_g61175 + saturate( -temp_output_3696_0_g61175 ) ) , temp_output_1818_0_g61175 , _RainDropStaticScale);
				float temp_output_3691_0_g61175 = ( lerpResult4471_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult1664_g61175 = lerp( 0.0 , (temp_output_3691_0_g61175*2.0 + -1.0) , _ENABLEDROPS);
				float Drops3492_g61175 = saturate( lerpResult1664_g61175 );
				float temp_output_3457_0_g61175 = saturate( ( temp_output_2631_0_g61175 * Drops3492_g61175 ) );
				float3 lerpResult3399_g61175 = lerp( lerpResult4144_g61175 , temp_output_2628_0_g61175 , temp_output_3457_0_g61175);
				float3 lerpResult3547_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , lerpResult3399_g61175 , Global_Rain_Intensity1484_g61175);
				float3 weightedBlendVar3481_g61175 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend3481_g61175 = ( weightedBlendVar3481_g61175.x*temp_output_2628_0_g61175 + weightedBlendVar3481_g61175.y*lerpResult3546_g61175 + weightedBlendVar3481_g61175.z*lerpResult3547_g61175 );
				float3 lerpResult799_g61175 = lerp( ( (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) ) , weightedBlend3481_g61175 , ENABLE_RAIN363_g61175);
				
				float2 temp_output_3808_0_g61174 = ( (_BumpMap_ST).xy / 1.0 );
				float2 _Vector10 = float2(0.5,0.5);
				float3 unpack268_g61174 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, ( ( ( input.ase_texcoord6.xy * temp_output_3808_0_g61174 ) + (_BumpMap_ST).zw ) - ( ( temp_output_3808_0_g61174 * _Vector10 ) - _Vector10 ) ) ), _BumpScale );
				unpack268_g61174.z = lerp( 1, unpack268_g61174.z, saturate(_BumpScale) );
				float3 temp_output_20_0_g61175 = unpack268_g61174;
				float2 _Vector4 = float2(1,1);
				float4 appendResult3784_g61175 = (float4(1.0 , tex2DNode172_g61175.r , 0.0 , tex2DNode172_g61175.g));
				float3 unpack3786_g61175 = UnpackNormalScale( appendResult3784_g61175, _RainDripNormalScale );
				unpack3786_g61175.z = lerp( 1, unpack3786_g61175.z, saturate(_RainDripNormalScale) );
				float3 normalizeResult3787_g61175 = ASESafeNormalize( unpack3786_g61175 );
				float3 lerpResult588_g61175 = lerp( temp_output_20_0_g61175 , normalizeResult3787_g61175 , temp_output_1689_0_g61175);
				float2 weightedBlendVar1635_g61175 = _Vector4;
				float3 weightedBlend1635_g61175 = ( weightedBlendVar1635_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1635_g61175.y*lerpResult588_g61175 );
				float ENABLE_DRIPS1644_g61175 = _ENABLEDRIPS;
				float3 lerpResult1640_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1635_g61175 , ENABLE_DRIPS1644_g61175);
				float4 appendResult3767_g61175 = (float4(1.0 , tex2DNode257_g61175.r , 0.0 , tex2DNode257_g61175.g));
				float3 unpack3768_g61175 = UnpackNormalScale( appendResult3767_g61175, _RainDropNormalScale );
				unpack3768_g61175.z = lerp( 1, unpack3768_g61175.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g61175 = ASESafeNormalize( unpack3768_g61175 );
				float m_switch4772_g61175 = _RainDropNormalMode;
				float3 m_Flip4772_g61175 = float3( -1, -1, -1 );
				float3 m_Mirror4772_g61175 = float3( 1, 1, -1 );
				float3 m_None4772_g61175 = float3( 1, 1, 1 );
				float3 local_NormalModefloat3switch4772_g61175 = _NormalModefloat3switch( m_switch4772_g61175 , m_Flip4772_g61175 , m_Mirror4772_g61175 , m_None4772_g61175 );
				float3 switchResult4768_g61175 = (((ase_vface>0)?(normalizeResult3770_g61175):(( normalizeResult3770_g61175 * local_NormalModefloat3switch4772_g61175 ))));
				float3 lerpResult1298_g61175 = lerp( switchResult4768_g61175 , temp_output_20_0_g61175 , (temp_output_3691_0_g61175*2.0 + -1.0));
				float2 weightedBlendVar1637_g61175 = _Vector4;
				float3 weightedBlend1637_g61175 = ( weightedBlendVar1637_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1637_g61175.y*lerpResult1298_g61175 );
				float ENABLE_DROPS1643_g61175 = _ENABLEDROPS;
				float3 lerpResult1641_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1637_g61175 , ENABLE_DROPS1643_g61175);
				float3 weightedBlendVar1305_g61175 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend1305_g61175 = ( weightedBlendVar1305_g61175.x*temp_output_20_0_g61175 + weightedBlendVar1305_g61175.y*lerpResult1640_g61175 + weightedBlendVar1305_g61175.z*lerpResult1641_g61175 );
				float3 lerpResult2879_g61175 = lerp( temp_output_20_0_g61175 , weightedBlend1305_g61175 , Global_Rain_Intensity1484_g61175);
				float3 lerpResult790_g61175 = lerp( temp_output_20_0_g61175 , lerpResult2879_g61175 , ENABLE_RAIN363_g61175);
				
				float3 temp_output_3738_0_g61174 = (_SpecularColor).rgb;
				float3 lerpResult3756_g61174 = lerp( float3( 0, 0, 0 ) , saturate( ( temp_output_3738_0_g61174 * ( pow( ( _SpecularStrengthDielectricIOR - 1.0 ) , 2.0 ) / pow( ( _SpecularStrengthDielectricIOR + 1.0 ) , 2.0 ) ) ) ) , _SpecularEnable);
				
				float2 temp_output_3792_0_g61174 = ( (_SmoothnessMap_ST).xy / 1.0 );
				float2 _Vector8 = float2(0.5,0.5);
				float MaskDrips3024_g61175 = temp_output_1689_0_g61175;
				float saferPower3000_g61175 = abs( MaskDrips3024_g61175 );
				float lerpResult2986_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , _RainDripSmoothness , round( pow( saferPower3000_g61175 , 0.1 ) ));
				float lerpResult3013_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult2986_g61175 , Drips3491_g61175);
				float lerpResult3016_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult3013_g61175 , ENABLE_DRIPS1644_g61175);
				float lerpResult3253_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult3016_g61175 , Global_Rain_Intensity1484_g61175);
				float smoothstepResult3849_g61175 = smoothstep( 0.0 , 1.0 , ( NormalWS.y + 0.02 ));
				float Mask_Horizontal1481_g61175 = ( smoothstepResult3849_g61175 * Global_Rain_Intensity1484_g61175 );
				float lerpResult3963_g61175 = lerp( 0.0001 , temp_output_3691_0_g61175 , Mask_Vertical_Z3918_g61175);
				float lerpResult3962_g61175 = lerp( 0.0001 , temp_output_3691_0_g61175 , Mask_Vertical_X3920_g61175);
				float lerpResult3964_g61175 = lerp( lerpResult3963_g61175 , ( lerpResult3963_g61175 + lerpResult3962_g61175 ) , Mask_Vertical_Y3919_g61175);
				float MaskDrops1847_g61175 = (( ( temp_output_3691_0_g61175 * Mask_Horizontal1481_g61175 ) + lerpResult3964_g61175 )*2.0 + -1.0);
				float saferPower1848_g61175 = abs( MaskDrops1847_g61175 );
				float lerpResult2673_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , _RainDropSmoothness , pow( saferPower1848_g61175 , 1E-05 ));
				float lerpResult2949_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult2673_g61175 , Drops3492_g61175);
				float lerpResult2649_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult2949_g61175 , ENABLE_DROPS1643_g61175);
				float lerpResult2869_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , lerpResult2649_g61175 , Global_Rain_Intensity1484_g61175);
				float3 weightedBlendVar3316_g61175 = float3( 0.5, 0.5, 0.5 );
				float weightedBlend3316_g61175 = ( weightedBlendVar3316_g61175.x*( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x + weightedBlendVar3316_g61175.y*lerpResult3253_g61175 + weightedBlendVar3316_g61175.z*lerpResult2869_g61175 );
				float lerpResult801_g61175 = lerp( ( (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, ( ( ( input.ase_texcoord6.xy * temp_output_3792_0_g61174 ) + (_SmoothnessMap_ST).zw ) - ( ( temp_output_3792_0_g61174 * _Vector8 ) - _Vector8 ) ) )).rgb * _SmoothnessStrength ).x , weightedBlend3316_g61175 , ENABLE_RAIN363_g61175);
				
				float lerpResult308_g61175 = lerp( 0.5 , 0.5 , ( Drips3491_g61175 + Drops3492_g61175 ));
				float lerpResult2871_g61175 = lerp( 0.5 , lerpResult308_g61175 , Global_Rain_Intensity1484_g61175);
				float lerpResult802_g61175 = lerp( 0.5 , lerpResult2871_g61175 , ENABLE_RAIN363_g61175);
				

				float3 BaseColor = lerpResult799_g61175;
				float3 Normal = lerpResult790_g61175;
				float3 Specular = lerpResult3756_g61174;
				float Metallic = 0;
				float Smoothness = lerpResult801_g61175;
				float Occlusion = lerpResult802_g61175;
				float3 Emission = 0;
				float Alpha = ( 1.0 - _GlassOpacity );
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = (_TransmittanceColor).rgb;
				float RefractionIndex = ( 1.0 - ( _Ior + ( ( _CATEGORY_REFRACTION + _CATEGORYSPACE_REFRACTION ) * 0.0 ) ) );
				float3 Transmission = 1;
				float3 Translucency = 1;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = ClipPos.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_CHANGES_WORLD_POS)
					ShadowCoord = TransformWorldToShadowCoord( PositionWS );
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = PositionWS;
				inputData.positionCS = float4( input.positionCS.xy, ClipPos.zw / ClipPos.w );
				inputData.normalizedScreenSpaceUV = ScreenPosNorm.xy;
				inputData.shadowCoord = ShadowCoord;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
						inputData.normalWS = TransformTangentToWorld(Normal, half3x3( TangentWS, BitangentWS, NormalWS ));
					#elif _NORMAL_DROPOFF_OS
						inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
						inputData.normalWS = Normal;
					#endif
				#else
					inputData.normalWS = NormalWS;
				#endif

				inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				inputData.viewDirectionWS = SafeNormalize( ViewDirWS );

				#ifdef ASE_FOG
					// @diogo: no fog applied in GBuffer
				#endif
				#ifdef _ADDITIONAL_LIGHTS_VERTEX
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = input.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, input.dynamicLightmapUV.xy, SH, inputData.normalWS);
				#else
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, SH, inputData.normalWS);
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.dynamicLightmapUV.xy;
						#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				#ifdef _DBUFFER
					ApplyDecal(input.positionCS,
						BaseColor,
						Specular,
						inputData.normalWS,
						Metallic,
						Occlusion,
						Smoothness);
				#endif

				BRDFData brdfData;
				InitializeBRDFData(BaseColor, Metallic, Specular, Smoothness, Alpha, brdfData);

				Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
				half4 color;
				MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI, inputData.shadowMask);
				color.rgb = GlobalIllumination(brdfData, inputData.bakedGI, Occlusion, inputData.positionWS, inputData.normalWS, inputData.viewDirectionWS);
				color.a = Alpha;

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = DeviceDepth;
				#endif

				return BRDFDataToGbuffer(brdfData, inputData, Smoothness, Emission + color.rgb, Occlusion);
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SCENESELECTIONPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction(Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag( PackedVaryings input
				#if defined( ASE_DEPTH_WRITE_ON )
				,out float outputDepth : ASE_SV_DEPTH
				#endif
				 ) : SV_Target
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;

				

				surfaceDescription.Alpha = ( 1.0 - _GlassOpacity );
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = input.positionCS.z;
				#endif

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = DeviceDepth;
				#endif

				return half4( _ObjectId, _PassValue, 1.0, 1.0 );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			AlphaToMask Off

			HLSLPROGRAM

			

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_REFRACTION 1
			#define REQUIRE_OPAQUE_TEXTURE 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

		    #define SCENEPICKINGPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _BumpMap_ST;
			float4 _RainDrop_ST;
			float4 _ClearCoatMap_ST;
			float4 _SpecularColor;
			float4 _BaseColor;
			float4 _SmoothnessMap_ST;
			half4 _TransmittanceColor;
			float4 _RainDrip_ST;
			float _RainDropNormalScale;
			half _RainDropNormalMode;
			half _SpecularStrengthDielectricIOR;
			half _SpecularEnable;
			half _SmoothnessStrength;
			float _RainDropSmoothness;
			float _RainDripNormalScale;
			half _GlassOpacity;
			half _Ior;
			float _CATEGORY_REFRACTION;
			float _CATEGORYSPACE_REFRACTION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _RainDripSmoothness;
			float _CATEGORY_SURFACESETTINGS;
			float _ENABLEDROPS;
			float _CATEGORYSPACE_COATMASK;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			half _Brightness;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _GlobalRainWetness;
			float _GlobalRainWindDirection;
			float _RainDripMaskInvert;
			float _RainDripSpeed;
			float _GlobalRainIntensity;
			float _ENABLERAIN;
			float _RainDripIntensity;
			float _ENABLEDRIPS;
			float _RainDropSpeed;
			float _RainDropStaticScale;
			float _BumpScale;
			float _ClearCoatSmoothness;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag( PackedVaryings input
				#if defined( ASE_DEPTH_WRITE_ON )
				,out float outputDepth : ASE_SV_DEPTH
				#endif
				 ) : SV_Target
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;

				

				surfaceDescription.Alpha = ( 1.0 - _GlassOpacity );
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = input.positionCS.z;
				#endif

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
						clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = DeviceDepth;
				#endif

				return _SelectionID;
			}
			ENDHLSL
		}
		
	}
	
	CustomEditor "LS_ShaderGUI"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback Off
}

/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;427;0,-256;Inherit;False;370.7075;302.6782;SURFACE SETTINGS;4;425;426;103;144;;0,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;426;32,-208;Inherit;False;Property;_CATEGORY_SURFACESETTINGS;CATEGORY_SURFACE SETTINGS;0;0;Create;True;0;0;0;True;1;LS_DrawerCategory(SURFACE SETTINGS,true,_Cull,0,0);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;425;32,-48;Inherit;False;Property;_SPACE_SURFACESETTINGS;SPACE_SURFACE SETTINGS;2;0;Create;True;0;0;0;True;1;LS_DrawerCategorySpace(10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;103;32,-128;Inherit;False;Property;_Cull;Render Face;1;1;[Enum];Create;False;1;;0;1;Front,2,Back,1,Both,0;True;0;False;2;0;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;555;-832,160;Inherit;False;LS Core Glass;8;;61174;cbfd1b27f8521c24fa773adfc7d6c5c6;0;0;6;FLOAT3;2986;FLOAT3;2985;FLOAT3;3073;FLOAT3;3676;FLOAT;2987;FLOAT;3860
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;545;-480,48;Inherit;False;LS Weather Rain;36;;61175;459598b18c271444bb1ee555b88e658e;23,2921,1,2916,1,2944,1,4770,1,3020,1,2920,1,2217,1,3500,0,4474,0,2702,0,3815,0,811,0,2222,0,4101,0,2557,1,4722,1,2546,1,4584,0,4575,0,4576,0,4574,0,4586,0,4583,0;5;314;FLOAT3;0.5,0.5,0.5;False;20;FLOAT3;0,0,1;False;380;FLOAT;0.5;False;306;FLOAT;0.5;False;313;FLOAT;0.5;False;5;FLOAT3;315;FLOAT3;41;FLOAT;317;FLOAT;316;FLOAT;3826
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;428;-320,448;Inherit;False;LS URP Clear Coat;27;;61178;8a05b92f6be02ee4992379fade361e90;0;0;2;FLOAT;3744;FLOAT;3743
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;553;-320,336;Inherit;False;LS URP Refraction;3;;61179;d98525376f24ca441b8945be9199ad2c;0;0;2;FLOAT3;3935;FLOAT;3933
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;145;0,128;Float;False;True;-1;2;LS_ShaderGUI;0;12;LS/Weather/Rain Glass;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_Cull;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=TransparentCutout=RenderType;Queue=Transparent=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;5;False;;10;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForwardOnly;False;False;0;;0;0;Standard;45;Lighting Model;0;638753590660139896;Workflow;0;638753575943044547;Surface;1;638753576041028853;  Refraction Model;1;638753576926220086;  Blend;0;638753587099900462;Two Sided;1;0;Alpha Clipping;0;638755693415858210;  Use Shadow Threshold;0;638703485322137222;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;1;0;Transmission;0;638728375827248961;  Transmission Shadow;0.5,True,_ASETransmissionShadow;638709971722742780;Translucency;0;638728375835930477;  Translucency Strength;1,True,_ASETranslucencyStrength;638709971765784237;  Normal Distortion;0.5,True,_ASETranslucencyNormalDistortion;638709971808374177;  Scattering;2,True,_ASETranslucencyScattering;638709971864493599;  Direct;0.9,True,_ASETranslucencyDirect;638709971895433110;  Ambient;0.1,True,_ASETranslucencyAmbient;638709971929436255;  Shadow;0.5,True,_ASETranslucencyShadow;638709971967448480;Cast Shadows;1;0;Receive Shadows;1;0;Receive SSAO;1;0;Specular Highlights;1;0;Environment Reflections;1;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;1;638753583485936021;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;638753588968000503;Tessellation;0;0;  Phong;0;0;  Strength;0.5,True,_TessellationPhong;0;  Type;0;0;  Tess;16,True,_TessellationStrength;0;  Min;10,True,_TessellationDistanceMin;0;  Max;25,True,_TessellationDistanceMax;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;0;0;Clear Coat;1;638709964944237641;0;10;False;True;True;True;True;True;True;True;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;146;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;147;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;True;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;148;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;149;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;5;False;;10;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;150;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;151;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;5;False;;10;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;152;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;153;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;144;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
WireConnection;545;314;555;2986
WireConnection;545;20;555;2985
WireConnection;545;306;555;3676
WireConnection;145;0;545;315
WireConnection;145;1;545;41
WireConnection;145;9;555;3073
WireConnection;145;4;545;317
WireConnection;145;5;545;316
WireConnection;145;6;555;2987
WireConnection;145;12;553;3935
WireConnection;145;13;553;3933
WireConnection;145;18;428;3744
WireConnection;145;20;428;3743
ASEEND*/
//CHKSM=5887DD3BFF606B7D4F3F3E82300BE9A6C9DA4240