// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LS/Lit"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[LS_DrawerCategory(SURFACE SETTINGS,true,_Cull,0,0)] _CATEGORY_SURFACESETTINGS( "CATEGORY_SURFACE SETTINGS", Float ) = 1
		[Enum(Front,2,Back,1,Both,0)] _Cull( "Render Face", Int ) = 2
		[LS_DrawerCategorySpace(10)] _SPACE_SURFACESETTINGS( "SPACE_SURFACE SETTINGS", Float ) = 0
		[LS_DrawerCategory(ALPHA,true,_Cutoff,0,0)] _CATEGORY_ALPHA( "CATEGORY_ALPHA", Float ) = 1
		[LS_DrawerToggleLeft] _AlphaClip( "Alpha Cutoff Enable", Float ) = 1
		_Cutoff( "Alpha Cutoff", Range( 0, 1 ) ) = 0.5
		_AlphaCutoffShadow( "Alpha Cutoff Shadow", Range( 0.01, 1 ) ) = 0.01
		[Toggle] _EnableClipGlancingAngle( "Enable Clip Glancing Angle", Float ) = 0
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_ALPHA( "CATEGORYSPACE_ALPHA", Float ) = 0
		[LS_DrawerCategory(COLOR,true,_BaseColor,0,0)] _CATEGORY_COLOR( "CATEGORY_COLOR", Float ) = 1
		_BaseColor( "Base Color", Color ) = ( 1, 1, 1, 1 )
		_Brightness( "Brightness", Range( 0, 2 ) ) = 1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_COLOR( "CATEGORYSPACE_COLOR", Float ) = 0
		[LS_DrawerCategory(SURFACE INPUTS,true,_BaseMap,0,0)] _CATEGORY_SURFACEINPUTS( "CATEGORY_SURFACE INPUTS", Float ) = 1
		[LS_DrawerTextureSingleLine] _BaseMap( "Base Map", 2D ) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _UVBase( "UV Set", Float ) = 0
		[LS_DrawerTextureScaleOffset] _BaseMap_ST( "Main UVs", Vector ) = ( 1, 1, 0, 0 )
		[Enum(SpecularAlpha,0,AlbedoAlpha,1)][Space(10)] _Smoothnesstexturechannel( "Smoothness texture channel", Float ) = 1
		_Glossiness( "Smoothness", Range( 0, 1 ) ) = 0.5
		_GlossMapScale( "Smoothness", Range( 0, 1 ) ) = 1
		[LS_DrawerTextureSingleLine][Space(10)] _OcclusionMap( "Occlusion Map", 2D ) = "white" {}
		_OcclusionStrength( "Occlusion Strength", Range( 0, 1 ) ) = 0
		[Normal][LS_DrawerTextureSingleLine][Space(10)] _BumpMap( "Normal Map", 2D ) = "bump" {}
		[Enum(Flip,0,Mirror,1,None,2)] _DoubleSidedNormalMode( "Normal Mode", Float ) = 0
		_BumpScale( "Normal Scale", Float ) = 1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_SURFACEINPUTS( "CATEGORYSPACE_SURFACE INPUTS", Float ) = 0
		[LS_DrawerCategory(SPECULAR,true,_SpecColor,0,0)] _CATEGORY_SPECULAR( "CATEGORY_SPECULAR", Float ) = 1
		[LS_DrawerTextureSingleLine] _SpecGlossMap( "Specular Map", 2D ) = "white" {}
		_SpecColor( "Specular Color", Color ) = ( 0.2, 0.2, 0.2, 0 )
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_SPECULAR( "CATEGORYSPACE_SPECULAR", Float ) = 0
		[LS_DrawerCategory(DETAIL,true,_DetailAlbedoMap,0,0)] _CATEGORY_DETAIL( "CATEGORY_DETAIL", Float ) = 1
		[LS_DrawerToggleLeft] _DETAIL_MULX2( "ENABLE DETAIL", Float ) = 0
		[LS_DrawerTextureSingleLine] _DetailAlbedoMap( "Base Map", 2D ) = "linearGrey" {}
		[LS_DrawerTextureSingleLine] _DetailMask( "Mask", 2D ) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _UVDetail( "UV Set", Float ) = 0
		[LS_DrawerTextureScaleOffset] _DetailAlbedoMap_ST( "Detail UVs", Vector ) = ( 1, 1, 0, 0 )
		[Normal][LS_DrawerTextureSingleLine] _DetailNormalMap( "Normal Map", 2D ) = "bump" {}
		_DetailNormalMapScale( "Normal Scale", Range( 0, 2 ) ) = 1
		_DetailAlbedoMapScale( "Detail Scale", Range( 0, 2 ) ) = 0.25
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_DETAIL( "CATEGORYSPACE_DETAIL", Float ) = 0
		[LS_DrawerCategory(EMISSION,true,_EmissionColor,0,0)] _CATEGORY_EMISSION( "CATEGORY_EMISSION", Float ) = 1
		[LS_DrawerToggleLeft] _EnableEmission( "ENABLE EMISSION", Float ) = 0
		[HDR] _EmissionColor( "Emissive Color", Color ) = ( 0, 0, 0, 0 )
		[LS_DrawerTextureSingleLine] _EmissionMap( "Emissive Color Map", 2D ) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _UVEmissive( "UV Set", Float ) = 0
		[LS_DrawerTextureScaleOffset] _EmissionMap_ST( "Emissive UVs", Vector ) = ( 1, 1, 0, 0 )
		[LS_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 0
		_EmissiveIntensity( "Emissive Intensity", Float ) = 1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_EMISSION( "CATEGORYSPACE_EMISSION", Float ) = 0
		[LS_DrawerCategory(TRANSMISSION,true,_TransmissionMapEnable,0,0)] _CATEGORY_TRANSMISSION( "CATEGORY_TRANSMISSION", Float ) = 1
		[LS_DrawerToggleLeft] _TransmissionMapEnable( "ENABLE TRANSMISSION", Float ) = 0
		[LS_DrawerTextureSingleLine] _TransmissionMap( "Transmission Map", 2D ) = "white" {}
		[Toggle] _TransmissionMapInverted( "Transmission Map Inverted", Float ) = 0
		[HDR] _TransmissionColor( "Transmission Color", Color ) = ( 0.5, 0.5, 0.5, 1 )
		_TransmissionStrength( "Transmission Strength", Range( 0, 50 ) ) = 0.15
		_TransmissionFeather( "Transmission Feather", Range( 0, 2 ) ) = 1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_TRANSMISSION( "CATEGORYSPACE_TRANSMISSION", Float ) = 0
		[LS_DrawerCategory(TRANSLUCENCY,true,_TranslucencyMapEnable,0,0)] _CATEGORY_TRANSLUCENCY( "CATEGORY_TRANSLUCENCY", Float ) = 1
		[LS_DrawerToggleLeft] _TranslucencyMapEnable( "ENABLE TRANSLUCENCY", Float ) = 0
		[LS_DrawerTextureSingleLine] _TranslucencyMap( "Translucency Map", 2D ) = "white" {}
		[Toggle] _TranslucencyMapInverted( "Translucency Map Inverted", Float ) = 0
		[HDR] _TranslucencyColor( "Translucency Color", Color ) = ( 0.35, 0.35, 0.35, 1 )
		_TranslucencyStrength( "Translucency Strength", Range( 0, 50 ) ) = 0.5
		_TranslucencyFeather( "Translucency Feather", Range( 0, 2 ) ) = 1
		_TranslucencyNormalDistortion( "Translucency Normal Distortion", Range( 0, 1 ) ) = 0.3
		_TranslucencyScattering( "Translucency Scatterring", Range( 1, 50 ) ) = 1
		_TranslucencyDirect( "Translucency Direct", Range( 0, 1 ) ) = 0.4510137
		_TranslucencyAmbient( "Translucency Ambient", Range( 0, 1 ) ) = 0.65
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_TRANSLUCENCY( "CATEGORYSPACE_TRANSLUCENCY", Float ) = 0
		[LS_DrawerCategory(COAT MASK,true,_ClearCoat,0,0)] _CATEGORY_COATMASK( "CATEGORY_COATMASK", Float ) = 1
		[LS_DrawerToggleLeft] _ClearCoat( "ENABLE COAT MASK", Float ) = 0
		[LS_DrawerTextureSingleLine] _ClearCoatMap( "Clear Coat Map", 2D ) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _ClearCoatUVMapping( "UV Set", Float ) = 0
		[LS_DrawerTextureScaleOffset] _ClearCoatMap_ST( "Clear Coat UVs", Vector ) = ( 1, 1, 0, 0 )
		_ClearCoatMask( "Clear Coat Mask", Range( 0, 1 ) ) = 0.75
		_ClearCoatSmoothness( "Clear Coat Smoothness", Range( 0, 1 ) ) = 0.95
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_COATMASK( "CATEGORYSPACE_COATMASK", Float ) = 0
		[LS_DrawerCategory(TRANSLUCENCY ASE,true,_ASETranslucencyStrength,0,0)] _CATEGORY_TRANSLUCENCYASE( "CATEGORY_TRANSLUCENCY ASE", Float ) = 0
		_ASETransmissionShadow( "ASE Transmission Shadow", Range( 0, 1 ) ) = 0.5
		_ASETranslucencyStrength( "ASE Translucency Strength", Range( 1, 50 ) ) = 1
		_ASETranslucencyNormalDistortion( "ASE Translucency Normal Distortion ", Range( 0, 1 ) ) = 0.2735869
		_ASETranslucencyScattering( "ASE Translucency Scattering ", Range( 1, 50 ) ) = 2
		_ASETranslucencyDirect( "ASE Translucency Direct ", Range( 0, 1 ) ) = 0
		_ASETranslucencyAmbient( "ASE Translucency Ambient", Range( 0, 1 ) ) = 0.8339342
		_ASETranslucencyShadow( "ASE Translucency Shadow ", Range( 0, 1 ) ) = 0.5
		[LS_DrawerCategorySpace(10)] _SPACE_TRANSLUCENCYASE( "SPACE_TRANSLUCENCYASE", Float ) = 0


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Shadow", Range( 0, 1 ) ) = 0.5
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

		

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="AlphaTest" "UniversalMaterialType"="Lit" }

		Cull [_Cull]
		ZWrite On
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

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			

			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _ALPHATEST_SHADOW_ON 1
			#define ASE_TRANSMISSION 1
			#define ASE_TRANSLUCENCY 1
			#define shader_feature_local_fragment _ _CLEARCOAT
			#define _CLEARCOAT 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#ifdef UNITY_COLORSPACE_GAMMA//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(2.0, 2.0, 2.0, 2.0)//ASE Color Space Def
			#else // Linear values//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(4.59479380, 4.59479380, 4.59479380, 2.0)//ASE Color Space Def
			#endif//ASE Color Space Def
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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_SCREEN_POSITION_NORMALIZED


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
			float4 _EmissionColor;
			float4 _EmissionMap_ST;
			float4 _TransmissionColor;
			float4 _BaseColor;
			float4 _BaseMap_ST;
			float4 _SpecColor;
			float4 _TranslucencyColor;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float _AlphaClip;
			half _Cutoff;
			float _CATEGORY_ALPHA;
			half _TransmissionStrength;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_ALPHA;
			float _EnableEmission;
			half _AlphaCutoffShadow;
			float _TransmissionFeather;
			float _TransmissionMapInverted;
			half _EmissionFlags;
			half _EmissiveIntensity;
			float _CATEGORYSPACE_EMISSION;
			float _CATEGORYSPACE_TRANSMISSION;
			float _CATEGORY_TRANSMISSION;
			float _CATEGORY_COATMASK;
			half _ClearCoat;
			float _ClearCoatMask;
			half _ClearCoatUVMapping;
			float _CATEGORYSPACE_TRANSLUCENCY;
			float _CATEGORY_TRANSLUCENCY;
			half _TransmissionMapEnable;
			half _TranslucencyMapEnable;
			float _TranslucencyMapInverted;
			float _TranslucencyFeather;
			float _TranslucencyAmbient;
			float _TranslucencyDirect;
			float _TranslucencyScattering;
			float _TranslucencyNormalDistortion;
			float _TranslucencyStrength;
			float _ASETranslucencyShadow;
			float _UVEmissive;
			float _OcclusionStrength;
			float _ASETranslucencyAmbient;
			float _ASETranslucencyDirect;
			float _ASETranslucencyScattering;
			float _ASETranslucencyNormalDistortion;
			float _ASETranslucencyStrength;
			float _ASETransmissionShadow;
			float _CATEGORY_SURFACESETTINGS;
			int _Cull;
			float _SPACE_SURFACESETTINGS;
			float _SPACE_TRANSLUCENCYASE;
			float _CATEGORY_TRANSLUCENCYASE;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORY_SPECULAR;
			float _Smoothnesstexturechannel;
			float _EnableClipGlancingAngle;
			float _CATEGORYSPACE_COATMASK;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORY_DETAIL;
			float _DETAIL_MULX2;
			float _DetailAlbedoMapScale;
			float _UVDetail;
			float _DetailNormalMapScale;
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

			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_DetailAlbedoMap);
			TEXTURE2D(_DetailMask);
			SAMPLER(sampler_DetailMask);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_SpecGlossMap);
			TEXTURE2D(_OcclusionMap);
			TEXTURE2D(_EmissionMap);
			SAMPLER(sampler_EmissionMap);
			TEXTURE2D(_TransmissionMap);
			TEXTURE2D(_TranslucencyMap);
			TEXTURE2D(_ClearCoatMap);
			SAMPLER(sampler_ClearCoatMap);


			float2 float2switchUVMode566_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode592_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float3 ASEBakedGI( float3 normalWS, float2 uvStaticLightmap, bool applyScaling )
			{
			#ifdef LIGHTMAP_ON
				if( applyScaling )
					uvStaticLightmap = uvStaticLightmap * unity_LightmapST.xy + unity_LightmapST.zw;
				return SampleLightmap( uvStaticLightmap, normalWS );
			#else
				return SampleSH(normalWS);
			#endif
			}
			
			float2 float2switchUVMode3404_g61667( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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

				float m_switch566_g61668 = _UVBase;
				float2 m_UV0566_g61668 = input.ase_texcoord6.xy;
				float2 m_UV1566_g61668 = input.ase_texcoord6.zw;
				float2 m_UV2566_g61668 = input.ase_texcoord7.xy;
				float2 m_UV3566_g61668 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode566_g61668 = float2switchUVMode566_g61668( m_switch566_g61668 , m_UV0566_g61668 , m_UV1566_g61668 , m_UV2566_g61668 , m_UV3566_g61668 );
				float2 appendResult772_g61668 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g61668 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g61668 = ( ( localfloat2switchUVMode566_g61668 * appendResult772_g61668 ) + appendResult773_g61668 );
				float4 temp_output_2_0_g61673 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				float3 temp_output_2444_0_g61668 = ( (temp_output_2_0_g61673).rgb * (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_COLOR + _CATEGORYSPACE_COLOR + _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) );
				float m_switch571_g61668 = _UVDetail;
				float2 m_UV0571_g61668 = input.ase_texcoord6.xy;
				float2 m_UV1571_g61668 = input.ase_texcoord6.zw;
				float2 m_UV2571_g61668 = input.ase_texcoord7.xy;
				float2 m_UV3571_g61668 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode571_g61668 = float2switchUVMode571_g61668( m_switch571_g61668 , m_UV0571_g61668 , m_UV1571_g61668 , m_UV2571_g61668 , m_UV3571_g61668 );
				float2 appendResult574_g61668 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g61668 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g61668 = ( ( localfloat2switchUVMode571_g61668 * appendResult574_g61668 ) + appendResult578_g61668 );
				float3 DetailMap2602_g61668 = (SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_BaseMap, UV_DetailMap583_g61668 )).rgb;
				float3 lerpResult3088_g61668 = lerp( DetailMap2602_g61668 , ( DetailMap2602_g61668 * (unity_ColorSpaceDouble).rgb ) , _DetailAlbedoMapScale);
				float DetailMask_A2207_g61668 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g61668 ).a;
				float temp_output_2_0_g61672 = DetailMask_A2207_g61668;
				float temp_output_3_0_g61672 = ( 1.0 - temp_output_2_0_g61672 );
				float3 appendResult7_g61672 = (float3(temp_output_3_0_g61672 , temp_output_3_0_g61672 , temp_output_3_0_g61672));
				float3 lerpResult3662_g61668 = lerp( temp_output_2444_0_g61668 , ( temp_output_2444_0_g61668 * ( ( lerpResult3088_g61668 * temp_output_2_0_g61672 ) + appendResult7_g61672 ) ) , ( _DETAIL_MULX2 + ( ( _CATEGORY_DETAIL + _CATEGORYSPACE_DETAIL ) * 0.0 ) ));
				
				float3 unpack268_g61668 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV_BaseMap2637_g61668 ), _BumpScale );
				unpack268_g61668.z = lerp( 1, unpack268_g61668.z, saturate(_BumpScale) );
				float3 unpack311_g61668 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_DetailNormalMap, UV_DetailMap583_g61668 ), _DetailNormalMapScale );
				unpack311_g61668.z = lerp( 1, unpack311_g61668.z, saturate(_DetailNormalMapScale) );
				float2 weightedBlendVar3825_g61668 = float2( 0.5,0.5 );
				float3 weightedBlend3825_g61668 = ( weightedBlendVar3825_g61668.x*unpack268_g61668 + weightedBlendVar3825_g61668.y*unpack311_g61668 );
				float3 lerpResult2330_g61668 = lerp( unpack268_g61668 , weightedBlend3825_g61668 , DetailMask_A2207_g61668);
				float ENABLE_DETAIL3658_g61668 = _DETAIL_MULX2;
				float3 lerpResult3665_g61668 = lerp( unpack268_g61668 , lerpResult2330_g61668 , ENABLE_DETAIL3658_g61668);
				float m_switch3120_g61668 = _DoubleSidedNormalMode;
				float3 m_Flip3120_g61668 = float3( -1, -1, -1 );
				float3 m_Mirror3120_g61668 = float3( 1, 1, -1 );
				float3 m_None3120_g61668 = float3( 1, 1, 1 );
				float3 local_NormalModefloat3switch3120_g61668 = _NormalModefloat3switch( m_switch3120_g61668 , m_Flip3120_g61668 , m_Mirror3120_g61668 , m_None3120_g61668 );
				float3 switchResult3114_g61668 = (((ase_vface>0)?(lerpResult3665_g61668):(( lerpResult3665_g61668 * local_NormalModefloat3switch3120_g61668 ))));
				
				float4 temp_output_2_0_g61670 = SAMPLE_TEXTURE2D( _SpecGlossMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				
				float Alpha_SpecGlossMap707_g61668 = (temp_output_2_0_g61670).a;
				float3 temp_output_102_0_g61671 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g61671 = normalize( temp_output_102_0_g61671 );
				float dotResult3155_g61668 = dot( normalizeResult79_g61671 , ViewDirWS );
				float temp_output_3157_0_g61668 = ( 1.0 - abs( dotResult3155_g61668 ) );
				#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch3161_g61668 = 1.0;
				#else
				float staticSwitch3161_g61668 = ( 1.0 - ( temp_output_3157_0_g61668 * temp_output_3157_0_g61668 ) );
				#endif
				float lerpResult3164_g61668 = lerp( 1.0 , staticSwitch3161_g61668 , _EnableClipGlancingAngle);
				float temp_output_3172_0_g61668 = ( (temp_output_2_0_g61673).a * lerpResult3164_g61668 );
				float Alpha_BaseColor2431_g61668 = temp_output_3172_0_g61668;
				float temp_output_3636_0_g61668 = ( _Smoothnesstexturechannel + ( ( _CATEGORY_SPECULAR + _CATEGORYSPACE_SPECULAR ) * 0.0 ) );
				float lerpResult3621_g61668 = lerp( Alpha_SpecGlossMap707_g61668 , Alpha_BaseColor2431_g61668 , temp_output_3636_0_g61668);
				float lerpResult3619_g61668 = lerp( _GlossMapScale , _Glossiness , temp_output_3636_0_g61668);
				
				float4 tex2DNode610_g61668 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				
				half3 color3067_g61668 = IsGammaSpace() ? half3( 0.003921569, 0, 0 ) : half3( 0.000303527, 0, 0 );
				float m_switch592_g61668 = _UVEmissive;
				float2 m_UV0592_g61668 = input.ase_texcoord6.xy;
				float2 m_UV1592_g61668 = input.ase_texcoord6.zw;
				float2 m_UV2592_g61668 = input.ase_texcoord7.xy;
				float2 m_UV3592_g61668 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode592_g61668 = float2switchUVMode592_g61668( m_switch592_g61668 , m_UV0592_g61668 , m_UV1592_g61668 , m_UV2592_g61668 , m_UV3592_g61668 );
				float2 appendResult593_g61668 = (float2(_EmissionMap_ST.x , _EmissionMap_ST.y));
				float2 appendResult595_g61668 = (float2(_EmissionMap_ST.z , _EmissionMap_ST.w));
				float2 UV_EmissiveMap597_g61668 = ( ( localfloat2switchUVMode592_g61668 * appendResult593_g61668 ) + appendResult595_g61668 );
				float3 lerpResult3649_g61668 = lerp( color3067_g61668 , ( (SAMPLE_TEXTURE2D( _EmissionMap, sampler_EmissionMap, UV_EmissiveMap597_g61668 )).rgb * ( (_EmissionColor).rgb * ( _EmissiveIntensity + ( _EmissionFlags * 0.0 ) ) ) ) , ( _EnableEmission + ( ( _CATEGORY_EMISSION + _CATEGORYSPACE_EMISSION ) * 0.0 ) ));
				
				float lerpResult3842_g61668 = lerp( 1.0 , temp_output_3172_0_g61668 , _AlphaClip);
				
				float3 Normal3850_g61668 = unpack268_g61668;
				float3 temp_output_3978_0_g61674 = Normal3850_g61668;
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal3967_g61674 = temp_output_3978_0_g61674;
				float3 worldNormal3967_g61674 = normalize( float3( dot( tanToWorld0, tanNormal3967_g61674 ), dot( tanToWorld1, tanNormal3967_g61674 ), dot( tanToWorld2, tanNormal3967_g61674 ) ) );
				float dotResult4003_g61674 = dot( worldNormal3967_g61674 , SafeNormalize( _MainLightPosition.xyz ) );
				float NdotL_Inv3932_g61674 = max( -dotResult4003_g61674 , 0.0 );
				float ase_lightIntensity = max( max( _MainLightColor.r, _MainLightColor.g ), _MainLightColor.b ) + 1e-7;
				float4 ase_lightColor = float4( _MainLightColor.rgb / ase_lightIntensity, ase_lightIntensity );
				float3 MainLightColor3933_g61674 = ase_lightColor.rgb;
				float3 BaseColorMap3848_g61668 = temp_output_2444_0_g61668;
				float3 BaseColor3935_g61674 = BaseColorMap3848_g61668;
				float3 temp_output_3860_0_g61674 = ( (SAMPLE_TEXTURE2D( _TransmissionMap, sampler_BaseMap, UV_BaseMap2637_g61668 )).rgb / max( _TransmissionFeather , 0.1 ) );
				float3 lerpResult3861_g61674 = lerp( temp_output_3860_0_g61674 , ( 1.0 - temp_output_3860_0_g61674 ) , _TransmissionMapInverted);
				float3 temp_output_3851_0_g61674 = (_TransmissionColor).rgb;
				
				float3 LightDir_WS3934_g61674 = SafeNormalize( _MainLightPosition.xyz );
				float3 Normal_WS3973_g61674 = worldNormal3967_g61674;
				float3 ase_viewVectorOS = mul( ( float3x3 )GetWorldToObjectMatrix(), ( _WorldSpaceCameraPos.xyz - PositionWS ) );
				float3 ase_viewDirSafeOS = SafeNormalize( ase_viewVectorOS );
				float3 ViewDir_WS3964_g61674 = ase_viewDirSafeOS;
				float dotResult3798_g61674 = dot( -( LightDir_WS3934_g61674 + ( Normal_WS3973_g61674 * _TranslucencyNormalDistortion ) ) , ViewDir_WS3964_g61674 );
				float3 bakedGI3939_g61674 = ASEBakedGI( Normal_WS3973_g61674, (input.ase_texcoord6.zw*(unity_LightmapST).xy + (unity_LightmapST).zw), true);
				float Occlusion3853_g61668 = saturate( ( tex2DNode610_g61668.r * ( 1.0 - _OcclusionStrength ) ) );
				float3 Indirect_Diffuse3983_g61674 = ( bakedGI3939_g61674 * Occlusion3853_g61668 * 0.5 );
				float3 temp_output_3840_0_g61674 = ( (SAMPLE_TEXTURE2D( _TranslucencyMap, sampler_BaseMap, UV_BaseMap2637_g61668 )).rgb / max( _TranslucencyFeather , 0.1 ) );
				float3 lerpResult3837_g61674 = lerp( temp_output_3840_0_g61674 , ( 1.0 - temp_output_3840_0_g61674 ) , _TranslucencyMapInverted);
				
				float m_switch3404_g61667 = _ClearCoatUVMapping;
				float2 m_UV03404_g61667 = input.ase_texcoord6.xy;
				float2 m_UV13404_g61667 = input.ase_texcoord6.zw;
				float2 m_UV23404_g61667 = input.ase_texcoord7.xy;
				float2 m_UV33404_g61667 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode3404_g61667 = float2switchUVMode3404_g61667( m_switch3404_g61667 , m_UV03404_g61667 , m_UV13404_g61667 , m_UV23404_g61667 , m_UV33404_g61667 );
				float2 appendResult3396_g61667 = (float2(_ClearCoatMap_ST.x , _ClearCoatMap_ST.y));
				float2 appendResult3397_g61667 = (float2(_ClearCoatMap_ST.z , _ClearCoatMap_ST.w));
				float4 tex2DNode3387_g61667 = SAMPLE_TEXTURE2D( _ClearCoatMap, sampler_ClearCoatMap, ( ( localfloat2switchUVMode3404_g61667 * appendResult3396_g61667 ) + appendResult3397_g61667 ) );
				float temp_output_3752_0_g61667 = ( _ClearCoat + ( ( _CATEGORY_COATMASK + _CATEGORYSPACE_COATMASK ) * 0.0 ) );
				float lerpResult3385_g61667 = lerp( 0.0 , ( tex2DNode3387_g61667.r * _ClearCoatMask ) , temp_output_3752_0_g61667);
				
				float lerpResult3409_g61667 = lerp( 0.0 , ( tex2DNode3387_g61667.g * _ClearCoatSmoothness ) , temp_output_3752_0_g61667);
				

				float3 BaseColor = lerpResult3662_g61668;
				float3 Normal = switchResult3114_g61668;
				float3 Specular = ( (_SpecColor).rgb * (temp_output_2_0_g61670).rgb );
				float Metallic = 0;
				float Smoothness = ( lerpResult3621_g61668 * lerpResult3619_g61668 );
				float Occlusion = saturate( ( tex2DNode610_g61668.r * ( 1.0 - _OcclusionStrength ) ) );
				float3 Emission = lerpResult3649_g61668;
				float Alpha = lerpResult3842_g61668;
				float AlphaClipThreshold = ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) );
				float AlphaClipThresholdShadow = _AlphaCutoffShadow;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = ( ( NdotL_Inv3932_g61674 * MainLightColor3933_g61674 * BaseColor3935_g61674 * ( lerpResult3861_g61674 * temp_output_3851_0_g61674 ) * _TransmissionStrength ) * ( _TransmissionMapEnable + ( ( _CATEGORY_TRANSMISSION + _CATEGORYSPACE_TRANSMISSION ) * 0.0 ) ) );
				float3 Translucency = ( ( ( ( pow( saturate( dotResult3798_g61674 ) , _TranslucencyScattering ) * _TranslucencyDirect ) + ( Indirect_Diffuse3983_g61674 * _TranslucencyAmbient ) ) * MainLightColor3933_g61674 * BaseColor3935_g61674 * lerpResult3837_g61674 * (_TranslucencyColor).rgb * _TranslucencyStrength ) * ( _TranslucencyMapEnable + ( ( _CATEGORY_TRANSLUCENCY + _CATEGORYSPACE_TRANSLUCENCY ) * 0.0 ) ) );

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = ClipPos.z;
				#endif

				#ifdef _CLEARCOAT
					float CoatMask = lerpResult3385_g61667;
					float CoatSmoothness = lerpResult3409_g61667;
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
					float shadow = _ASETransmissionShadow;

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
					float shadow = _ASETranslucencyShadow;
					float normal = _ASETranslucencyNormalDistortion;
					float scattering = _ASETranslucencyScattering;
					float direct = _ASETranslucencyDirect;
					float ambient = _ASETranslucencyAmbient;
					float strength = _ASETranslucencyStrength;

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

			

			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _ALPHATEST_SHADOW_ON 1
			#define ASE_TRANSMISSION 1
			#define ASE_TRANSLUCENCY 1
			#define _EMISSION
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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _EmissionColor;
			float4 _EmissionMap_ST;
			float4 _TransmissionColor;
			float4 _BaseColor;
			float4 _BaseMap_ST;
			float4 _SpecColor;
			float4 _TranslucencyColor;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float _AlphaClip;
			half _Cutoff;
			float _CATEGORY_ALPHA;
			half _TransmissionStrength;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_ALPHA;
			float _EnableEmission;
			half _AlphaCutoffShadow;
			float _TransmissionFeather;
			float _TransmissionMapInverted;
			half _EmissionFlags;
			half _EmissiveIntensity;
			float _CATEGORYSPACE_EMISSION;
			float _CATEGORYSPACE_TRANSMISSION;
			float _CATEGORY_TRANSMISSION;
			float _CATEGORY_COATMASK;
			half _ClearCoat;
			float _ClearCoatMask;
			half _ClearCoatUVMapping;
			float _CATEGORYSPACE_TRANSLUCENCY;
			float _CATEGORY_TRANSLUCENCY;
			half _TransmissionMapEnable;
			half _TranslucencyMapEnable;
			float _TranslucencyMapInverted;
			float _TranslucencyFeather;
			float _TranslucencyAmbient;
			float _TranslucencyDirect;
			float _TranslucencyScattering;
			float _TranslucencyNormalDistortion;
			float _TranslucencyStrength;
			float _ASETranslucencyShadow;
			float _UVEmissive;
			float _OcclusionStrength;
			float _ASETranslucencyAmbient;
			float _ASETranslucencyDirect;
			float _ASETranslucencyScattering;
			float _ASETranslucencyNormalDistortion;
			float _ASETranslucencyStrength;
			float _ASETransmissionShadow;
			float _CATEGORY_SURFACESETTINGS;
			int _Cull;
			float _SPACE_SURFACESETTINGS;
			float _SPACE_TRANSLUCENCYASE;
			float _CATEGORY_TRANSLUCENCYASE;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORY_SPECULAR;
			float _Smoothnesstexturechannel;
			float _EnableClipGlancingAngle;
			float _CATEGORYSPACE_COATMASK;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORY_DETAIL;
			float _DETAIL_MULX2;
			float _DetailAlbedoMapScale;
			float _UVDetail;
			float _DetailNormalMapScale;
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

			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);


			float3 _LightDirection;
			float3 _LightPosition;

			float2 float2switchUVMode566_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			

			PackedVaryings VertexFunction( Attributes input )
			{
				PackedVaryings output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				output.ase_texcoord1.xy = input.ase_texcoord.xy;
				output.ase_texcoord1.zw = input.ase_texcoord1.xy;
				output.ase_texcoord2.xy = input.ase_texcoord2.xy;
				output.ase_texcoord2.zw = input.ase_texcoord3.xy;

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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
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
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_texcoord2 = input.ase_texcoord2;
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
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

				float m_switch566_g61668 = _UVBase;
				float2 m_UV0566_g61668 = input.ase_texcoord1.xy;
				float2 m_UV1566_g61668 = input.ase_texcoord1.zw;
				float2 m_UV2566_g61668 = input.ase_texcoord2.xy;
				float2 m_UV3566_g61668 = input.ase_texcoord2.zw;
				float2 localfloat2switchUVMode566_g61668 = float2switchUVMode566_g61668( m_switch566_g61668 , m_UV0566_g61668 , m_UV1566_g61668 , m_UV2566_g61668 , m_UV3566_g61668 );
				float2 appendResult772_g61668 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g61668 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g61668 = ( ( localfloat2switchUVMode566_g61668 * appendResult772_g61668 ) + appendResult773_g61668 );
				float4 temp_output_2_0_g61673 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				float3 temp_output_102_0_g61671 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g61671 = normalize( temp_output_102_0_g61671 );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - PositionWS );
				float3 ase_viewDirSafeWS = SafeNormalize( ase_viewVectorWS );
				float dotResult3155_g61668 = dot( normalizeResult79_g61671 , ase_viewDirSafeWS );
				float temp_output_3157_0_g61668 = ( 1.0 - abs( dotResult3155_g61668 ) );
				#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch3161_g61668 = 1.0;
				#else
				float staticSwitch3161_g61668 = ( 1.0 - ( temp_output_3157_0_g61668 * temp_output_3157_0_g61668 ) );
				#endif
				float lerpResult3164_g61668 = lerp( 1.0 , staticSwitch3161_g61668 , _EnableClipGlancingAngle);
				float temp_output_3172_0_g61668 = ( (temp_output_2_0_g61673).a * lerpResult3164_g61668 );
				float lerpResult3842_g61668 = lerp( 1.0 , temp_output_3172_0_g61668 , _AlphaClip);
				

				float Alpha = lerpResult3842_g61668;
				float AlphaClipThreshold = ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) );
				float AlphaClipThresholdShadow = _AlphaCutoffShadow;

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

			

			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _ALPHATEST_SHADOW_ON 1
			#define ASE_TRANSMISSION 1
			#define ASE_TRANSLUCENCY 1
			#define _EMISSION
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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _EmissionColor;
			float4 _EmissionMap_ST;
			float4 _TransmissionColor;
			float4 _BaseColor;
			float4 _BaseMap_ST;
			float4 _SpecColor;
			float4 _TranslucencyColor;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float _AlphaClip;
			half _Cutoff;
			float _CATEGORY_ALPHA;
			half _TransmissionStrength;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_ALPHA;
			float _EnableEmission;
			half _AlphaCutoffShadow;
			float _TransmissionFeather;
			float _TransmissionMapInverted;
			half _EmissionFlags;
			half _EmissiveIntensity;
			float _CATEGORYSPACE_EMISSION;
			float _CATEGORYSPACE_TRANSMISSION;
			float _CATEGORY_TRANSMISSION;
			float _CATEGORY_COATMASK;
			half _ClearCoat;
			float _ClearCoatMask;
			half _ClearCoatUVMapping;
			float _CATEGORYSPACE_TRANSLUCENCY;
			float _CATEGORY_TRANSLUCENCY;
			half _TransmissionMapEnable;
			half _TranslucencyMapEnable;
			float _TranslucencyMapInverted;
			float _TranslucencyFeather;
			float _TranslucencyAmbient;
			float _TranslucencyDirect;
			float _TranslucencyScattering;
			float _TranslucencyNormalDistortion;
			float _TranslucencyStrength;
			float _ASETranslucencyShadow;
			float _UVEmissive;
			float _OcclusionStrength;
			float _ASETranslucencyAmbient;
			float _ASETranslucencyDirect;
			float _ASETranslucencyScattering;
			float _ASETranslucencyNormalDistortion;
			float _ASETranslucencyStrength;
			float _ASETransmissionShadow;
			float _CATEGORY_SURFACESETTINGS;
			int _Cull;
			float _SPACE_SURFACESETTINGS;
			float _SPACE_TRANSLUCENCYASE;
			float _CATEGORY_TRANSLUCENCYASE;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORY_SPECULAR;
			float _Smoothnesstexturechannel;
			float _EnableClipGlancingAngle;
			float _CATEGORYSPACE_COATMASK;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORY_DETAIL;
			float _DETAIL_MULX2;
			float _DetailAlbedoMapScale;
			float _UVDetail;
			float _DetailNormalMapScale;
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

			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);


			float2 float2switchUVMode566_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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

				output.ase_texcoord1.xy = input.ase_texcoord.xy;
				output.ase_texcoord1.zw = input.ase_texcoord1.xy;
				output.ase_texcoord2.xy = input.ase_texcoord2.xy;
				output.ase_texcoord2.zw = input.ase_texcoord3.xy;

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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
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
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_texcoord2 = input.ase_texcoord2;
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
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

				float m_switch566_g61668 = _UVBase;
				float2 m_UV0566_g61668 = input.ase_texcoord1.xy;
				float2 m_UV1566_g61668 = input.ase_texcoord1.zw;
				float2 m_UV2566_g61668 = input.ase_texcoord2.xy;
				float2 m_UV3566_g61668 = input.ase_texcoord2.zw;
				float2 localfloat2switchUVMode566_g61668 = float2switchUVMode566_g61668( m_switch566_g61668 , m_UV0566_g61668 , m_UV1566_g61668 , m_UV2566_g61668 , m_UV3566_g61668 );
				float2 appendResult772_g61668 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g61668 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g61668 = ( ( localfloat2switchUVMode566_g61668 * appendResult772_g61668 ) + appendResult773_g61668 );
				float4 temp_output_2_0_g61673 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				float3 temp_output_102_0_g61671 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g61671 = normalize( temp_output_102_0_g61671 );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - PositionWS );
				float3 ase_viewDirSafeWS = SafeNormalize( ase_viewVectorWS );
				float dotResult3155_g61668 = dot( normalizeResult79_g61671 , ase_viewDirSafeWS );
				float temp_output_3157_0_g61668 = ( 1.0 - abs( dotResult3155_g61668 ) );
				#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch3161_g61668 = 1.0;
				#else
				float staticSwitch3161_g61668 = ( 1.0 - ( temp_output_3157_0_g61668 * temp_output_3157_0_g61668 ) );
				#endif
				float lerpResult3164_g61668 = lerp( 1.0 , staticSwitch3161_g61668 , _EnableClipGlancingAngle);
				float temp_output_3172_0_g61668 = ( (temp_output_2_0_g61673).a * lerpResult3164_g61668 );
				float lerpResult3842_g61668 = lerp( 1.0 , temp_output_3172_0_g61668 , _AlphaClip);
				

				float Alpha = lerpResult3842_g61668;
				float AlphaClipThreshold = ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) );

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
			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _ALPHATEST_SHADOW_ON 1
			#define ASE_TRANSMISSION 1
			#define ASE_TRANSLUCENCY 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#ifdef UNITY_COLORSPACE_GAMMA//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(2.0, 2.0, 2.0, 2.0)//ASE Color Space Def
			#else // Linear values//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(4.59479380, 4.59479380, 4.59479380, 2.0)//ASE Color Space Def
			#endif//ASE Color Space Def
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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
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
			float4 _EmissionColor;
			float4 _EmissionMap_ST;
			float4 _TransmissionColor;
			float4 _BaseColor;
			float4 _BaseMap_ST;
			float4 _SpecColor;
			float4 _TranslucencyColor;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float _AlphaClip;
			half _Cutoff;
			float _CATEGORY_ALPHA;
			half _TransmissionStrength;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_ALPHA;
			float _EnableEmission;
			half _AlphaCutoffShadow;
			float _TransmissionFeather;
			float _TransmissionMapInverted;
			half _EmissionFlags;
			half _EmissiveIntensity;
			float _CATEGORYSPACE_EMISSION;
			float _CATEGORYSPACE_TRANSMISSION;
			float _CATEGORY_TRANSMISSION;
			float _CATEGORY_COATMASK;
			half _ClearCoat;
			float _ClearCoatMask;
			half _ClearCoatUVMapping;
			float _CATEGORYSPACE_TRANSLUCENCY;
			float _CATEGORY_TRANSLUCENCY;
			half _TransmissionMapEnable;
			half _TranslucencyMapEnable;
			float _TranslucencyMapInverted;
			float _TranslucencyFeather;
			float _TranslucencyAmbient;
			float _TranslucencyDirect;
			float _TranslucencyScattering;
			float _TranslucencyNormalDistortion;
			float _TranslucencyStrength;
			float _ASETranslucencyShadow;
			float _UVEmissive;
			float _OcclusionStrength;
			float _ASETranslucencyAmbient;
			float _ASETranslucencyDirect;
			float _ASETranslucencyScattering;
			float _ASETranslucencyNormalDistortion;
			float _ASETranslucencyStrength;
			float _ASETransmissionShadow;
			float _CATEGORY_SURFACESETTINGS;
			int _Cull;
			float _SPACE_SURFACESETTINGS;
			float _SPACE_TRANSLUCENCYASE;
			float _CATEGORY_TRANSLUCENCYASE;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORY_SPECULAR;
			float _Smoothnesstexturechannel;
			float _EnableClipGlancingAngle;
			float _CATEGORYSPACE_COATMASK;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORY_DETAIL;
			float _DETAIL_MULX2;
			float _DetailAlbedoMapScale;
			float _UVDetail;
			float _DetailNormalMapScale;
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

			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_DetailAlbedoMap);
			TEXTURE2D(_DetailMask);
			SAMPLER(sampler_DetailMask);
			TEXTURE2D(_EmissionMap);
			SAMPLER(sampler_EmissionMap);


			float2 float2switchUVMode566_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode592_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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

				output.ase_texcoord3.xy = input.texcoord0.xy;
				output.ase_texcoord3.zw = input.texcoord1.xy;
				output.ase_texcoord4.xy = input.texcoord2.xy;
				output.ase_texcoord4.zw = input.ase_texcoord3.xy;

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

				float m_switch566_g61668 = _UVBase;
				float2 m_UV0566_g61668 = input.ase_texcoord3.xy;
				float2 m_UV1566_g61668 = input.ase_texcoord3.zw;
				float2 m_UV2566_g61668 = input.ase_texcoord4.xy;
				float2 m_UV3566_g61668 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode566_g61668 = float2switchUVMode566_g61668( m_switch566_g61668 , m_UV0566_g61668 , m_UV1566_g61668 , m_UV2566_g61668 , m_UV3566_g61668 );
				float2 appendResult772_g61668 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g61668 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g61668 = ( ( localfloat2switchUVMode566_g61668 * appendResult772_g61668 ) + appendResult773_g61668 );
				float4 temp_output_2_0_g61673 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				float3 temp_output_2444_0_g61668 = ( (temp_output_2_0_g61673).rgb * (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_COLOR + _CATEGORYSPACE_COLOR + _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) );
				float m_switch571_g61668 = _UVDetail;
				float2 m_UV0571_g61668 = input.ase_texcoord3.xy;
				float2 m_UV1571_g61668 = input.ase_texcoord3.zw;
				float2 m_UV2571_g61668 = input.ase_texcoord4.xy;
				float2 m_UV3571_g61668 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode571_g61668 = float2switchUVMode571_g61668( m_switch571_g61668 , m_UV0571_g61668 , m_UV1571_g61668 , m_UV2571_g61668 , m_UV3571_g61668 );
				float2 appendResult574_g61668 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g61668 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g61668 = ( ( localfloat2switchUVMode571_g61668 * appendResult574_g61668 ) + appendResult578_g61668 );
				float3 DetailMap2602_g61668 = (SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_BaseMap, UV_DetailMap583_g61668 )).rgb;
				float3 lerpResult3088_g61668 = lerp( DetailMap2602_g61668 , ( DetailMap2602_g61668 * (unity_ColorSpaceDouble).rgb ) , _DetailAlbedoMapScale);
				float DetailMask_A2207_g61668 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g61668 ).a;
				float temp_output_2_0_g61672 = DetailMask_A2207_g61668;
				float temp_output_3_0_g61672 = ( 1.0 - temp_output_2_0_g61672 );
				float3 appendResult7_g61672 = (float3(temp_output_3_0_g61672 , temp_output_3_0_g61672 , temp_output_3_0_g61672));
				float3 lerpResult3662_g61668 = lerp( temp_output_2444_0_g61668 , ( temp_output_2444_0_g61668 * ( ( lerpResult3088_g61668 * temp_output_2_0_g61672 ) + appendResult7_g61672 ) ) , ( _DETAIL_MULX2 + ( ( _CATEGORY_DETAIL + _CATEGORYSPACE_DETAIL ) * 0.0 ) ));
				
				half3 color3067_g61668 = IsGammaSpace() ? half3( 0.003921569, 0, 0 ) : half3( 0.000303527, 0, 0 );
				float m_switch592_g61668 = _UVEmissive;
				float2 m_UV0592_g61668 = input.ase_texcoord3.xy;
				float2 m_UV1592_g61668 = input.ase_texcoord3.zw;
				float2 m_UV2592_g61668 = input.ase_texcoord4.xy;
				float2 m_UV3592_g61668 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode592_g61668 = float2switchUVMode592_g61668( m_switch592_g61668 , m_UV0592_g61668 , m_UV1592_g61668 , m_UV2592_g61668 , m_UV3592_g61668 );
				float2 appendResult593_g61668 = (float2(_EmissionMap_ST.x , _EmissionMap_ST.y));
				float2 appendResult595_g61668 = (float2(_EmissionMap_ST.z , _EmissionMap_ST.w));
				float2 UV_EmissiveMap597_g61668 = ( ( localfloat2switchUVMode592_g61668 * appendResult593_g61668 ) + appendResult595_g61668 );
				float3 lerpResult3649_g61668 = lerp( color3067_g61668 , ( (SAMPLE_TEXTURE2D( _EmissionMap, sampler_EmissionMap, UV_EmissiveMap597_g61668 )).rgb * ( (_EmissionColor).rgb * ( _EmissiveIntensity + ( _EmissionFlags * 0.0 ) ) ) ) , ( _EnableEmission + ( ( _CATEGORY_EMISSION + _CATEGORYSPACE_EMISSION ) * 0.0 ) ));
				
				float3 temp_output_102_0_g61671 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g61671 = normalize( temp_output_102_0_g61671 );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - PositionWS );
				float3 ase_viewDirSafeWS = SafeNormalize( ase_viewVectorWS );
				float dotResult3155_g61668 = dot( normalizeResult79_g61671 , ase_viewDirSafeWS );
				float temp_output_3157_0_g61668 = ( 1.0 - abs( dotResult3155_g61668 ) );
				#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch3161_g61668 = 1.0;
				#else
				float staticSwitch3161_g61668 = ( 1.0 - ( temp_output_3157_0_g61668 * temp_output_3157_0_g61668 ) );
				#endif
				float lerpResult3164_g61668 = lerp( 1.0 , staticSwitch3161_g61668 , _EnableClipGlancingAngle);
				float temp_output_3172_0_g61668 = ( (temp_output_2_0_g61673).a * lerpResult3164_g61668 );
				float lerpResult3842_g61668 = lerp( 1.0 , temp_output_3172_0_g61668 , _AlphaClip);
				

				float3 BaseColor = lerpResult3662_g61668;
				float3 Emission = lerpResult3649_g61668;
				float Alpha = lerpResult3842_g61668;
				float AlphaClipThreshold = ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) );

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

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM

			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _ALPHATEST_SHADOW_ON 1
			#define ASE_TRANSMISSION 1
			#define ASE_TRANSLUCENCY 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#ifdef UNITY_COLORSPACE_GAMMA//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(2.0, 2.0, 2.0, 2.0)//ASE Color Space Def
			#else // Linear values//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(4.59479380, 4.59479380, 4.59479380, 2.0)//ASE Color Space Def
			#endif//ASE Color Space Def
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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
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
			float4 _EmissionColor;
			float4 _EmissionMap_ST;
			float4 _TransmissionColor;
			float4 _BaseColor;
			float4 _BaseMap_ST;
			float4 _SpecColor;
			float4 _TranslucencyColor;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float _AlphaClip;
			half _Cutoff;
			float _CATEGORY_ALPHA;
			half _TransmissionStrength;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_ALPHA;
			float _EnableEmission;
			half _AlphaCutoffShadow;
			float _TransmissionFeather;
			float _TransmissionMapInverted;
			half _EmissionFlags;
			half _EmissiveIntensity;
			float _CATEGORYSPACE_EMISSION;
			float _CATEGORYSPACE_TRANSMISSION;
			float _CATEGORY_TRANSMISSION;
			float _CATEGORY_COATMASK;
			half _ClearCoat;
			float _ClearCoatMask;
			half _ClearCoatUVMapping;
			float _CATEGORYSPACE_TRANSLUCENCY;
			float _CATEGORY_TRANSLUCENCY;
			half _TransmissionMapEnable;
			half _TranslucencyMapEnable;
			float _TranslucencyMapInverted;
			float _TranslucencyFeather;
			float _TranslucencyAmbient;
			float _TranslucencyDirect;
			float _TranslucencyScattering;
			float _TranslucencyNormalDistortion;
			float _TranslucencyStrength;
			float _ASETranslucencyShadow;
			float _UVEmissive;
			float _OcclusionStrength;
			float _ASETranslucencyAmbient;
			float _ASETranslucencyDirect;
			float _ASETranslucencyScattering;
			float _ASETranslucencyNormalDistortion;
			float _ASETranslucencyStrength;
			float _ASETransmissionShadow;
			float _CATEGORY_SURFACESETTINGS;
			int _Cull;
			float _SPACE_SURFACESETTINGS;
			float _SPACE_TRANSLUCENCYASE;
			float _CATEGORY_TRANSLUCENCYASE;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORY_SPECULAR;
			float _Smoothnesstexturechannel;
			float _EnableClipGlancingAngle;
			float _CATEGORYSPACE_COATMASK;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORY_DETAIL;
			float _DETAIL_MULX2;
			float _DetailAlbedoMapScale;
			float _UVDetail;
			float _DetailNormalMapScale;
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

			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_DetailAlbedoMap);
			TEXTURE2D(_DetailMask);
			SAMPLER(sampler_DetailMask);


			float2 float2switchUVMode566_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_TRANSFER_INSTANCE_ID( input, output );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				output.ase_texcoord1.xy = input.ase_texcoord.xy;
				output.ase_texcoord1.zw = input.ase_texcoord1.xy;
				output.ase_texcoord2.xy = input.ase_texcoord2.xy;
				output.ase_texcoord2.zw = input.ase_texcoord3.xy;

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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
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
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_texcoord2 = input.ase_texcoord2;
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
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

				float m_switch566_g61668 = _UVBase;
				float2 m_UV0566_g61668 = input.ase_texcoord1.xy;
				float2 m_UV1566_g61668 = input.ase_texcoord1.zw;
				float2 m_UV2566_g61668 = input.ase_texcoord2.xy;
				float2 m_UV3566_g61668 = input.ase_texcoord2.zw;
				float2 localfloat2switchUVMode566_g61668 = float2switchUVMode566_g61668( m_switch566_g61668 , m_UV0566_g61668 , m_UV1566_g61668 , m_UV2566_g61668 , m_UV3566_g61668 );
				float2 appendResult772_g61668 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g61668 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g61668 = ( ( localfloat2switchUVMode566_g61668 * appendResult772_g61668 ) + appendResult773_g61668 );
				float4 temp_output_2_0_g61673 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				float3 temp_output_2444_0_g61668 = ( (temp_output_2_0_g61673).rgb * (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_COLOR + _CATEGORYSPACE_COLOR + _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) );
				float m_switch571_g61668 = _UVDetail;
				float2 m_UV0571_g61668 = input.ase_texcoord1.xy;
				float2 m_UV1571_g61668 = input.ase_texcoord1.zw;
				float2 m_UV2571_g61668 = input.ase_texcoord2.xy;
				float2 m_UV3571_g61668 = input.ase_texcoord2.zw;
				float2 localfloat2switchUVMode571_g61668 = float2switchUVMode571_g61668( m_switch571_g61668 , m_UV0571_g61668 , m_UV1571_g61668 , m_UV2571_g61668 , m_UV3571_g61668 );
				float2 appendResult574_g61668 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g61668 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g61668 = ( ( localfloat2switchUVMode571_g61668 * appendResult574_g61668 ) + appendResult578_g61668 );
				float3 DetailMap2602_g61668 = (SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_BaseMap, UV_DetailMap583_g61668 )).rgb;
				float3 lerpResult3088_g61668 = lerp( DetailMap2602_g61668 , ( DetailMap2602_g61668 * (unity_ColorSpaceDouble).rgb ) , _DetailAlbedoMapScale);
				float DetailMask_A2207_g61668 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g61668 ).a;
				float temp_output_2_0_g61672 = DetailMask_A2207_g61668;
				float temp_output_3_0_g61672 = ( 1.0 - temp_output_2_0_g61672 );
				float3 appendResult7_g61672 = (float3(temp_output_3_0_g61672 , temp_output_3_0_g61672 , temp_output_3_0_g61672));
				float3 lerpResult3662_g61668 = lerp( temp_output_2444_0_g61668 , ( temp_output_2444_0_g61668 * ( ( lerpResult3088_g61668 * temp_output_2_0_g61672 ) + appendResult7_g61672 ) ) , ( _DETAIL_MULX2 + ( ( _CATEGORY_DETAIL + _CATEGORYSPACE_DETAIL ) * 0.0 ) ));
				
				float3 temp_output_102_0_g61671 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g61671 = normalize( temp_output_102_0_g61671 );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - PositionWS );
				float3 ase_viewDirSafeWS = SafeNormalize( ase_viewVectorWS );
				float dotResult3155_g61668 = dot( normalizeResult79_g61671 , ase_viewDirSafeWS );
				float temp_output_3157_0_g61668 = ( 1.0 - abs( dotResult3155_g61668 ) );
				#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch3161_g61668 = 1.0;
				#else
				float staticSwitch3161_g61668 = ( 1.0 - ( temp_output_3157_0_g61668 * temp_output_3157_0_g61668 ) );
				#endif
				float lerpResult3164_g61668 = lerp( 1.0 , staticSwitch3161_g61668 , _EnableClipGlancingAngle);
				float temp_output_3172_0_g61668 = ( (temp_output_2_0_g61673).a * lerpResult3164_g61668 );
				float lerpResult3842_g61668 = lerp( 1.0 , temp_output_3172_0_g61668 , _AlphaClip);
				

				float3 BaseColor = lerpResult3662_g61668;
				float Alpha = lerpResult3842_g61668;
				float AlphaClipThreshold = ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) );

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

			

			

			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _ALPHATEST_SHADOW_ON 1
			#define ASE_TRANSMISSION 1
			#define ASE_TRANSLUCENCY 1
			#define _EMISSION
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
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				half4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _EmissionColor;
			float4 _EmissionMap_ST;
			float4 _TransmissionColor;
			float4 _BaseColor;
			float4 _BaseMap_ST;
			float4 _SpecColor;
			float4 _TranslucencyColor;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float _AlphaClip;
			half _Cutoff;
			float _CATEGORY_ALPHA;
			half _TransmissionStrength;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_ALPHA;
			float _EnableEmission;
			half _AlphaCutoffShadow;
			float _TransmissionFeather;
			float _TransmissionMapInverted;
			half _EmissionFlags;
			half _EmissiveIntensity;
			float _CATEGORYSPACE_EMISSION;
			float _CATEGORYSPACE_TRANSMISSION;
			float _CATEGORY_TRANSMISSION;
			float _CATEGORY_COATMASK;
			half _ClearCoat;
			float _ClearCoatMask;
			half _ClearCoatUVMapping;
			float _CATEGORYSPACE_TRANSLUCENCY;
			float _CATEGORY_TRANSLUCENCY;
			half _TransmissionMapEnable;
			half _TranslucencyMapEnable;
			float _TranslucencyMapInverted;
			float _TranslucencyFeather;
			float _TranslucencyAmbient;
			float _TranslucencyDirect;
			float _TranslucencyScattering;
			float _TranslucencyNormalDistortion;
			float _TranslucencyStrength;
			float _ASETranslucencyShadow;
			float _UVEmissive;
			float _OcclusionStrength;
			float _ASETranslucencyAmbient;
			float _ASETranslucencyDirect;
			float _ASETranslucencyScattering;
			float _ASETranslucencyNormalDistortion;
			float _ASETranslucencyStrength;
			float _ASETransmissionShadow;
			float _CATEGORY_SURFACESETTINGS;
			int _Cull;
			float _SPACE_SURFACESETTINGS;
			float _SPACE_TRANSLUCENCYASE;
			float _CATEGORY_TRANSLUCENCYASE;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORY_SPECULAR;
			float _Smoothnesstexturechannel;
			float _EnableClipGlancingAngle;
			float _CATEGORYSPACE_COATMASK;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORY_DETAIL;
			float _DETAIL_MULX2;
			float _DetailAlbedoMapScale;
			float _UVDetail;
			float _DetailNormalMapScale;
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
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_DetailMask);
			SAMPLER(sampler_DetailMask);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);


			float2 float2switchUVMode566_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
				output.ase_texcoord3.zw = input.ase_texcoord1.xy;
				output.ase_texcoord4.xy = input.ase_texcoord2.xy;
				output.ase_texcoord4.zw = input.ase_texcoord3.xy;
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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
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
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_texcoord2 = input.ase_texcoord2;
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
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

				float m_switch566_g61668 = _UVBase;
				float2 m_UV0566_g61668 = input.ase_texcoord3.xy;
				float2 m_UV1566_g61668 = input.ase_texcoord3.zw;
				float2 m_UV2566_g61668 = input.ase_texcoord4.xy;
				float2 m_UV3566_g61668 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode566_g61668 = float2switchUVMode566_g61668( m_switch566_g61668 , m_UV0566_g61668 , m_UV1566_g61668 , m_UV2566_g61668 , m_UV3566_g61668 );
				float2 appendResult772_g61668 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g61668 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g61668 = ( ( localfloat2switchUVMode566_g61668 * appendResult772_g61668 ) + appendResult773_g61668 );
				float3 unpack268_g61668 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV_BaseMap2637_g61668 ), _BumpScale );
				unpack268_g61668.z = lerp( 1, unpack268_g61668.z, saturate(_BumpScale) );
				float m_switch571_g61668 = _UVDetail;
				float2 m_UV0571_g61668 = input.ase_texcoord3.xy;
				float2 m_UV1571_g61668 = input.ase_texcoord3.zw;
				float2 m_UV2571_g61668 = input.ase_texcoord4.xy;
				float2 m_UV3571_g61668 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode571_g61668 = float2switchUVMode571_g61668( m_switch571_g61668 , m_UV0571_g61668 , m_UV1571_g61668 , m_UV2571_g61668 , m_UV3571_g61668 );
				float2 appendResult574_g61668 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g61668 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g61668 = ( ( localfloat2switchUVMode571_g61668 * appendResult574_g61668 ) + appendResult578_g61668 );
				float3 unpack311_g61668 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_DetailNormalMap, UV_DetailMap583_g61668 ), _DetailNormalMapScale );
				unpack311_g61668.z = lerp( 1, unpack311_g61668.z, saturate(_DetailNormalMapScale) );
				float2 weightedBlendVar3825_g61668 = float2( 0.5,0.5 );
				float3 weightedBlend3825_g61668 = ( weightedBlendVar3825_g61668.x*unpack268_g61668 + weightedBlendVar3825_g61668.y*unpack311_g61668 );
				float DetailMask_A2207_g61668 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g61668 ).a;
				float3 lerpResult2330_g61668 = lerp( unpack268_g61668 , weightedBlend3825_g61668 , DetailMask_A2207_g61668);
				float ENABLE_DETAIL3658_g61668 = _DETAIL_MULX2;
				float3 lerpResult3665_g61668 = lerp( unpack268_g61668 , lerpResult2330_g61668 , ENABLE_DETAIL3658_g61668);
				float m_switch3120_g61668 = _DoubleSidedNormalMode;
				float3 m_Flip3120_g61668 = float3( -1, -1, -1 );
				float3 m_Mirror3120_g61668 = float3( 1, 1, -1 );
				float3 m_None3120_g61668 = float3( 1, 1, 1 );
				float3 local_NormalModefloat3switch3120_g61668 = _NormalModefloat3switch( m_switch3120_g61668 , m_Flip3120_g61668 , m_Mirror3120_g61668 , m_None3120_g61668 );
				float3 switchResult3114_g61668 = (((ase_vface>0)?(lerpResult3665_g61668):(( lerpResult3665_g61668 * local_NormalModefloat3switch3120_g61668 ))));
				
				float4 temp_output_2_0_g61673 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				float3 temp_output_102_0_g61671 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g61671 = normalize( temp_output_102_0_g61671 );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - PositionWS );
				float3 ase_viewDirSafeWS = SafeNormalize( ase_viewVectorWS );
				float dotResult3155_g61668 = dot( normalizeResult79_g61671 , ase_viewDirSafeWS );
				float temp_output_3157_0_g61668 = ( 1.0 - abs( dotResult3155_g61668 ) );
				#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch3161_g61668 = 1.0;
				#else
				float staticSwitch3161_g61668 = ( 1.0 - ( temp_output_3157_0_g61668 * temp_output_3157_0_g61668 ) );
				#endif
				float lerpResult3164_g61668 = lerp( 1.0 , staticSwitch3161_g61668 , _EnableClipGlancingAngle);
				float temp_output_3172_0_g61668 = ( (temp_output_2_0_g61673).a * lerpResult3164_g61668 );
				float lerpResult3842_g61668 = lerp( 1.0 , temp_output_3172_0_g61668 , _AlphaClip);
				

				float3 Normal = switchResult3114_g61668;
				float Alpha = lerpResult3842_g61668;
				float AlphaClipThreshold = ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) );

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
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			

			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _ALPHATEST_SHADOW_ON 1
			#define ASE_TRANSMISSION 1
			#define ASE_TRANSLUCENCY 1
			#define _EMISSION
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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _EmissionColor;
			float4 _EmissionMap_ST;
			float4 _TransmissionColor;
			float4 _BaseColor;
			float4 _BaseMap_ST;
			float4 _SpecColor;
			float4 _TranslucencyColor;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float _AlphaClip;
			half _Cutoff;
			float _CATEGORY_ALPHA;
			half _TransmissionStrength;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_ALPHA;
			float _EnableEmission;
			half _AlphaCutoffShadow;
			float _TransmissionFeather;
			float _TransmissionMapInverted;
			half _EmissionFlags;
			half _EmissiveIntensity;
			float _CATEGORYSPACE_EMISSION;
			float _CATEGORYSPACE_TRANSMISSION;
			float _CATEGORY_TRANSMISSION;
			float _CATEGORY_COATMASK;
			half _ClearCoat;
			float _ClearCoatMask;
			half _ClearCoatUVMapping;
			float _CATEGORYSPACE_TRANSLUCENCY;
			float _CATEGORY_TRANSLUCENCY;
			half _TransmissionMapEnable;
			half _TranslucencyMapEnable;
			float _TranslucencyMapInverted;
			float _TranslucencyFeather;
			float _TranslucencyAmbient;
			float _TranslucencyDirect;
			float _TranslucencyScattering;
			float _TranslucencyNormalDistortion;
			float _TranslucencyStrength;
			float _ASETranslucencyShadow;
			float _UVEmissive;
			float _OcclusionStrength;
			float _ASETranslucencyAmbient;
			float _ASETranslucencyDirect;
			float _ASETranslucencyScattering;
			float _ASETranslucencyNormalDistortion;
			float _ASETranslucencyStrength;
			float _ASETransmissionShadow;
			float _CATEGORY_SURFACESETTINGS;
			int _Cull;
			float _SPACE_SURFACESETTINGS;
			float _SPACE_TRANSLUCENCYASE;
			float _CATEGORY_TRANSLUCENCYASE;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORY_SPECULAR;
			float _Smoothnesstexturechannel;
			float _EnableClipGlancingAngle;
			float _CATEGORYSPACE_COATMASK;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORY_DETAIL;
			float _DETAIL_MULX2;
			float _DetailAlbedoMapScale;
			float _UVDetail;
			float _DetailNormalMapScale;
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

			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);


			float2 float2switchUVMode566_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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

				output.ase_texcoord1.xy = input.ase_texcoord.xy;
				output.ase_texcoord1.zw = input.ase_texcoord1.xy;
				output.ase_texcoord2.xy = input.ase_texcoord2.xy;
				output.ase_texcoord2.zw = input.ase_texcoord3.xy;

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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
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
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_texcoord2 = input.ase_texcoord2;
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
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

				float m_switch566_g61668 = _UVBase;
				float2 m_UV0566_g61668 = input.ase_texcoord1.xy;
				float2 m_UV1566_g61668 = input.ase_texcoord1.zw;
				float2 m_UV2566_g61668 = input.ase_texcoord2.xy;
				float2 m_UV3566_g61668 = input.ase_texcoord2.zw;
				float2 localfloat2switchUVMode566_g61668 = float2switchUVMode566_g61668( m_switch566_g61668 , m_UV0566_g61668 , m_UV1566_g61668 , m_UV2566_g61668 , m_UV3566_g61668 );
				float2 appendResult772_g61668 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g61668 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g61668 = ( ( localfloat2switchUVMode566_g61668 * appendResult772_g61668 ) + appendResult773_g61668 );
				float4 temp_output_2_0_g61673 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				float3 temp_output_102_0_g61671 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g61671 = normalize( temp_output_102_0_g61671 );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - PositionWS );
				float3 ase_viewDirSafeWS = SafeNormalize( ase_viewVectorWS );
				float dotResult3155_g61668 = dot( normalizeResult79_g61671 , ase_viewDirSafeWS );
				float temp_output_3157_0_g61668 = ( 1.0 - abs( dotResult3155_g61668 ) );
				#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch3161_g61668 = 1.0;
				#else
				float staticSwitch3161_g61668 = ( 1.0 - ( temp_output_3157_0_g61668 * temp_output_3157_0_g61668 ) );
				#endif
				float lerpResult3164_g61668 = lerp( 1.0 , staticSwitch3161_g61668 , _EnableClipGlancingAngle);
				float temp_output_3172_0_g61668 = ( (temp_output_2_0_g61673).a * lerpResult3164_g61668 );
				float lerpResult3842_g61668 = lerp( 1.0 , temp_output_3172_0_g61668 , _AlphaClip);
				

				surfaceDescription.Alpha = lerpResult3842_g61668;
				surfaceDescription.AlphaClipThreshold = ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) );

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

			

			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define _ALPHATEST_SHADOW_ON 1
			#define ASE_TRANSMISSION 1
			#define ASE_TRANSLUCENCY 1
			#define _EMISSION
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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _EmissionColor;
			float4 _EmissionMap_ST;
			float4 _TransmissionColor;
			float4 _BaseColor;
			float4 _BaseMap_ST;
			float4 _SpecColor;
			float4 _TranslucencyColor;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float _AlphaClip;
			half _Cutoff;
			float _CATEGORY_ALPHA;
			half _TransmissionStrength;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_ALPHA;
			float _EnableEmission;
			half _AlphaCutoffShadow;
			float _TransmissionFeather;
			float _TransmissionMapInverted;
			half _EmissionFlags;
			half _EmissiveIntensity;
			float _CATEGORYSPACE_EMISSION;
			float _CATEGORYSPACE_TRANSMISSION;
			float _CATEGORY_TRANSMISSION;
			float _CATEGORY_COATMASK;
			half _ClearCoat;
			float _ClearCoatMask;
			half _ClearCoatUVMapping;
			float _CATEGORYSPACE_TRANSLUCENCY;
			float _CATEGORY_TRANSLUCENCY;
			half _TransmissionMapEnable;
			half _TranslucencyMapEnable;
			float _TranslucencyMapInverted;
			float _TranslucencyFeather;
			float _TranslucencyAmbient;
			float _TranslucencyDirect;
			float _TranslucencyScattering;
			float _TranslucencyNormalDistortion;
			float _TranslucencyStrength;
			float _ASETranslucencyShadow;
			float _UVEmissive;
			float _OcclusionStrength;
			float _ASETranslucencyAmbient;
			float _ASETranslucencyDirect;
			float _ASETranslucencyScattering;
			float _ASETranslucencyNormalDistortion;
			float _ASETranslucencyStrength;
			float _ASETransmissionShadow;
			float _CATEGORY_SURFACESETTINGS;
			int _Cull;
			float _SPACE_SURFACESETTINGS;
			float _SPACE_TRANSLUCENCYASE;
			float _CATEGORY_TRANSLUCENCYASE;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORY_SPECULAR;
			float _Smoothnesstexturechannel;
			float _EnableClipGlancingAngle;
			float _CATEGORYSPACE_COATMASK;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORY_DETAIL;
			float _DETAIL_MULX2;
			float _DetailAlbedoMapScale;
			float _UVDetail;
			float _DetailNormalMapScale;
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

			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);


			float2 float2switchUVMode566_g61668( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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

				output.ase_texcoord1.xy = input.ase_texcoord.xy;
				output.ase_texcoord1.zw = input.ase_texcoord1.xy;
				output.ase_texcoord2.xy = input.ase_texcoord2.xy;
				output.ase_texcoord2.zw = input.ase_texcoord3.xy;

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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
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
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_texcoord2 = input.ase_texcoord2;
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
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

				float m_switch566_g61668 = _UVBase;
				float2 m_UV0566_g61668 = input.ase_texcoord1.xy;
				float2 m_UV1566_g61668 = input.ase_texcoord1.zw;
				float2 m_UV2566_g61668 = input.ase_texcoord2.xy;
				float2 m_UV3566_g61668 = input.ase_texcoord2.zw;
				float2 localfloat2switchUVMode566_g61668 = float2switchUVMode566_g61668( m_switch566_g61668 , m_UV0566_g61668 , m_UV1566_g61668 , m_UV2566_g61668 , m_UV3566_g61668 );
				float2 appendResult772_g61668 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g61668 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g61668 = ( ( localfloat2switchUVMode566_g61668 * appendResult772_g61668 ) + appendResult773_g61668 );
				float4 temp_output_2_0_g61673 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g61668 );
				float3 temp_output_102_0_g61671 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g61671 = normalize( temp_output_102_0_g61671 );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - PositionWS );
				float3 ase_viewDirSafeWS = SafeNormalize( ase_viewVectorWS );
				float dotResult3155_g61668 = dot( normalizeResult79_g61671 , ase_viewDirSafeWS );
				float temp_output_3157_0_g61668 = ( 1.0 - abs( dotResult3155_g61668 ) );
				#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch3161_g61668 = 1.0;
				#else
				float staticSwitch3161_g61668 = ( 1.0 - ( temp_output_3157_0_g61668 * temp_output_3157_0_g61668 ) );
				#endif
				float lerpResult3164_g61668 = lerp( 1.0 , staticSwitch3161_g61668 , _EnableClipGlancingAngle);
				float temp_output_3172_0_g61668 = ( (temp_output_2_0_g61673).a * lerpResult3164_g61668 );
				float lerpResult3842_g61668 = lerp( 1.0 , temp_output_3172_0_g61668 , _AlphaClip);
				

				surfaceDescription.Alpha = lerpResult3842_g61668;
				surfaceDescription.AlphaClipThreshold = ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) );

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
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;326;-480.6667,-640;Inherit;False;351.6589;637.7009;TRANSLUCENCY ASE;8;334;333;332;331;330;329;328;144;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;344;0,-288;Inherit;False;464.2075;380.1782;SURFACE SETTINGS;4;343;342;103;116;;0,0,0,1;0;0
Node;AmplifyShaderEditor.StickyNoteNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;327;-832,-640;Inherit;False;322.8861;380.886;;;0,0,0,1;_ASETransmissionShadow$$_ASETranslucencyStrength$_ASETranslucencyNormalDistortion$_ASETranslucencyScattering$_ASETranslucencyDirect$_ASETranslucencyAmbient$_ASETranslucencyShadow;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;328;-432,-112;Inherit;False;Property;_ASETranslucencyShadow;ASE Translucency Shadow ;90;0;Create;False;1;;0;0;True;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;329;-432,-192;Inherit;False;Property;_ASETranslucencyAmbient;ASE Translucency Ambient;89;0;Create;False;1;;0;0;True;0;False;0.8339342;0.8339342;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;330;-432,-272;Inherit;False;Property;_ASETranslucencyDirect;ASE Translucency Direct ;88;0;Create;False;1;;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;331;-432,-352;Inherit;False;Property;_ASETranslucencyScattering;ASE Translucency Scattering ;87;0;Create;False;1;;0;0;True;0;False;2;2;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;332;-432,-432;Inherit;False;Property;_ASETranslucencyNormalDistortion;ASE Translucency Normal Distortion ;86;0;Create;False;1;;0;0;True;0;False;0.2735869;0.209;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;333;-432,-512;Inherit;False;Property;_ASETranslucencyStrength;ASE Translucency Strength;85;0;Create;False;1;;0;0;True;0;False;1;2.4;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;334;-432,-592;Inherit;False;Property;_ASETransmissionShadow;ASE Transmission Shadow;84;0;Create;False;1;;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;0.5;0.471;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;32,-240;Inherit;False;Property;_CATEGORY_SURFACESETTINGS;CATEGORY_SURFACE SETTINGS;0;0;Create;True;0;0;0;True;1;LS_DrawerCategory(SURFACE SETTINGS,true,_Cull,0,0);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;103;32,-160;Inherit;False;Property;_Cull;Render Face;1;1;[Enum];Create;False;1;;0;1;Front,2,Back,1,Both,0;True;0;False;2;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;342;32,0;Inherit;False;Property;_SPACE_SURFACESETTINGS;SPACE_SURFACE SETTINGS;2;0;Create;True;0;0;0;True;1;LS_DrawerCategorySpace(10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;116;32,-80;Inherit;False;Constant;_MaskClipValue2;Mask Clip Value;19;0;Create;True;1;;0;0;True;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;336;-816,-368;Inherit;False;Property;_SPACE_TRANSLUCENCYASE;SPACE_TRANSLUCENCYASE;91;0;Create;True;0;0;0;True;1;LS_DrawerCategorySpace(10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;335;-816,-448;Inherit;False;Property;_CATEGORY_TRANSLUCENCYASE;CATEGORY_TRANSLUCENCY ASE;83;0;Create;True;0;0;0;True;1;LS_DrawerCategory(TRANSLUCENCY ASE,true,_ASETranslucencyStrength,0,0);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;345;-320,464;Inherit;False;LS URP Clear Coat;74;;61667;8a05b92f6be02ee4992379fade361e90;0;0;2;FLOAT;3744;FLOAT;3743
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;341;-384,128;Inherit;False;LS Core Lit URP;3;;61668;53876622fa774744d8149dc81e17dda6;6,3095,1,3046,1,3050,1,3109,1,3116,1,3772,1;0;12;FLOAT3;3010;FLOAT3;3011;FLOAT3;3009;FLOAT3;3012;FLOAT3;3092;FLOAT;3015;FLOAT;3014;FLOAT;3013;FLOAT;3016;FLOAT;3032;FLOAT3;3856;FLOAT3;3857
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;144;-144,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;145;0,128;Float;False;True;-1;2;LS_ShaderGUI;0;12;LS/Lit;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_Cull;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=TransparentCutout=RenderType;Queue=AlphaTest=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForwardOnly;False;False;0;;0;0;Standard;45;Lighting Model;0;0;Workflow;0;638650937837167445;Surface;0;638691912861869887;  Refraction Model;0;0;  Blend;0;0;Two Sided;1;0;Alpha Clipping;1;0;  Use Shadow Threshold;1;638703485322137222;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;1;0;Transmission;1;638709956488386978;  Transmission Shadow;0.5,True,_ASETransmissionShadow;638709971722742780;Translucency;1;638709956509288648;  Translucency Strength;1,True,_ASETranslucencyStrength;638709971765784237;  Normal Distortion;0.5,True,_ASETranslucencyNormalDistortion;638709971808374177;  Scattering;2,True,_ASETranslucencyScattering;638709971864493599;  Direct;0.9,True,_ASETranslucencyDirect;638709971895433110;  Ambient;0.1,True,_ASETranslucencyAmbient;638709971929436255;  Shadow;0.5,True,_ASETranslucencyShadow;638709971967448480;Cast Shadows;1;0;Receive Shadows;1;0;Receive SSAO;1;0;Specular Highlights;1;0;Environment Reflections;1;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,True,_TessellationPhong;0;  Type;0;0;  Tess;16,True,_TessellationStrength;0;  Min;10,True,_TessellationDistanceMin;0;  Max;25,True,_TessellationDistanceMax;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;0;0;Clear Coat;1;638709964944237641;0;10;False;True;True;True;True;True;True;False;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;146;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;147;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;True;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;148;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;149;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;150;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;151;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;152;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;153;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;145;0;341;3010
WireConnection;145;1;341;3011
WireConnection;145;9;341;3012
WireConnection;145;4;341;3015
WireConnection;145;5;341;3014
WireConnection;145;2;341;3009
WireConnection;145;6;341;3013
WireConnection;145;7;341;3016
WireConnection;145;16;341;3032
WireConnection;145;14;341;3856
WireConnection;145;15;341;3857
WireConnection;145;18;345;3744
WireConnection;145;20;345;3743
ASEEND*/
//CHKSM=EC682331D8F420F6F00FB3ACFEC98224D18444BB