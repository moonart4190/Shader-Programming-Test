// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LS/Weather/Rain"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[LS_DrawerCategory(SURFACE SETTINGS,true,_Cull,0,0)] _CATEGORY_SURFACESETTINGS( "CATEGORY_SURFACE SETTINGS", Float ) = 1
		[Enum(Front,2,Back,1,Both,0)] _Cull( "Render Face", Int ) = 2
		[LS_DrawerCategorySpace(10)] _SPACE_SURFACESETTINGS( "SPACE_SURFACE SETTINGS", Float ) = 0
		[LS_DrawerCategory(COLOR,true,_BaseColor,0,0)] _CATEGORY_COLOR( "CATEGORY_COLOR", Float ) = 1
		_BaseColor( "Base Color", Color ) = ( 1, 1, 1, 1 )
		_Brightness( "Brightness", Range( 0, 2 ) ) = 1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_COLOR( "CATEGORYSPACE_COLOR", Float ) = 0
		[LS_DrawerCategory(SURFACE INPUTS,true,_BaseMap,0,0)] _CATEGORY_SURFACEINPUTS( "CATEGORY_SURFACE INPUTS", Float ) = 1
		[LS_DrawerTextureSingleLine] _BaseMap( "Base Map", 2D ) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _UVBase( "UV Set", Float ) = 0
		[LS_DrawerTextureScaleOffset] _BaseMap_ST( "Main UVs", Vector ) = ( 1, 1, 0, 0 )
		[Header(METALLIC)][LS_DrawerTextureSingleLine] _MetallicGlossMap( "Metallic Map", 2D ) = "white" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		[Enum(MetallicAlpha,0,AlbedoAlpha,1)][Space(10)] _SmoothnesstexturechannelM( "Smoothness texture channel", Float ) = 1
		_Glossiness( "Smoothness", Range( 0, 1 ) ) = 0.5
		_GlossMapScale( "Smoothness", Range( 0, 1 ) ) = 1
		[LS_DrawerTextureSingleLine][Space(10)] _OcclusionMap( "Occlusion Map", 2D ) = "white" {}
		_OcclusionStrength( "Occlusion Strength", Range( 0, 1 ) ) = 0
		[Normal][LS_DrawerTextureSingleLine][Space(10)] _BumpMap( "Normal Map", 2D ) = "bump" {}
		_BumpScale( "Normal Scale", Float ) = 1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_SURFACEINPUTS( "CATEGORYSPACE_SURFACE INPUTS", Float ) = 0
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
		[Header(RAIN PUDDLE)][LS_DrawerToggleLeft] _ENABLEPUDDLE( "ENABLE PUDDLE", Float ) = 1
		_PuddleIntensity( "Puddle Intensity", Range( 0, 1 ) ) = 1
		_PuddleSize( "Puddle Size", Float ) = 1
		_PuddleHeight( "Puddle Height", Range( 0, 1 ) ) = 0.5
		_PuddleSmoothness( "Puddle Smoothness", Range( 0, 1 ) ) = 0.55
		_PuddleAmbientOcclusion( "Puddle Ambient Occlusion", Range( 0, 1 ) ) = 1
		[LS_DrawerTextureSingleLine] _RainPuddleMask( "Puddle Mask", 2D ) = "white" {}
		[LS_DrawerTextureScaleOffset] _RainPuddleMask_ST( "Tilling Offset", Vector ) = ( 0.05, 0.05, 0, 0 )
		[Normal][LS_DrawerTextureSingleLine] _RainPuddleNormal( "Puddle Normal", 2D ) = "bump" {}
		[LS_DrawerTextureScaleOffset] _RainPuddleNormal_ST( "Tilling Offset", Vector ) = ( 1, 1, 0, 0 )
		_PuddleNormalStrength( "Puddle Normal Strength", Range( 0, 1 ) ) = 0.45
		_PuddleNormalStrengthBase( "Puddle Normal Strength Base", Float ) = -1
		_PuddleNormalSpeed( "Puddle Normal Speed", Float ) = 1
		[LS_DrawerTextureSingleLine] _RainPuddleRipple( "Puddle Ripple", 2D ) = "white" {}
		[LS_DrawerTextureScaleOffset] _RainPuddleRipple_ST( "Tilling Offset", Vector ) = ( 5, 5, 0, 0 )
		_PuddleRippleStrength( "Puddle Ripple Strength", Float ) = 1
		_PuddleRippleSpeed( "Puddle Ripple Speed", Float ) = 1
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

		

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "UniversalMaterialType"="Lit" }

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

			

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
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
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT


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
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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
			TEXTURE2D(_MetallicGlossMap);
			TEXTURE2D(_RainPuddleMask);
			SAMPLER(sampler_RainPuddleMask);
			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_RainPuddleNormal);
			SAMPLER(sampler_RainPuddleNormal);
			TEXTURE2D(_RainPuddleRipple);
			SAMPLER(sampler_RainPuddleRipple);
			TEXTURE2D(_OcclusionMap);
			TEXTURE2D(_EmissionMap);
			SAMPLER(sampler_EmissionMap);
			TEXTURE2D(_ClearCoatMap);
			SAMPLER(sampler_ClearCoatMap);


			float2 float2switchUVMode566_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float2 DirectionalEquation( float _WindDirection )
			{
				float d = _WindDirection * 0.0174532924;
				float xL = cos(d) + 1 / 2;
				float zL = sin(d) + 1 / 2;
				return float2(zL,xL);
			}
			
			float2 float2switchUVMode592_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode3404_g61674( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
						 ) : SV_Target
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

				float m_switch566_g60389 = _UVBase;
				float2 m_UV0566_g60389 = input.ase_texcoord6.xy;
				float2 m_UV1566_g60389 = input.ase_texcoord6.zw;
				float2 m_UV2566_g60389 = input.ase_texcoord7.xy;
				float2 m_UV3566_g60389 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode566_g60389 = float2switchUVMode566_g60389( m_switch566_g60389 , m_UV0566_g60389 , m_UV1566_g60389 , m_UV2566_g60389 , m_UV3566_g60389 );
				float2 appendResult772_g60389 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g60389 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g60389 = ( ( localfloat2switchUVMode566_g60389 * appendResult772_g60389 ) + appendResult773_g60389 );
				float4 temp_output_2_0_g61666 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_2444_0_g60389 = ( (temp_output_2_0_g61666).rgb * (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_COLOR + _CATEGORYSPACE_COLOR + _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) );
				float m_switch571_g60389 = _UVDetail;
				float2 m_UV0571_g60389 = input.ase_texcoord6.xy;
				float2 m_UV1571_g60389 = input.ase_texcoord6.zw;
				float2 m_UV2571_g60389 = input.ase_texcoord7.xy;
				float2 m_UV3571_g60389 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode571_g60389 = float2switchUVMode571_g60389( m_switch571_g60389 , m_UV0571_g60389 , m_UV1571_g60389 , m_UV2571_g60389 , m_UV3571_g60389 );
				float2 appendResult574_g60389 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g60389 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g60389 = ( ( localfloat2switchUVMode571_g60389 * appendResult574_g60389 ) + appendResult578_g60389 );
				float3 DetailMap2602_g60389 = (SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_BaseMap, UV_DetailMap583_g60389 )).rgb;
				float3 lerpResult3088_g60389 = lerp( DetailMap2602_g60389 , ( DetailMap2602_g60389 * (unity_ColorSpaceDouble).rgb ) , _DetailAlbedoMapScale);
				float DetailMask_A2207_g60389 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g60389 ).a;
				float temp_output_2_0_g60393 = DetailMask_A2207_g60389;
				float temp_output_3_0_g60393 = ( 1.0 - temp_output_2_0_g60393 );
				float3 appendResult7_g60393 = (float3(temp_output_3_0_g60393 , temp_output_3_0_g60393 , temp_output_3_0_g60393));
				float3 lerpResult3662_g60389 = lerp( temp_output_2444_0_g60389 , ( temp_output_2444_0_g60389 * ( ( lerpResult3088_g60389 * temp_output_2_0_g60393 ) + appendResult7_g60393 ) ) , ( _DETAIL_MULX2 + ( ( _CATEGORY_DETAIL + _CATEGORYSPACE_DETAIL ) * 0.0 ) ));
				float3 temp_output_2628_0_g61671 = ( saturate( lerpResult3662_g60389 ) * 0.2 );
				float4 temp_output_2_0_g60390 = SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_343_3092 = ( (temp_output_2_0_g60390).rgb * _Metallic );
				float temp_output_386_0_g61671 = ( 1.0 - saturate( max( temp_output_343_3092.x , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float temp_output_2631_0_g61671 = saturate( max( temp_output_386_0_g61671 , min( _GlobalRainWetness , 0.94 ) ) );
				float3 lerpResult4144_g61671 = lerp( lerpResult3662_g60389 , temp_output_2628_0_g61671 , ( ( _GlobalRainWetness * 0.85 ) * temp_output_2631_0_g61671 ));
				float2 appendResult1393_g61671 = (float2(PositionWS.x , PositionWS.z));
				float4 tex2DNode30_g61671 = SAMPLE_TEXTURE2D( _RainPuddleMask, sampler_RainPuddleMask, ( ( appendResult1393_g61671 * (_RainPuddleMask_ST).xy ) + (_RainPuddleMask_ST).zw ) );
				float4 _Vector0 = float4(1E-05,0,0.4,0.2);
				float2 appendResult7_g61671 = (float2(_Vector0.x , _Vector0.y));
				float2 appendResult8_g61671 = (float2(_Vector0.z , _Vector0.w));
				float2 lerpResult9_g61671 = lerp( appendResult7_g61671 , appendResult8_g61671 , _PuddleSize);
				float2 break14_g61671 = lerpResult9_g61671;
				float saferPower17_g61671 = abs( saturate( ( ( ( saturate( ( _PuddleHeight * 10.0 ) ) * saturate(  (0.0 + ( tex2DNode30_g61671.r - 0.0 ) * ( ( ( saturate( ( _PuddleHeight + -0.1 ) ) * 50.0 ) + 1.0 ) - 0.0 ) / ( 1.0 - 0.0 ) ) ) ) * ( ( 1.0 - saturate( ( ( tex2DNode30_g61671.r - break14_g61671.y ) / break14_g61671.x ) ) ) * _PuddleSize ) ) * 5.0 ) ) );
				float Puddle1461_g61671 = pow( saferPower17_g61671 , 6.0 );
				float saferPower462_g61671 = abs( saturate( NormalWS.y ) );
				float Mask_Puddle1482_g61671 = pow( saferPower462_g61671 , 80.0 );
				float lerpResult4134_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float Puddle_Intensity3276_g61671 = _PuddleIntensity;
				float3 lerpResult305_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , ( ( 1.0 - ( temp_output_2631_0_g61671 * lerpResult4134_g61671 ) ) * ( Puddle_Intensity3276_g61671 + 0.25 ) ));
				float ENABLE_RAIN363_g61671 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61671 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61671 );
				float3 lerpResult3545_g61671 = lerp( lerpResult3662_g60389 , lerpResult305_g61671 , Global_Rain_Intensity1484_g61671);
				float3 lerpResult3559_g61671 = lerp( temp_output_2628_0_g61671 , lerpResult3545_g61671 , _PuddleIntensity);
				float ENABLE_PUDDLE1379_g61671 = _ENABLEPUDDLE;
				float3 lerpResult3586_g61671 = lerp( temp_output_2628_0_g61671 , lerpResult3559_g61671 , ENABLE_PUDDLE1379_g61671);
				float Wind_Direction2547_g61671 = _GlobalRainWindDirection;
				float temp_output_4713_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 temp_output_183_0_g61671 = (PositionWS).yx;
				float2 lerpResult4672_g61671 = lerp( temp_output_183_0_g61671 , ( 1.0 - temp_output_183_0_g61671 ) , _RainDripMaskInvert);
				float2 break4707_g61671 = ( lerpResult4672_g61671 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4717_g61671 = (float2(( ( temp_output_4713_0_g61671 * break4707_g61671.x ) + ( temp_output_4712_0_g61671 * break4707_g61671.y ) ) , ( ( temp_output_4713_0_g61671 * break4707_g61671.y ) - ( temp_output_4712_0_g61671 * break4707_g61671.x ) )));
				float Permeability387_g61671 = temp_output_386_0_g61671;
				float lerpResult193_g61671 = lerp( 0.2 , 0.03 , Permeability387_g61671);
				float lerpResult194_g61671 = lerp( 0.0 , 0.0125 , Permeability387_g61671);
				float temp_output_4405_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61671 = ( input.ase_texcoord6.xy - _Anchor );
				float temp_output_4406_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4415_g61671 = (float2(( ( temp_output_4405_0_g61671 * break4413_g61671.x ) + ( temp_output_4406_0_g61671 * break4413_g61671.y ) ) , ( ( temp_output_4405_0_g61671 * break4413_g61671.y ) - ( temp_output_4406_0_g61671 * break4413_g61671.x ) )));
				float4 tex2DNode172_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float lerpResult185_g61671 = lerp( lerpResult193_g61671 , lerpResult194_g61671 , tex2DNode172_g61671.a);
				float Time1591_g61671 = _TimeParameters.x;
				float temp_output_186_0_g61671 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61671 + ( lerpResult185_g61671 * ( ( Time1591_g61671 * _RainDripSpeed ) + tex2DNode172_g61671.a ) ) ) ).r * tex2DNode172_g61671.b );
				float3 temp_cast_1 = (0.5).xxx;
				float3 break3837_g61671 = ( abs( NormalWS ) - temp_cast_1 );
				float smoothstepResult3838_g61671 = smoothstep( 0.1 , 1.0 , ( break3837_g61671.z + 0.5 ));
				float Mask_Vertical_Z3918_g61671 = ( smoothstepResult3838_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3929_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_Z3918_g61671);
				float smoothstepResult3864_g61671 = smoothstep( 0.0 , 1.0 , ( break3837_g61671.x + 0.45 ));
				float Mask_Vertical_X3920_g61671 = ( smoothstepResult3864_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3930_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_X3920_g61671);
				float smoothstepResult3839_g61671 = smoothstep( 0.0 , 1.0 , ( -break3837_g61671.y + 0.45 ));
				float Mask_Vertical_Y3919_g61671 = ( smoothstepResult3839_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3931_g61671 = lerp( lerpResult3929_g61671 , ( lerpResult3929_g61671 + lerpResult3930_g61671 ) , Mask_Vertical_Y3919_g61671);
				float temp_output_1689_0_g61671 = ( lerpResult3931_g61671 * _RainDripIntensity );
				float lerpResult1663_g61671 = lerp( 0.0 , temp_output_1689_0_g61671 , _ENABLEDRIPS);
				float Drips3491_g61671 = saturate( lerpResult1663_g61671 );
				float3 lerpResult3462_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , saturate( ( temp_output_2631_0_g61671 * Drips3491_g61671 ) ));
				float3 lerpResult3546_g61671 = lerp( lerpResult3662_g60389 , lerpResult3462_g61671 , Global_Rain_Intensity1484_g61671);
				float2 temp_output_1355_0_g61671 = ( ( input.ase_texcoord6.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61671, ddx( temp_output_1355_0_g61671 ), ddy( temp_output_1355_0_g61671 ) );
				float temp_output_3696_0_g61671 = ( ( tex2DNode257_g61671.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61671 = ( frac( ( tex2DNode257_g61671.b - ( Time1591_g61671 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61671 ) );
				float lerpResult4471_g61671 = lerp( ( temp_output_1818_0_g61671 + saturate( -temp_output_3696_0_g61671 ) ) , temp_output_1818_0_g61671 , _RainDropStaticScale);
				float temp_output_3691_0_g61671 = ( lerpResult4471_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult1664_g61671 = lerp( 0.0 , (temp_output_3691_0_g61671*2.0 + -1.0) , _ENABLEDROPS);
				float Drops3492_g61671 = saturate( lerpResult1664_g61671 );
				float temp_output_3457_0_g61671 = saturate( ( temp_output_2631_0_g61671 * Drops3492_g61671 ) );
				float lerpResult4141_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float lerpResult4102_g61671 = lerp( temp_output_3457_0_g61671 , saturate( temp_output_2631_0_g61671 ) , lerpResult4141_g61671);
				float lerpResult4126_g61671 = lerp( temp_output_3457_0_g61671 , lerpResult4102_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult4100_g61671 = lerp( temp_output_3457_0_g61671 , lerpResult4126_g61671 , ENABLE_PUDDLE1379_g61671);
				float3 lerpResult3399_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , lerpResult4100_g61671);
				float3 lerpResult3547_g61671 = lerp( lerpResult3662_g60389 , lerpResult3399_g61671 , Global_Rain_Intensity1484_g61671);
				float3 weightedBlendVar3481_g61671 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend3481_g61671 = ( weightedBlendVar3481_g61671.x*lerpResult3586_g61671 + weightedBlendVar3481_g61671.y*lerpResult3546_g61671 + weightedBlendVar3481_g61671.z*lerpResult3547_g61671 );
				float3 lerpResult799_g61671 = lerp( lerpResult3662_g60389 , weightedBlend3481_g61671 , ENABLE_RAIN363_g61671);
				
				float3 unpack268_g60389 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV_BaseMap2637_g60389 ), _BumpScale );
				unpack268_g60389.z = lerp( 1, unpack268_g60389.z, saturate(_BumpScale) );
				float3 unpack311_g60389 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_DetailNormalMap, UV_DetailMap583_g60389 ), _DetailNormalMapScale );
				unpack311_g60389.z = lerp( 1, unpack311_g60389.z, saturate(_DetailNormalMapScale) );
				float2 weightedBlendVar3825_g60389 = float2( 0.5,0.5 );
				float3 weightedBlend3825_g60389 = ( weightedBlendVar3825_g60389.x*unpack268_g60389 + weightedBlendVar3825_g60389.y*unpack311_g60389 );
				float3 lerpResult2330_g60389 = lerp( unpack268_g60389 , weightedBlend3825_g60389 , DetailMask_A2207_g60389);
				float ENABLE_DETAIL3658_g60389 = _DETAIL_MULX2;
				float3 lerpResult3665_g60389 = lerp( unpack268_g60389 , lerpResult2330_g60389 , ENABLE_DETAIL3658_g60389);
				float3 temp_output_20_0_g61671 = lerpResult3665_g60389;
				float2 _Vector4 = float2(1,1);
				float4 appendResult3784_g61671 = (float4(1.0 , tex2DNode172_g61671.r , 0.0 , tex2DNode172_g61671.g));
				float3 unpack3786_g61671 = UnpackNormalScale( appendResult3784_g61671, _RainDripNormalScale );
				unpack3786_g61671.z = lerp( 1, unpack3786_g61671.z, saturate(_RainDripNormalScale) );
				float3 normalizeResult3787_g61671 = ASESafeNormalize( unpack3786_g61671 );
				float3 lerpResult588_g61671 = lerp( temp_output_20_0_g61671 , normalizeResult3787_g61671 , temp_output_1689_0_g61671);
				float2 weightedBlendVar1635_g61671 = _Vector4;
				float3 weightedBlend1635_g61671 = ( weightedBlendVar1635_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1635_g61671.y*lerpResult588_g61671 );
				float ENABLE_DRIPS1644_g61671 = _ENABLEDRIPS;
				float3 lerpResult1640_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1635_g61671 , ENABLE_DRIPS1644_g61671);
				float4 appendResult3767_g61671 = (float4(1.0 , tex2DNode257_g61671.r , 0.0 , tex2DNode257_g61671.g));
				float3 unpack3768_g61671 = UnpackNormalScale( appendResult3767_g61671, _RainDropNormalScale );
				unpack3768_g61671.z = lerp( 1, unpack3768_g61671.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g61671 = ASESafeNormalize( unpack3768_g61671 );
				float3 lerpResult1298_g61671 = lerp( normalizeResult3770_g61671 , temp_output_20_0_g61671 , (temp_output_3691_0_g61671*2.0 + -1.0));
				float2 weightedBlendVar1637_g61671 = _Vector4;
				float3 weightedBlend1637_g61671 = ( weightedBlendVar1637_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1637_g61671.y*lerpResult1298_g61671 );
				float ENABLE_DROPS1643_g61671 = _ENABLEDROPS;
				float3 lerpResult1641_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1637_g61671 , ENABLE_DROPS1643_g61671);
				float3 weightedBlendVar1305_g61671 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend1305_g61671 = ( weightedBlendVar1305_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1305_g61671.y*lerpResult1640_g61671 + weightedBlendVar1305_g61671.z*lerpResult1641_g61671 );
				float3 lerpResult2879_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1305_g61671 , Global_Rain_Intensity1484_g61671);
				float4 appendResult64_g61671 = (float4(PositionWS.x , PositionWS.z , PositionWS.x , PositionWS.z));
				float4 _Vector9 = float4(0.4,0.02,-0.1,0.4);
				float _WindDirection2282_g61671 = Wind_Direction2547_g61671;
				float2 localDirectionalEquation2282_g61671 = DirectionalEquation( _WindDirection2282_g61671 );
				float2 break2281_g61671 = localDirectionalEquation2282_g61671;
				float4 appendResult2278_g61671 = (float4(break2281_g61671.x , break2281_g61671.y , break2281_g61671.x , break2281_g61671.y));
				float4 temp_output_63_0_g61671 = ( ( appendResult64_g61671 * float4( 1.8,1.3,0.7,1.7 ) ) + ( ( Time1591_g61671 * _PuddleNormalSpeed ) * ( _Vector9 * appendResult2278_g61671 ) ) );
				float2 temp_output_1535_0_g61671 = (_RainPuddleNormal_ST).xy;
				float2 temp_output_1531_0_g61671 = (_RainPuddleNormal_ST).zw;
				float3 unpack44_g61671 = UnpackNormalScale( SAMPLE_TEXTURE2D( _RainPuddleNormal, sampler_RainPuddleNormal, ( ( (temp_output_63_0_g61671).xy * temp_output_1535_0_g61671 ) + temp_output_1531_0_g61671 ) ), _PuddleNormalStrength );
				unpack44_g61671.z = lerp( 1, unpack44_g61671.z, saturate(_PuddleNormalStrength) );
				float3 unpack70_g61671 = UnpackNormalScale( SAMPLE_TEXTURE2D( _RainPuddleNormal, sampler_RainPuddleNormal, ( ( (temp_output_63_0_g61671).zw * temp_output_1535_0_g61671 ) + temp_output_1531_0_g61671 ) ), _PuddleNormalStrength );
				unpack70_g61671.z = lerp( 1, unpack70_g61671.z, saturate(_PuddleNormalStrength) );
				float4 appendResult84_g61671 = (float4(PositionWS.x , PositionWS.z , PositionWS.x , PositionWS.z));
				float4 temp_output_81_0_g61671 = ( float4( 0.25,0.25,0.27,0.27 ) * ( float4( 0,0,-0.55,0.3 ) + appendResult84_g61671 ) );
				float2 temp_output_1413_0_g61671 = (_RainPuddleRipple_ST).xy;
				float2 temp_output_1417_0_g61671 = (_RainPuddleRipple_ST).zw;
				float4 tex2DNode627_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_81_0_g61671).xy * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult640_g61671 = (float2(tex2DNode627_g61671.r , tex2DNode627_g61671.g));
				float2 temp_cast_6 = (1.0).xx;
				float4 temp_cast_7 = (Global_Rain_Intensity1484_g61671).xxxx;
				float4 break764_g61671 = saturate( ( ( temp_cast_7 - float4( 0, 0.25, 0, 0.75 ) ) * float4( 4,4,4,4 ) ) );
				float temp_output_1611_0_g61671 = ( Time1591_g61671 * _PuddleRippleSpeed );
				float temp_output_637_0_g61671 = frac( ( tex2DNode627_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult633_g61671 = clamp( ( ( tex2DNode627_g61671.b + ( temp_output_637_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 break91_g61671 = ( saturate( ( ( temp_cast_7 - float4( 0, 0.25, 0, 0.75 ) ) * float4( 4,4,4,4 ) ) ) * _PuddleRippleStrength );
				float4 tex2DNode662_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_81_0_g61671).zw * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult675_g61671 = (float2(tex2DNode662_g61671.r , tex2DNode662_g61671.g));
				float2 temp_cast_8 = (1.0).xx;
				float temp_output_672_0_g61671 = frac( ( tex2DNode662_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult668_g61671 = clamp( ( ( tex2DNode662_g61671.b + ( temp_output_672_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 temp_output_80_0_g61671 = ( float4( 0.32,0.32,0.32,0.32 ) * ( appendResult84_g61671 + float4( 0.6,0.85,0.5,-0.75 ) ) );
				float4 tex2DNode693_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_80_0_g61671).xy * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult706_g61671 = (float2(tex2DNode693_g61671.r , tex2DNode693_g61671.g));
				float2 temp_cast_9 = (1.0).xx;
				float temp_output_703_0_g61671 = frac( ( tex2DNode693_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult699_g61671 = clamp( ( ( tex2DNode693_g61671.b + ( temp_output_703_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 tex2DNode724_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_80_0_g61671).zw * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult737_g61671 = (float2(tex2DNode724_g61671.r , tex2DNode724_g61671.g));
				float2 temp_cast_10 = (1.0).xx;
				float temp_output_734_0_g61671 = frac( ( tex2DNode724_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult730_g61671 = clamp( ( ( tex2DNode724_g61671.b + ( temp_output_734_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float2 break27_g61671 = ( ( ( ( ( ( ( appendResult640_g61671 * 2.0 ) - temp_cast_6 ) * ( ( tex2DNode627_g61671.b * saturate( ( ( break764_g61671.x + 2.0 ) - temp_output_637_0_g61671 ) ) ) * sin( ( clampResult633_g61671 * PI ) ) ) ) * break91_g61671.x ) + ( ( ( ( appendResult675_g61671 * 2.0 ) - temp_cast_8 ) * ( ( tex2DNode662_g61671.b * saturate( ( ( break764_g61671.y + 2.0 ) - temp_output_672_0_g61671 ) ) ) * sin( ( clampResult668_g61671 * PI ) ) ) ) * break91_g61671.y ) ) + ( ( ( ( appendResult706_g61671 * 2.0 ) - temp_cast_9 ) * ( ( tex2DNode693_g61671.b * saturate( ( ( break764_g61671.z + 2.0 ) - temp_output_703_0_g61671 ) ) ) * sin( ( clampResult699_g61671 * PI ) ) ) ) * break91_g61671.z ) ) + ( ( ( ( appendResult737_g61671 * 2.0 ) - temp_cast_10 ) * ( ( tex2DNode724_g61671.b * saturate( ( ( break764_g61671.w + 2.0 ) - temp_output_734_0_g61671 ) ) ) * sin( ( clampResult730_g61671 * PI ) ) ) ) * break91_g61671.w ) );
				float3 Normal1292_g61671 = temp_output_20_0_g61671;
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal25_g61671 = Normal1292_g61671;
				float3 worldNormal25_g61671 = normalize( float3( dot( tanToWorld0, tanNormal25_g61671 ), dot( tanToWorld1, tanNormal25_g61671 ), dot( tanToWorld2, tanNormal25_g61671 ) ) );
				float3 break2850_g61671 = worldNormal25_g61671;
				float3 appendResult24_g61671 = (float3(( break27_g61671.x + break2850_g61671.x ) , 1.0 , ( break27_g61671.y + break2850_g61671.z )));
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				float3 worldToTangentDir28_g61671 = ASESafeNormalize( mul( ase_worldToTangent, appendResult24_g61671 ) );
				float3 lerpResult19_g61671 = lerp( weightedBlend1305_g61671 , BlendNormal( BlendNormal( unpack44_g61671 , unpack70_g61671 ) , worldToTangentDir28_g61671 ) , Puddle1461_g61671);
				float3 lerpResult1478_g61671 = lerp( weightedBlend1305_g61671 , lerpResult19_g61671 , Mask_Puddle1482_g61671);
				float3 break2733_g61671 = Normal1292_g61671;
				float2 appendResult2740_g61671 = (float2(break2733_g61671.x , break2733_g61671.y));
				float2 break2735_g61671 = ( appendResult2740_g61671 * _PuddleNormalStrengthBase );
				float lerpResult2736_g61671 = lerp( 1.0 , max( break2733_g61671.z , 1.0 ) , _PuddleNormalStrengthBase);
				float3 appendResult2738_g61671 = (float3(break2735_g61671.x , break2735_g61671.y , lerpResult2736_g61671));
				float3 appendResult2822_g61671 = (float3(( (appendResult2738_g61671).xy + (lerpResult1478_g61671).xy ) , ( (appendResult2738_g61671).z * (lerpResult1478_g61671).z )));
				float3 normalizeResult2823_g61671 = ASESafeNormalize( appendResult2822_g61671 );
				float3 lerpResult2717_g61671 = lerp( lerpResult1478_g61671 , normalizeResult2823_g61671 , Puddle1461_g61671);
				float3 lerpResult3261_g61671 = lerp( temp_output_20_0_g61671 , lerpResult2717_g61671 , Global_Rain_Intensity1484_g61671);
				float3 lerpResult3277_g61671 = lerp( lerpResult2879_g61671 , lerpResult3261_g61671 , _PuddleIntensity);
				float3 lerpResult1381_g61671 = lerp( lerpResult2879_g61671 , lerpResult3277_g61671 , _ENABLEPUDDLE);
				float3 lerpResult790_g61671 = lerp( temp_output_20_0_g61671 , lerpResult1381_g61671 , ENABLE_RAIN363_g61671);
				
				float Alpha_MetallicGlossMap635_g60389 = (temp_output_2_0_g60390).a;
				float temp_output_3172_0_g60389 = ( (temp_output_2_0_g61666).a * 1.0 );
				float Alpha_BaseColor2431_g60389 = temp_output_3172_0_g60389;
				float lerpResult3626_g60389 = lerp( Alpha_MetallicGlossMap635_g60389 , Alpha_BaseColor2431_g60389 , _SmoothnesstexturechannelM);
				float lerpResult3624_g60389 = lerp( _GlossMapScale , _Glossiness , _SmoothnesstexturechannelM);
				float lerpResult4136_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float lerpResult1861_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , _PuddleSmoothness , lerpResult4136_g61671);
				float lerpResult307_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult1861_g61671 , Puddle1461_g61671);
				float lerpResult1857_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult307_g61671 , ENABLE_PUDDLE1379_g61671);
				float lerpResult3218_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult1857_g61671 , Global_Rain_Intensity1484_g61671);
				float lerpResult3285_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3218_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult3582_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3285_g61671 , ENABLE_PUDDLE1379_g61671);
				float MaskDrips3024_g61671 = temp_output_1689_0_g61671;
				float saferPower3000_g61671 = abs( MaskDrips3024_g61671 );
				float lerpResult2986_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , _RainDripSmoothness , round( pow( saferPower3000_g61671 , 0.1 ) ));
				float lerpResult3013_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult2986_g61671 , Drips3491_g61671);
				float lerpResult3016_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3013_g61671 , ENABLE_DRIPS1644_g61671);
				float lerpResult3253_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3016_g61671 , Global_Rain_Intensity1484_g61671);
				float smoothstepResult3849_g61671 = smoothstep( 0.0 , 1.0 , ( NormalWS.y + 0.02 ));
				float Mask_Horizontal1481_g61671 = ( smoothstepResult3849_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3963_g61671 = lerp( 0.0001 , temp_output_3691_0_g61671 , Mask_Vertical_Z3918_g61671);
				float lerpResult3962_g61671 = lerp( 0.0001 , temp_output_3691_0_g61671 , Mask_Vertical_X3920_g61671);
				float lerpResult3964_g61671 = lerp( lerpResult3963_g61671 , ( lerpResult3963_g61671 + lerpResult3962_g61671 ) , Mask_Vertical_Y3919_g61671);
				float MaskDrops1847_g61671 = (( ( temp_output_3691_0_g61671 * Mask_Horizontal1481_g61671 ) + lerpResult3964_g61671 )*2.0 + -1.0);
				float saferPower1848_g61671 = abs( MaskDrops1847_g61671 );
				float lerpResult2673_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , _RainDropSmoothness , pow( saferPower1848_g61671 , 1E-05 ));
				float lerpResult2949_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult2673_g61671 , Drops3492_g61671);
				float lerpResult2649_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult2949_g61671 , ENABLE_DROPS1643_g61671);
				float lerpResult1853_g61671 = lerp( lerpResult2649_g61671 , lerpResult1857_g61671 , ( Puddle1461_g61671 * Puddle1461_g61671 ));
				float lerpResult3296_g61671 = lerp( lerpResult2649_g61671 , lerpResult1853_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult3538_g61671 = lerp( lerpResult2649_g61671 , lerpResult3296_g61671 , ENABLE_PUDDLE1379_g61671);
				float lerpResult2869_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3538_g61671 , Global_Rain_Intensity1484_g61671);
				float3 weightedBlendVar3316_g61671 = float3( 0.5, 0.5, 0.5 );
				float weightedBlend3316_g61671 = ( weightedBlendVar3316_g61671.x*lerpResult3582_g61671 + weightedBlendVar3316_g61671.y*lerpResult3253_g61671 + weightedBlendVar3316_g61671.z*lerpResult2869_g61671 );
				float lerpResult801_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , weightedBlend3316_g61671 , ENABLE_RAIN363_g61671);
				
				float4 tex2DNode610_g60389 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float lerpResult4139_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float lerpResult3811_g61671 = lerp( ( Drips3491_g61671 + Drops3492_g61671 ) , ( 1.0 - _PuddleAmbientOcclusion ) , lerpResult4139_g61671);
				float lerpResult3816_g61671 = lerp( ( Drips3491_g61671 + Drops3492_g61671 ) , lerpResult3811_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult3819_g61671 = lerp( ( Drips3491_g61671 + Drops3492_g61671 ) , lerpResult3816_g61671 , ENABLE_PUDDLE1379_g61671);
				float lerpResult308_g61671 = lerp( saturate( ( tex2DNode610_g60389.r * ( 1.0 - _OcclusionStrength ) ) ) , 0.5 , lerpResult3819_g61671);
				float lerpResult2871_g61671 = lerp( saturate( ( tex2DNode610_g60389.r * ( 1.0 - _OcclusionStrength ) ) ) , lerpResult308_g61671 , Global_Rain_Intensity1484_g61671);
				float lerpResult802_g61671 = lerp( saturate( ( tex2DNode610_g60389.r * ( 1.0 - _OcclusionStrength ) ) ) , lerpResult2871_g61671 , ENABLE_RAIN363_g61671);
				
				half3 color3067_g60389 = IsGammaSpace() ? half3( 0.003921569, 0, 0 ) : half3( 0.000303527, 0, 0 );
				float m_switch592_g60389 = _UVEmissive;
				float2 m_UV0592_g60389 = input.ase_texcoord6.xy;
				float2 m_UV1592_g60389 = input.ase_texcoord6.zw;
				float2 m_UV2592_g60389 = input.ase_texcoord7.xy;
				float2 m_UV3592_g60389 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode592_g60389 = float2switchUVMode592_g60389( m_switch592_g60389 , m_UV0592_g60389 , m_UV1592_g60389 , m_UV2592_g60389 , m_UV3592_g60389 );
				float2 appendResult593_g60389 = (float2(_EmissionMap_ST.x , _EmissionMap_ST.y));
				float2 appendResult595_g60389 = (float2(_EmissionMap_ST.z , _EmissionMap_ST.w));
				float2 UV_EmissiveMap597_g60389 = ( ( localfloat2switchUVMode592_g60389 * appendResult593_g60389 ) + appendResult595_g60389 );
				float3 lerpResult3649_g60389 = lerp( color3067_g60389 , ( (SAMPLE_TEXTURE2D( _EmissionMap, sampler_EmissionMap, UV_EmissiveMap597_g60389 )).rgb * ( (_EmissionColor).rgb * ( _EmissiveIntensity + ( _EmissionFlags * 0.0 ) ) ) ) , ( _EnableEmission + ( ( _CATEGORY_EMISSION + _CATEGORYSPACE_EMISSION ) * 0.0 ) ));
				
				float m_switch3404_g61674 = _ClearCoatUVMapping;
				float2 m_UV03404_g61674 = input.ase_texcoord6.xy;
				float2 m_UV13404_g61674 = input.ase_texcoord6.zw;
				float2 m_UV23404_g61674 = input.ase_texcoord7.xy;
				float2 m_UV33404_g61674 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode3404_g61674 = float2switchUVMode3404_g61674( m_switch3404_g61674 , m_UV03404_g61674 , m_UV13404_g61674 , m_UV23404_g61674 , m_UV33404_g61674 );
				float2 appendResult3396_g61674 = (float2(_ClearCoatMap_ST.x , _ClearCoatMap_ST.y));
				float2 appendResult3397_g61674 = (float2(_ClearCoatMap_ST.z , _ClearCoatMap_ST.w));
				float4 tex2DNode3387_g61674 = SAMPLE_TEXTURE2D( _ClearCoatMap, sampler_ClearCoatMap, ( ( localfloat2switchUVMode3404_g61674 * appendResult3396_g61674 ) + appendResult3397_g61674 ) );
				float temp_output_3752_0_g61674 = ( _ClearCoat + ( ( _CATEGORY_COATMASK + _CATEGORYSPACE_COATMASK ) * 0.0 ) );
				float lerpResult3385_g61674 = lerp( 0.0 , ( tex2DNode3387_g61674.r * _ClearCoatMask ) , temp_output_3752_0_g61674);
				
				float lerpResult3409_g61674 = lerp( 0.0 , ( tex2DNode3387_g61674.g * _ClearCoatSmoothness ) , temp_output_3752_0_g61674);
				

				float3 BaseColor = lerpResult799_g61671;
				float3 Normal = lerpResult790_g61671;
				float3 Specular = 0.5;
				float Metallic = temp_output_343_3092.x;
				float Smoothness = lerpResult801_g61671;
				float Occlusion = lerpResult802_g61671;
				float3 Emission = lerpResult3649_g60389;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = ClipPos.z;
				#endif

				#ifdef _CLEARCOAT
					float CoatMask = lerpResult3385_g61674;
					float CoatSmoothness = lerpResult3409_g61674;
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
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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

				

				float Alpha = 1;
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
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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

				

				float Alpha = 1;
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
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL


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
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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
			TEXTURE2D(_MetallicGlossMap);
			TEXTURE2D(_RainPuddleMask);
			SAMPLER(sampler_RainPuddleMask);
			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);
			TEXTURE2D(_EmissionMap);
			SAMPLER(sampler_EmissionMap);


			float2 float2switchUVMode566_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode592_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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

				float3 ase_normalWS = TransformObjectToWorldNormal( input.normalOS );
				output.ase_texcoord5.xyz = ase_normalWS;
				
				output.ase_texcoord3.xy = input.texcoord0.xy;
				output.ase_texcoord3.zw = input.texcoord1.xy;
				output.ase_texcoord4.xy = input.texcoord2.xy;
				output.ase_texcoord4.zw = input.ase_texcoord3.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord5.w = 0;

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

				float m_switch566_g60389 = _UVBase;
				float2 m_UV0566_g60389 = input.ase_texcoord3.xy;
				float2 m_UV1566_g60389 = input.ase_texcoord3.zw;
				float2 m_UV2566_g60389 = input.ase_texcoord4.xy;
				float2 m_UV3566_g60389 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode566_g60389 = float2switchUVMode566_g60389( m_switch566_g60389 , m_UV0566_g60389 , m_UV1566_g60389 , m_UV2566_g60389 , m_UV3566_g60389 );
				float2 appendResult772_g60389 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g60389 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g60389 = ( ( localfloat2switchUVMode566_g60389 * appendResult772_g60389 ) + appendResult773_g60389 );
				float4 temp_output_2_0_g61666 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_2444_0_g60389 = ( (temp_output_2_0_g61666).rgb * (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_COLOR + _CATEGORYSPACE_COLOR + _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) );
				float m_switch571_g60389 = _UVDetail;
				float2 m_UV0571_g60389 = input.ase_texcoord3.xy;
				float2 m_UV1571_g60389 = input.ase_texcoord3.zw;
				float2 m_UV2571_g60389 = input.ase_texcoord4.xy;
				float2 m_UV3571_g60389 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode571_g60389 = float2switchUVMode571_g60389( m_switch571_g60389 , m_UV0571_g60389 , m_UV1571_g60389 , m_UV2571_g60389 , m_UV3571_g60389 );
				float2 appendResult574_g60389 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g60389 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g60389 = ( ( localfloat2switchUVMode571_g60389 * appendResult574_g60389 ) + appendResult578_g60389 );
				float3 DetailMap2602_g60389 = (SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_BaseMap, UV_DetailMap583_g60389 )).rgb;
				float3 lerpResult3088_g60389 = lerp( DetailMap2602_g60389 , ( DetailMap2602_g60389 * (unity_ColorSpaceDouble).rgb ) , _DetailAlbedoMapScale);
				float DetailMask_A2207_g60389 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g60389 ).a;
				float temp_output_2_0_g60393 = DetailMask_A2207_g60389;
				float temp_output_3_0_g60393 = ( 1.0 - temp_output_2_0_g60393 );
				float3 appendResult7_g60393 = (float3(temp_output_3_0_g60393 , temp_output_3_0_g60393 , temp_output_3_0_g60393));
				float3 lerpResult3662_g60389 = lerp( temp_output_2444_0_g60389 , ( temp_output_2444_0_g60389 * ( ( lerpResult3088_g60389 * temp_output_2_0_g60393 ) + appendResult7_g60393 ) ) , ( _DETAIL_MULX2 + ( ( _CATEGORY_DETAIL + _CATEGORYSPACE_DETAIL ) * 0.0 ) ));
				float3 temp_output_2628_0_g61671 = ( saturate( lerpResult3662_g60389 ) * 0.2 );
				float4 temp_output_2_0_g60390 = SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_343_3092 = ( (temp_output_2_0_g60390).rgb * _Metallic );
				float temp_output_386_0_g61671 = ( 1.0 - saturate( max( temp_output_343_3092.x , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float temp_output_2631_0_g61671 = saturate( max( temp_output_386_0_g61671 , min( _GlobalRainWetness , 0.94 ) ) );
				float3 lerpResult4144_g61671 = lerp( lerpResult3662_g60389 , temp_output_2628_0_g61671 , ( ( _GlobalRainWetness * 0.85 ) * temp_output_2631_0_g61671 ));
				float2 appendResult1393_g61671 = (float2(PositionWS.x , PositionWS.z));
				float4 tex2DNode30_g61671 = SAMPLE_TEXTURE2D( _RainPuddleMask, sampler_RainPuddleMask, ( ( appendResult1393_g61671 * (_RainPuddleMask_ST).xy ) + (_RainPuddleMask_ST).zw ) );
				float4 _Vector0 = float4(1E-05,0,0.4,0.2);
				float2 appendResult7_g61671 = (float2(_Vector0.x , _Vector0.y));
				float2 appendResult8_g61671 = (float2(_Vector0.z , _Vector0.w));
				float2 lerpResult9_g61671 = lerp( appendResult7_g61671 , appendResult8_g61671 , _PuddleSize);
				float2 break14_g61671 = lerpResult9_g61671;
				float saferPower17_g61671 = abs( saturate( ( ( ( saturate( ( _PuddleHeight * 10.0 ) ) * saturate(  (0.0 + ( tex2DNode30_g61671.r - 0.0 ) * ( ( ( saturate( ( _PuddleHeight + -0.1 ) ) * 50.0 ) + 1.0 ) - 0.0 ) / ( 1.0 - 0.0 ) ) ) ) * ( ( 1.0 - saturate( ( ( tex2DNode30_g61671.r - break14_g61671.y ) / break14_g61671.x ) ) ) * _PuddleSize ) ) * 5.0 ) ) );
				float Puddle1461_g61671 = pow( saferPower17_g61671 , 6.0 );
				float3 ase_normalWS = input.ase_texcoord5.xyz;
				float saferPower462_g61671 = abs( saturate( ase_normalWS.y ) );
				float Mask_Puddle1482_g61671 = pow( saferPower462_g61671 , 80.0 );
				float lerpResult4134_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float Puddle_Intensity3276_g61671 = _PuddleIntensity;
				float3 lerpResult305_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , ( ( 1.0 - ( temp_output_2631_0_g61671 * lerpResult4134_g61671 ) ) * ( Puddle_Intensity3276_g61671 + 0.25 ) ));
				float ENABLE_RAIN363_g61671 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61671 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61671 );
				float3 lerpResult3545_g61671 = lerp( lerpResult3662_g60389 , lerpResult305_g61671 , Global_Rain_Intensity1484_g61671);
				float3 lerpResult3559_g61671 = lerp( temp_output_2628_0_g61671 , lerpResult3545_g61671 , _PuddleIntensity);
				float ENABLE_PUDDLE1379_g61671 = _ENABLEPUDDLE;
				float3 lerpResult3586_g61671 = lerp( temp_output_2628_0_g61671 , lerpResult3559_g61671 , ENABLE_PUDDLE1379_g61671);
				float Wind_Direction2547_g61671 = _GlobalRainWindDirection;
				float temp_output_4713_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 temp_output_183_0_g61671 = (PositionWS).yx;
				float2 lerpResult4672_g61671 = lerp( temp_output_183_0_g61671 , ( 1.0 - temp_output_183_0_g61671 ) , _RainDripMaskInvert);
				float2 break4707_g61671 = ( lerpResult4672_g61671 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4717_g61671 = (float2(( ( temp_output_4713_0_g61671 * break4707_g61671.x ) + ( temp_output_4712_0_g61671 * break4707_g61671.y ) ) , ( ( temp_output_4713_0_g61671 * break4707_g61671.y ) - ( temp_output_4712_0_g61671 * break4707_g61671.x ) )));
				float Permeability387_g61671 = temp_output_386_0_g61671;
				float lerpResult193_g61671 = lerp( 0.2 , 0.03 , Permeability387_g61671);
				float lerpResult194_g61671 = lerp( 0.0 , 0.0125 , Permeability387_g61671);
				float temp_output_4405_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61671 = ( input.ase_texcoord3.xy - _Anchor );
				float temp_output_4406_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4415_g61671 = (float2(( ( temp_output_4405_0_g61671 * break4413_g61671.x ) + ( temp_output_4406_0_g61671 * break4413_g61671.y ) ) , ( ( temp_output_4405_0_g61671 * break4413_g61671.y ) - ( temp_output_4406_0_g61671 * break4413_g61671.x ) )));
				float4 tex2DNode172_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float lerpResult185_g61671 = lerp( lerpResult193_g61671 , lerpResult194_g61671 , tex2DNode172_g61671.a);
				float Time1591_g61671 = _TimeParameters.x;
				float temp_output_186_0_g61671 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61671 + ( lerpResult185_g61671 * ( ( Time1591_g61671 * _RainDripSpeed ) + tex2DNode172_g61671.a ) ) ) ).r * tex2DNode172_g61671.b );
				float3 temp_cast_1 = (0.5).xxx;
				float3 break3837_g61671 = ( abs( ase_normalWS ) - temp_cast_1 );
				float smoothstepResult3838_g61671 = smoothstep( 0.1 , 1.0 , ( break3837_g61671.z + 0.5 ));
				float Mask_Vertical_Z3918_g61671 = ( smoothstepResult3838_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3929_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_Z3918_g61671);
				float smoothstepResult3864_g61671 = smoothstep( 0.0 , 1.0 , ( break3837_g61671.x + 0.45 ));
				float Mask_Vertical_X3920_g61671 = ( smoothstepResult3864_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3930_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_X3920_g61671);
				float smoothstepResult3839_g61671 = smoothstep( 0.0 , 1.0 , ( -break3837_g61671.y + 0.45 ));
				float Mask_Vertical_Y3919_g61671 = ( smoothstepResult3839_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3931_g61671 = lerp( lerpResult3929_g61671 , ( lerpResult3929_g61671 + lerpResult3930_g61671 ) , Mask_Vertical_Y3919_g61671);
				float temp_output_1689_0_g61671 = ( lerpResult3931_g61671 * _RainDripIntensity );
				float lerpResult1663_g61671 = lerp( 0.0 , temp_output_1689_0_g61671 , _ENABLEDRIPS);
				float Drips3491_g61671 = saturate( lerpResult1663_g61671 );
				float3 lerpResult3462_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , saturate( ( temp_output_2631_0_g61671 * Drips3491_g61671 ) ));
				float3 lerpResult3546_g61671 = lerp( lerpResult3662_g60389 , lerpResult3462_g61671 , Global_Rain_Intensity1484_g61671);
				float2 temp_output_1355_0_g61671 = ( ( input.ase_texcoord3.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61671, ddx( temp_output_1355_0_g61671 ), ddy( temp_output_1355_0_g61671 ) );
				float temp_output_3696_0_g61671 = ( ( tex2DNode257_g61671.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61671 = ( frac( ( tex2DNode257_g61671.b - ( Time1591_g61671 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61671 ) );
				float lerpResult4471_g61671 = lerp( ( temp_output_1818_0_g61671 + saturate( -temp_output_3696_0_g61671 ) ) , temp_output_1818_0_g61671 , _RainDropStaticScale);
				float temp_output_3691_0_g61671 = ( lerpResult4471_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult1664_g61671 = lerp( 0.0 , (temp_output_3691_0_g61671*2.0 + -1.0) , _ENABLEDROPS);
				float Drops3492_g61671 = saturate( lerpResult1664_g61671 );
				float temp_output_3457_0_g61671 = saturate( ( temp_output_2631_0_g61671 * Drops3492_g61671 ) );
				float lerpResult4141_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float lerpResult4102_g61671 = lerp( temp_output_3457_0_g61671 , saturate( temp_output_2631_0_g61671 ) , lerpResult4141_g61671);
				float lerpResult4126_g61671 = lerp( temp_output_3457_0_g61671 , lerpResult4102_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult4100_g61671 = lerp( temp_output_3457_0_g61671 , lerpResult4126_g61671 , ENABLE_PUDDLE1379_g61671);
				float3 lerpResult3399_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , lerpResult4100_g61671);
				float3 lerpResult3547_g61671 = lerp( lerpResult3662_g60389 , lerpResult3399_g61671 , Global_Rain_Intensity1484_g61671);
				float3 weightedBlendVar3481_g61671 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend3481_g61671 = ( weightedBlendVar3481_g61671.x*lerpResult3586_g61671 + weightedBlendVar3481_g61671.y*lerpResult3546_g61671 + weightedBlendVar3481_g61671.z*lerpResult3547_g61671 );
				float3 lerpResult799_g61671 = lerp( lerpResult3662_g60389 , weightedBlend3481_g61671 , ENABLE_RAIN363_g61671);
				
				half3 color3067_g60389 = IsGammaSpace() ? half3( 0.003921569, 0, 0 ) : half3( 0.000303527, 0, 0 );
				float m_switch592_g60389 = _UVEmissive;
				float2 m_UV0592_g60389 = input.ase_texcoord3.xy;
				float2 m_UV1592_g60389 = input.ase_texcoord3.zw;
				float2 m_UV2592_g60389 = input.ase_texcoord4.xy;
				float2 m_UV3592_g60389 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode592_g60389 = float2switchUVMode592_g60389( m_switch592_g60389 , m_UV0592_g60389 , m_UV1592_g60389 , m_UV2592_g60389 , m_UV3592_g60389 );
				float2 appendResult593_g60389 = (float2(_EmissionMap_ST.x , _EmissionMap_ST.y));
				float2 appendResult595_g60389 = (float2(_EmissionMap_ST.z , _EmissionMap_ST.w));
				float2 UV_EmissiveMap597_g60389 = ( ( localfloat2switchUVMode592_g60389 * appendResult593_g60389 ) + appendResult595_g60389 );
				float3 lerpResult3649_g60389 = lerp( color3067_g60389 , ( (SAMPLE_TEXTURE2D( _EmissionMap, sampler_EmissionMap, UV_EmissiveMap597_g60389 )).rgb * ( (_EmissionColor).rgb * ( _EmissiveIntensity + ( _EmissionFlags * 0.0 ) ) ) ) , ( _EnableEmission + ( ( _CATEGORY_EMISSION + _CATEGORYSPACE_EMISSION ) * 0.0 ) ));
				

				float3 BaseColor = lerpResult799_g61671;
				float3 Emission = lerpResult3649_g60389;
				float Alpha = 1;
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

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
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
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL


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
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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
			TEXTURE2D(_MetallicGlossMap);
			TEXTURE2D(_RainPuddleMask);
			SAMPLER(sampler_RainPuddleMask);
			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			float2 float2switchUVMode566_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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

				float3 ase_normalWS = TransformObjectToWorldNormal( input.normalOS );
				output.ase_texcoord3.xyz = ase_normalWS;
				
				output.ase_texcoord1.xy = input.ase_texcoord.xy;
				output.ase_texcoord1.zw = input.ase_texcoord1.xy;
				output.ase_texcoord2.xy = input.ase_texcoord2.xy;
				output.ase_texcoord2.zw = input.ase_texcoord3.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.w = 0;

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

				float m_switch566_g60389 = _UVBase;
				float2 m_UV0566_g60389 = input.ase_texcoord1.xy;
				float2 m_UV1566_g60389 = input.ase_texcoord1.zw;
				float2 m_UV2566_g60389 = input.ase_texcoord2.xy;
				float2 m_UV3566_g60389 = input.ase_texcoord2.zw;
				float2 localfloat2switchUVMode566_g60389 = float2switchUVMode566_g60389( m_switch566_g60389 , m_UV0566_g60389 , m_UV1566_g60389 , m_UV2566_g60389 , m_UV3566_g60389 );
				float2 appendResult772_g60389 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g60389 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g60389 = ( ( localfloat2switchUVMode566_g60389 * appendResult772_g60389 ) + appendResult773_g60389 );
				float4 temp_output_2_0_g61666 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_2444_0_g60389 = ( (temp_output_2_0_g61666).rgb * (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_COLOR + _CATEGORYSPACE_COLOR + _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) );
				float m_switch571_g60389 = _UVDetail;
				float2 m_UV0571_g60389 = input.ase_texcoord1.xy;
				float2 m_UV1571_g60389 = input.ase_texcoord1.zw;
				float2 m_UV2571_g60389 = input.ase_texcoord2.xy;
				float2 m_UV3571_g60389 = input.ase_texcoord2.zw;
				float2 localfloat2switchUVMode571_g60389 = float2switchUVMode571_g60389( m_switch571_g60389 , m_UV0571_g60389 , m_UV1571_g60389 , m_UV2571_g60389 , m_UV3571_g60389 );
				float2 appendResult574_g60389 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g60389 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g60389 = ( ( localfloat2switchUVMode571_g60389 * appendResult574_g60389 ) + appendResult578_g60389 );
				float3 DetailMap2602_g60389 = (SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_BaseMap, UV_DetailMap583_g60389 )).rgb;
				float3 lerpResult3088_g60389 = lerp( DetailMap2602_g60389 , ( DetailMap2602_g60389 * (unity_ColorSpaceDouble).rgb ) , _DetailAlbedoMapScale);
				float DetailMask_A2207_g60389 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g60389 ).a;
				float temp_output_2_0_g60393 = DetailMask_A2207_g60389;
				float temp_output_3_0_g60393 = ( 1.0 - temp_output_2_0_g60393 );
				float3 appendResult7_g60393 = (float3(temp_output_3_0_g60393 , temp_output_3_0_g60393 , temp_output_3_0_g60393));
				float3 lerpResult3662_g60389 = lerp( temp_output_2444_0_g60389 , ( temp_output_2444_0_g60389 * ( ( lerpResult3088_g60389 * temp_output_2_0_g60393 ) + appendResult7_g60393 ) ) , ( _DETAIL_MULX2 + ( ( _CATEGORY_DETAIL + _CATEGORYSPACE_DETAIL ) * 0.0 ) ));
				float3 temp_output_2628_0_g61671 = ( saturate( lerpResult3662_g60389 ) * 0.2 );
				float4 temp_output_2_0_g60390 = SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_343_3092 = ( (temp_output_2_0_g60390).rgb * _Metallic );
				float temp_output_386_0_g61671 = ( 1.0 - saturate( max( temp_output_343_3092.x , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float temp_output_2631_0_g61671 = saturate( max( temp_output_386_0_g61671 , min( _GlobalRainWetness , 0.94 ) ) );
				float3 lerpResult4144_g61671 = lerp( lerpResult3662_g60389 , temp_output_2628_0_g61671 , ( ( _GlobalRainWetness * 0.85 ) * temp_output_2631_0_g61671 ));
				float2 appendResult1393_g61671 = (float2(PositionWS.x , PositionWS.z));
				float4 tex2DNode30_g61671 = SAMPLE_TEXTURE2D( _RainPuddleMask, sampler_RainPuddleMask, ( ( appendResult1393_g61671 * (_RainPuddleMask_ST).xy ) + (_RainPuddleMask_ST).zw ) );
				float4 _Vector0 = float4(1E-05,0,0.4,0.2);
				float2 appendResult7_g61671 = (float2(_Vector0.x , _Vector0.y));
				float2 appendResult8_g61671 = (float2(_Vector0.z , _Vector0.w));
				float2 lerpResult9_g61671 = lerp( appendResult7_g61671 , appendResult8_g61671 , _PuddleSize);
				float2 break14_g61671 = lerpResult9_g61671;
				float saferPower17_g61671 = abs( saturate( ( ( ( saturate( ( _PuddleHeight * 10.0 ) ) * saturate(  (0.0 + ( tex2DNode30_g61671.r - 0.0 ) * ( ( ( saturate( ( _PuddleHeight + -0.1 ) ) * 50.0 ) + 1.0 ) - 0.0 ) / ( 1.0 - 0.0 ) ) ) ) * ( ( 1.0 - saturate( ( ( tex2DNode30_g61671.r - break14_g61671.y ) / break14_g61671.x ) ) ) * _PuddleSize ) ) * 5.0 ) ) );
				float Puddle1461_g61671 = pow( saferPower17_g61671 , 6.0 );
				float3 ase_normalWS = input.ase_texcoord3.xyz;
				float saferPower462_g61671 = abs( saturate( ase_normalWS.y ) );
				float Mask_Puddle1482_g61671 = pow( saferPower462_g61671 , 80.0 );
				float lerpResult4134_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float Puddle_Intensity3276_g61671 = _PuddleIntensity;
				float3 lerpResult305_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , ( ( 1.0 - ( temp_output_2631_0_g61671 * lerpResult4134_g61671 ) ) * ( Puddle_Intensity3276_g61671 + 0.25 ) ));
				float ENABLE_RAIN363_g61671 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61671 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61671 );
				float3 lerpResult3545_g61671 = lerp( lerpResult3662_g60389 , lerpResult305_g61671 , Global_Rain_Intensity1484_g61671);
				float3 lerpResult3559_g61671 = lerp( temp_output_2628_0_g61671 , lerpResult3545_g61671 , _PuddleIntensity);
				float ENABLE_PUDDLE1379_g61671 = _ENABLEPUDDLE;
				float3 lerpResult3586_g61671 = lerp( temp_output_2628_0_g61671 , lerpResult3559_g61671 , ENABLE_PUDDLE1379_g61671);
				float Wind_Direction2547_g61671 = _GlobalRainWindDirection;
				float temp_output_4713_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 temp_output_183_0_g61671 = (PositionWS).yx;
				float2 lerpResult4672_g61671 = lerp( temp_output_183_0_g61671 , ( 1.0 - temp_output_183_0_g61671 ) , _RainDripMaskInvert);
				float2 break4707_g61671 = ( lerpResult4672_g61671 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4717_g61671 = (float2(( ( temp_output_4713_0_g61671 * break4707_g61671.x ) + ( temp_output_4712_0_g61671 * break4707_g61671.y ) ) , ( ( temp_output_4713_0_g61671 * break4707_g61671.y ) - ( temp_output_4712_0_g61671 * break4707_g61671.x ) )));
				float Permeability387_g61671 = temp_output_386_0_g61671;
				float lerpResult193_g61671 = lerp( 0.2 , 0.03 , Permeability387_g61671);
				float lerpResult194_g61671 = lerp( 0.0 , 0.0125 , Permeability387_g61671);
				float temp_output_4405_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61671 = ( input.ase_texcoord1.xy - _Anchor );
				float temp_output_4406_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4415_g61671 = (float2(( ( temp_output_4405_0_g61671 * break4413_g61671.x ) + ( temp_output_4406_0_g61671 * break4413_g61671.y ) ) , ( ( temp_output_4405_0_g61671 * break4413_g61671.y ) - ( temp_output_4406_0_g61671 * break4413_g61671.x ) )));
				float4 tex2DNode172_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float lerpResult185_g61671 = lerp( lerpResult193_g61671 , lerpResult194_g61671 , tex2DNode172_g61671.a);
				float Time1591_g61671 = _TimeParameters.x;
				float temp_output_186_0_g61671 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61671 + ( lerpResult185_g61671 * ( ( Time1591_g61671 * _RainDripSpeed ) + tex2DNode172_g61671.a ) ) ) ).r * tex2DNode172_g61671.b );
				float3 temp_cast_1 = (0.5).xxx;
				float3 break3837_g61671 = ( abs( ase_normalWS ) - temp_cast_1 );
				float smoothstepResult3838_g61671 = smoothstep( 0.1 , 1.0 , ( break3837_g61671.z + 0.5 ));
				float Mask_Vertical_Z3918_g61671 = ( smoothstepResult3838_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3929_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_Z3918_g61671);
				float smoothstepResult3864_g61671 = smoothstep( 0.0 , 1.0 , ( break3837_g61671.x + 0.45 ));
				float Mask_Vertical_X3920_g61671 = ( smoothstepResult3864_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3930_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_X3920_g61671);
				float smoothstepResult3839_g61671 = smoothstep( 0.0 , 1.0 , ( -break3837_g61671.y + 0.45 ));
				float Mask_Vertical_Y3919_g61671 = ( smoothstepResult3839_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3931_g61671 = lerp( lerpResult3929_g61671 , ( lerpResult3929_g61671 + lerpResult3930_g61671 ) , Mask_Vertical_Y3919_g61671);
				float temp_output_1689_0_g61671 = ( lerpResult3931_g61671 * _RainDripIntensity );
				float lerpResult1663_g61671 = lerp( 0.0 , temp_output_1689_0_g61671 , _ENABLEDRIPS);
				float Drips3491_g61671 = saturate( lerpResult1663_g61671 );
				float3 lerpResult3462_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , saturate( ( temp_output_2631_0_g61671 * Drips3491_g61671 ) ));
				float3 lerpResult3546_g61671 = lerp( lerpResult3662_g60389 , lerpResult3462_g61671 , Global_Rain_Intensity1484_g61671);
				float2 temp_output_1355_0_g61671 = ( ( input.ase_texcoord1.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61671, ddx( temp_output_1355_0_g61671 ), ddy( temp_output_1355_0_g61671 ) );
				float temp_output_3696_0_g61671 = ( ( tex2DNode257_g61671.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61671 = ( frac( ( tex2DNode257_g61671.b - ( Time1591_g61671 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61671 ) );
				float lerpResult4471_g61671 = lerp( ( temp_output_1818_0_g61671 + saturate( -temp_output_3696_0_g61671 ) ) , temp_output_1818_0_g61671 , _RainDropStaticScale);
				float temp_output_3691_0_g61671 = ( lerpResult4471_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult1664_g61671 = lerp( 0.0 , (temp_output_3691_0_g61671*2.0 + -1.0) , _ENABLEDROPS);
				float Drops3492_g61671 = saturate( lerpResult1664_g61671 );
				float temp_output_3457_0_g61671 = saturate( ( temp_output_2631_0_g61671 * Drops3492_g61671 ) );
				float lerpResult4141_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float lerpResult4102_g61671 = lerp( temp_output_3457_0_g61671 , saturate( temp_output_2631_0_g61671 ) , lerpResult4141_g61671);
				float lerpResult4126_g61671 = lerp( temp_output_3457_0_g61671 , lerpResult4102_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult4100_g61671 = lerp( temp_output_3457_0_g61671 , lerpResult4126_g61671 , ENABLE_PUDDLE1379_g61671);
				float3 lerpResult3399_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , lerpResult4100_g61671);
				float3 lerpResult3547_g61671 = lerp( lerpResult3662_g60389 , lerpResult3399_g61671 , Global_Rain_Intensity1484_g61671);
				float3 weightedBlendVar3481_g61671 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend3481_g61671 = ( weightedBlendVar3481_g61671.x*lerpResult3586_g61671 + weightedBlendVar3481_g61671.y*lerpResult3546_g61671 + weightedBlendVar3481_g61671.z*lerpResult3547_g61671 );
				float3 lerpResult799_g61671 = lerp( lerpResult3662_g60389 , weightedBlend3481_g61671 , ENABLE_RAIN363_g61671);
				

				float3 BaseColor = lerpResult799_g61671;
				float Alpha = 1;
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
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT


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
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_MetallicGlossMap);
			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);
			TEXTURE2D(_RainPuddleNormal);
			SAMPLER(sampler_RainPuddleNormal);
			TEXTURE2D(_RainPuddleRipple);
			SAMPLER(sampler_RainPuddleRipple);
			TEXTURE2D(_RainPuddleMask);
			SAMPLER(sampler_RainPuddleMask);


			float2 float2switchUVMode566_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float2 DirectionalEquation( float _WindDirection )
			{
				float d = _WindDirection * 0.0174532924;
				float xL = cos(d) + 1 / 2;
				float zL = sin(d) + 1 / 2;
				return float2(zL,xL);
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
						 )
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

				float m_switch566_g60389 = _UVBase;
				float2 m_UV0566_g60389 = input.ase_texcoord3.xy;
				float2 m_UV1566_g60389 = input.ase_texcoord3.zw;
				float2 m_UV2566_g60389 = input.ase_texcoord4.xy;
				float2 m_UV3566_g60389 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode566_g60389 = float2switchUVMode566_g60389( m_switch566_g60389 , m_UV0566_g60389 , m_UV1566_g60389 , m_UV2566_g60389 , m_UV3566_g60389 );
				float2 appendResult772_g60389 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g60389 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g60389 = ( ( localfloat2switchUVMode566_g60389 * appendResult772_g60389 ) + appendResult773_g60389 );
				float3 unpack268_g60389 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV_BaseMap2637_g60389 ), _BumpScale );
				unpack268_g60389.z = lerp( 1, unpack268_g60389.z, saturate(_BumpScale) );
				float m_switch571_g60389 = _UVDetail;
				float2 m_UV0571_g60389 = input.ase_texcoord3.xy;
				float2 m_UV1571_g60389 = input.ase_texcoord3.zw;
				float2 m_UV2571_g60389 = input.ase_texcoord4.xy;
				float2 m_UV3571_g60389 = input.ase_texcoord4.zw;
				float2 localfloat2switchUVMode571_g60389 = float2switchUVMode571_g60389( m_switch571_g60389 , m_UV0571_g60389 , m_UV1571_g60389 , m_UV2571_g60389 , m_UV3571_g60389 );
				float2 appendResult574_g60389 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g60389 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g60389 = ( ( localfloat2switchUVMode571_g60389 * appendResult574_g60389 ) + appendResult578_g60389 );
				float3 unpack311_g60389 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_DetailNormalMap, UV_DetailMap583_g60389 ), _DetailNormalMapScale );
				unpack311_g60389.z = lerp( 1, unpack311_g60389.z, saturate(_DetailNormalMapScale) );
				float2 weightedBlendVar3825_g60389 = float2( 0.5,0.5 );
				float3 weightedBlend3825_g60389 = ( weightedBlendVar3825_g60389.x*unpack268_g60389 + weightedBlendVar3825_g60389.y*unpack311_g60389 );
				float DetailMask_A2207_g60389 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g60389 ).a;
				float3 lerpResult2330_g60389 = lerp( unpack268_g60389 , weightedBlend3825_g60389 , DetailMask_A2207_g60389);
				float ENABLE_DETAIL3658_g60389 = _DETAIL_MULX2;
				float3 lerpResult3665_g60389 = lerp( unpack268_g60389 , lerpResult2330_g60389 , ENABLE_DETAIL3658_g60389);
				float3 temp_output_20_0_g61671 = lerpResult3665_g60389;
				float2 _Vector4 = float2(1,1);
				float Wind_Direction2547_g61671 = _GlobalRainWindDirection;
				float temp_output_4405_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61671 = ( input.ase_texcoord3.xy - _Anchor );
				float temp_output_4406_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4415_g61671 = (float2(( ( temp_output_4405_0_g61671 * break4413_g61671.x ) + ( temp_output_4406_0_g61671 * break4413_g61671.y ) ) , ( ( temp_output_4405_0_g61671 * break4413_g61671.y ) - ( temp_output_4406_0_g61671 * break4413_g61671.x ) )));
				float4 tex2DNode172_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float4 appendResult3784_g61671 = (float4(1.0 , tex2DNode172_g61671.r , 0.0 , tex2DNode172_g61671.g));
				float3 unpack3786_g61671 = UnpackNormalScale( appendResult3784_g61671, _RainDripNormalScale );
				unpack3786_g61671.z = lerp( 1, unpack3786_g61671.z, saturate(_RainDripNormalScale) );
				float3 normalizeResult3787_g61671 = ASESafeNormalize( unpack3786_g61671 );
				float temp_output_4713_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 temp_output_183_0_g61671 = (PositionWS).yx;
				float2 lerpResult4672_g61671 = lerp( temp_output_183_0_g61671 , ( 1.0 - temp_output_183_0_g61671 ) , _RainDripMaskInvert);
				float2 break4707_g61671 = ( lerpResult4672_g61671 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4717_g61671 = (float2(( ( temp_output_4713_0_g61671 * break4707_g61671.x ) + ( temp_output_4712_0_g61671 * break4707_g61671.y ) ) , ( ( temp_output_4713_0_g61671 * break4707_g61671.y ) - ( temp_output_4712_0_g61671 * break4707_g61671.x ) )));
				float4 temp_output_2_0_g60390 = SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_343_3092 = ( (temp_output_2_0_g60390).rgb * _Metallic );
				float temp_output_386_0_g61671 = ( 1.0 - saturate( max( temp_output_343_3092.x , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float Permeability387_g61671 = temp_output_386_0_g61671;
				float lerpResult193_g61671 = lerp( 0.2 , 0.03 , Permeability387_g61671);
				float lerpResult194_g61671 = lerp( 0.0 , 0.0125 , Permeability387_g61671);
				float lerpResult185_g61671 = lerp( lerpResult193_g61671 , lerpResult194_g61671 , tex2DNode172_g61671.a);
				float Time1591_g61671 = _TimeParameters.x;
				float temp_output_186_0_g61671 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61671 + ( lerpResult185_g61671 * ( ( Time1591_g61671 * _RainDripSpeed ) + tex2DNode172_g61671.a ) ) ) ).r * tex2DNode172_g61671.b );
				float3 temp_cast_5 = (0.5).xxx;
				float3 break3837_g61671 = ( abs( NormalWS ) - temp_cast_5 );
				float smoothstepResult3838_g61671 = smoothstep( 0.1 , 1.0 , ( break3837_g61671.z + 0.5 ));
				float ENABLE_RAIN363_g61671 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61671 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61671 );
				float Mask_Vertical_Z3918_g61671 = ( smoothstepResult3838_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3929_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_Z3918_g61671);
				float smoothstepResult3864_g61671 = smoothstep( 0.0 , 1.0 , ( break3837_g61671.x + 0.45 ));
				float Mask_Vertical_X3920_g61671 = ( smoothstepResult3864_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3930_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_X3920_g61671);
				float smoothstepResult3839_g61671 = smoothstep( 0.0 , 1.0 , ( -break3837_g61671.y + 0.45 ));
				float Mask_Vertical_Y3919_g61671 = ( smoothstepResult3839_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3931_g61671 = lerp( lerpResult3929_g61671 , ( lerpResult3929_g61671 + lerpResult3930_g61671 ) , Mask_Vertical_Y3919_g61671);
				float temp_output_1689_0_g61671 = ( lerpResult3931_g61671 * _RainDripIntensity );
				float3 lerpResult588_g61671 = lerp( temp_output_20_0_g61671 , normalizeResult3787_g61671 , temp_output_1689_0_g61671);
				float2 weightedBlendVar1635_g61671 = _Vector4;
				float3 weightedBlend1635_g61671 = ( weightedBlendVar1635_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1635_g61671.y*lerpResult588_g61671 );
				float ENABLE_DRIPS1644_g61671 = _ENABLEDRIPS;
				float3 lerpResult1640_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1635_g61671 , ENABLE_DRIPS1644_g61671);
				float2 temp_output_1355_0_g61671 = ( ( input.ase_texcoord3.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61671, ddx( temp_output_1355_0_g61671 ), ddy( temp_output_1355_0_g61671 ) );
				float4 appendResult3767_g61671 = (float4(1.0 , tex2DNode257_g61671.r , 0.0 , tex2DNode257_g61671.g));
				float3 unpack3768_g61671 = UnpackNormalScale( appendResult3767_g61671, _RainDropNormalScale );
				unpack3768_g61671.z = lerp( 1, unpack3768_g61671.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g61671 = ASESafeNormalize( unpack3768_g61671 );
				float temp_output_3696_0_g61671 = ( ( tex2DNode257_g61671.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61671 = ( frac( ( tex2DNode257_g61671.b - ( Time1591_g61671 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61671 ) );
				float lerpResult4471_g61671 = lerp( ( temp_output_1818_0_g61671 + saturate( -temp_output_3696_0_g61671 ) ) , temp_output_1818_0_g61671 , _RainDropStaticScale);
				float temp_output_3691_0_g61671 = ( lerpResult4471_g61671 * Global_Rain_Intensity1484_g61671 );
				float3 lerpResult1298_g61671 = lerp( normalizeResult3770_g61671 , temp_output_20_0_g61671 , (temp_output_3691_0_g61671*2.0 + -1.0));
				float2 weightedBlendVar1637_g61671 = _Vector4;
				float3 weightedBlend1637_g61671 = ( weightedBlendVar1637_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1637_g61671.y*lerpResult1298_g61671 );
				float ENABLE_DROPS1643_g61671 = _ENABLEDROPS;
				float3 lerpResult1641_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1637_g61671 , ENABLE_DROPS1643_g61671);
				float3 weightedBlendVar1305_g61671 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend1305_g61671 = ( weightedBlendVar1305_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1305_g61671.y*lerpResult1640_g61671 + weightedBlendVar1305_g61671.z*lerpResult1641_g61671 );
				float3 lerpResult2879_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1305_g61671 , Global_Rain_Intensity1484_g61671);
				float4 appendResult64_g61671 = (float4(PositionWS.x , PositionWS.z , PositionWS.x , PositionWS.z));
				float4 _Vector9 = float4(0.4,0.02,-0.1,0.4);
				float _WindDirection2282_g61671 = Wind_Direction2547_g61671;
				float2 localDirectionalEquation2282_g61671 = DirectionalEquation( _WindDirection2282_g61671 );
				float2 break2281_g61671 = localDirectionalEquation2282_g61671;
				float4 appendResult2278_g61671 = (float4(break2281_g61671.x , break2281_g61671.y , break2281_g61671.x , break2281_g61671.y));
				float4 temp_output_63_0_g61671 = ( ( appendResult64_g61671 * float4( 1.8,1.3,0.7,1.7 ) ) + ( ( Time1591_g61671 * _PuddleNormalSpeed ) * ( _Vector9 * appendResult2278_g61671 ) ) );
				float2 temp_output_1535_0_g61671 = (_RainPuddleNormal_ST).xy;
				float2 temp_output_1531_0_g61671 = (_RainPuddleNormal_ST).zw;
				float3 unpack44_g61671 = UnpackNormalScale( SAMPLE_TEXTURE2D( _RainPuddleNormal, sampler_RainPuddleNormal, ( ( (temp_output_63_0_g61671).xy * temp_output_1535_0_g61671 ) + temp_output_1531_0_g61671 ) ), _PuddleNormalStrength );
				unpack44_g61671.z = lerp( 1, unpack44_g61671.z, saturate(_PuddleNormalStrength) );
				float3 unpack70_g61671 = UnpackNormalScale( SAMPLE_TEXTURE2D( _RainPuddleNormal, sampler_RainPuddleNormal, ( ( (temp_output_63_0_g61671).zw * temp_output_1535_0_g61671 ) + temp_output_1531_0_g61671 ) ), _PuddleNormalStrength );
				unpack70_g61671.z = lerp( 1, unpack70_g61671.z, saturate(_PuddleNormalStrength) );
				float4 appendResult84_g61671 = (float4(PositionWS.x , PositionWS.z , PositionWS.x , PositionWS.z));
				float4 temp_output_81_0_g61671 = ( float4( 0.25,0.25,0.27,0.27 ) * ( float4( 0,0,-0.55,0.3 ) + appendResult84_g61671 ) );
				float2 temp_output_1413_0_g61671 = (_RainPuddleRipple_ST).xy;
				float2 temp_output_1417_0_g61671 = (_RainPuddleRipple_ST).zw;
				float4 tex2DNode627_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_81_0_g61671).xy * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult640_g61671 = (float2(tex2DNode627_g61671.r , tex2DNode627_g61671.g));
				float2 temp_cast_6 = (1.0).xx;
				float4 temp_cast_7 = (Global_Rain_Intensity1484_g61671).xxxx;
				float4 break764_g61671 = saturate( ( ( temp_cast_7 - float4( 0, 0.25, 0, 0.75 ) ) * float4( 4,4,4,4 ) ) );
				float temp_output_1611_0_g61671 = ( Time1591_g61671 * _PuddleRippleSpeed );
				float temp_output_637_0_g61671 = frac( ( tex2DNode627_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult633_g61671 = clamp( ( ( tex2DNode627_g61671.b + ( temp_output_637_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 break91_g61671 = ( saturate( ( ( temp_cast_7 - float4( 0, 0.25, 0, 0.75 ) ) * float4( 4,4,4,4 ) ) ) * _PuddleRippleStrength );
				float4 tex2DNode662_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_81_0_g61671).zw * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult675_g61671 = (float2(tex2DNode662_g61671.r , tex2DNode662_g61671.g));
				float2 temp_cast_8 = (1.0).xx;
				float temp_output_672_0_g61671 = frac( ( tex2DNode662_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult668_g61671 = clamp( ( ( tex2DNode662_g61671.b + ( temp_output_672_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 temp_output_80_0_g61671 = ( float4( 0.32,0.32,0.32,0.32 ) * ( appendResult84_g61671 + float4( 0.6,0.85,0.5,-0.75 ) ) );
				float4 tex2DNode693_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_80_0_g61671).xy * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult706_g61671 = (float2(tex2DNode693_g61671.r , tex2DNode693_g61671.g));
				float2 temp_cast_9 = (1.0).xx;
				float temp_output_703_0_g61671 = frac( ( tex2DNode693_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult699_g61671 = clamp( ( ( tex2DNode693_g61671.b + ( temp_output_703_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 tex2DNode724_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_80_0_g61671).zw * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult737_g61671 = (float2(tex2DNode724_g61671.r , tex2DNode724_g61671.g));
				float2 temp_cast_10 = (1.0).xx;
				float temp_output_734_0_g61671 = frac( ( tex2DNode724_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult730_g61671 = clamp( ( ( tex2DNode724_g61671.b + ( temp_output_734_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float2 break27_g61671 = ( ( ( ( ( ( ( appendResult640_g61671 * 2.0 ) - temp_cast_6 ) * ( ( tex2DNode627_g61671.b * saturate( ( ( break764_g61671.x + 2.0 ) - temp_output_637_0_g61671 ) ) ) * sin( ( clampResult633_g61671 * PI ) ) ) ) * break91_g61671.x ) + ( ( ( ( appendResult675_g61671 * 2.0 ) - temp_cast_8 ) * ( ( tex2DNode662_g61671.b * saturate( ( ( break764_g61671.y + 2.0 ) - temp_output_672_0_g61671 ) ) ) * sin( ( clampResult668_g61671 * PI ) ) ) ) * break91_g61671.y ) ) + ( ( ( ( appendResult706_g61671 * 2.0 ) - temp_cast_9 ) * ( ( tex2DNode693_g61671.b * saturate( ( ( break764_g61671.z + 2.0 ) - temp_output_703_0_g61671 ) ) ) * sin( ( clampResult699_g61671 * PI ) ) ) ) * break91_g61671.z ) ) + ( ( ( ( appendResult737_g61671 * 2.0 ) - temp_cast_10 ) * ( ( tex2DNode724_g61671.b * saturate( ( ( break764_g61671.w + 2.0 ) - temp_output_734_0_g61671 ) ) ) * sin( ( clampResult730_g61671 * PI ) ) ) ) * break91_g61671.w ) );
				float3 Normal1292_g61671 = temp_output_20_0_g61671;
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal25_g61671 = Normal1292_g61671;
				float3 worldNormal25_g61671 = normalize( float3( dot( tanToWorld0, tanNormal25_g61671 ), dot( tanToWorld1, tanNormal25_g61671 ), dot( tanToWorld2, tanNormal25_g61671 ) ) );
				float3 break2850_g61671 = worldNormal25_g61671;
				float3 appendResult24_g61671 = (float3(( break27_g61671.x + break2850_g61671.x ) , 1.0 , ( break27_g61671.y + break2850_g61671.z )));
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				float3 worldToTangentDir28_g61671 = ASESafeNormalize( mul( ase_worldToTangent, appendResult24_g61671 ) );
				float2 appendResult1393_g61671 = (float2(PositionWS.x , PositionWS.z));
				float4 tex2DNode30_g61671 = SAMPLE_TEXTURE2D( _RainPuddleMask, sampler_RainPuddleMask, ( ( appendResult1393_g61671 * (_RainPuddleMask_ST).xy ) + (_RainPuddleMask_ST).zw ) );
				float4 _Vector0 = float4(1E-05,0,0.4,0.2);
				float2 appendResult7_g61671 = (float2(_Vector0.x , _Vector0.y));
				float2 appendResult8_g61671 = (float2(_Vector0.z , _Vector0.w));
				float2 lerpResult9_g61671 = lerp( appendResult7_g61671 , appendResult8_g61671 , _PuddleSize);
				float2 break14_g61671 = lerpResult9_g61671;
				float saferPower17_g61671 = abs( saturate( ( ( ( saturate( ( _PuddleHeight * 10.0 ) ) * saturate(  (0.0 + ( tex2DNode30_g61671.r - 0.0 ) * ( ( ( saturate( ( _PuddleHeight + -0.1 ) ) * 50.0 ) + 1.0 ) - 0.0 ) / ( 1.0 - 0.0 ) ) ) ) * ( ( 1.0 - saturate( ( ( tex2DNode30_g61671.r - break14_g61671.y ) / break14_g61671.x ) ) ) * _PuddleSize ) ) * 5.0 ) ) );
				float Puddle1461_g61671 = pow( saferPower17_g61671 , 6.0 );
				float3 lerpResult19_g61671 = lerp( weightedBlend1305_g61671 , BlendNormal( BlendNormal( unpack44_g61671 , unpack70_g61671 ) , worldToTangentDir28_g61671 ) , Puddle1461_g61671);
				float saferPower462_g61671 = abs( saturate( NormalWS.y ) );
				float Mask_Puddle1482_g61671 = pow( saferPower462_g61671 , 80.0 );
				float3 lerpResult1478_g61671 = lerp( weightedBlend1305_g61671 , lerpResult19_g61671 , Mask_Puddle1482_g61671);
				float3 break2733_g61671 = Normal1292_g61671;
				float2 appendResult2740_g61671 = (float2(break2733_g61671.x , break2733_g61671.y));
				float2 break2735_g61671 = ( appendResult2740_g61671 * _PuddleNormalStrengthBase );
				float lerpResult2736_g61671 = lerp( 1.0 , max( break2733_g61671.z , 1.0 ) , _PuddleNormalStrengthBase);
				float3 appendResult2738_g61671 = (float3(break2735_g61671.x , break2735_g61671.y , lerpResult2736_g61671));
				float3 appendResult2822_g61671 = (float3(( (appendResult2738_g61671).xy + (lerpResult1478_g61671).xy ) , ( (appendResult2738_g61671).z * (lerpResult1478_g61671).z )));
				float3 normalizeResult2823_g61671 = ASESafeNormalize( appendResult2822_g61671 );
				float3 lerpResult2717_g61671 = lerp( lerpResult1478_g61671 , normalizeResult2823_g61671 , Puddle1461_g61671);
				float3 lerpResult3261_g61671 = lerp( temp_output_20_0_g61671 , lerpResult2717_g61671 , Global_Rain_Intensity1484_g61671);
				float3 lerpResult3277_g61671 = lerp( lerpResult2879_g61671 , lerpResult3261_g61671 , _PuddleIntensity);
				float3 lerpResult1381_g61671 = lerp( lerpResult2879_g61671 , lerpResult3277_g61671 , _ENABLEPUDDLE);
				float3 lerpResult790_g61671 = lerp( temp_output_20_0_g61671 , lerpResult1381_g61671 , ENABLE_RAIN363_g61671);
				

				float3 Normal = lerpResult790_g61671;
				float Alpha = 1;
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

			Blend One Zero, One Zero
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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT


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
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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
			TEXTURE2D(_MetallicGlossMap);
			TEXTURE2D(_RainPuddleMask);
			SAMPLER(sampler_RainPuddleMask);
			TEXTURE2D(_RainDripMask);
			TEXTURE2D(_RainDrip);
			SAMPLER(sampler_RainDrip);
			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_DetailNormalMap);
			SAMPLER(sampler_DetailNormalMap);
			TEXTURE2D(_RainPuddleNormal);
			SAMPLER(sampler_RainPuddleNormal);
			TEXTURE2D(_RainPuddleRipple);
			SAMPLER(sampler_RainPuddleRipple);
			TEXTURE2D(_OcclusionMap);
			TEXTURE2D(_EmissionMap);
			SAMPLER(sampler_EmissionMap);


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			float2 float2switchUVMode566_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode571_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float2 DirectionalEquation( float _WindDirection )
			{
				float d = _WindDirection * 0.0174532924;
				float xL = cos(d) + 1 / 2;
				float zL = sin(d) + 1 / 2;
				return float2(zL,xL);
			}
			
			float2 float2switchUVMode592_g60389( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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

			FragmentOutput frag ( PackedVaryings input
								#if defined( ASE_DEPTH_WRITE_ON )
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								 )
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

				float m_switch566_g60389 = _UVBase;
				float2 m_UV0566_g60389 = input.ase_texcoord6.xy;
				float2 m_UV1566_g60389 = input.ase_texcoord6.zw;
				float2 m_UV2566_g60389 = input.ase_texcoord7.xy;
				float2 m_UV3566_g60389 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode566_g60389 = float2switchUVMode566_g60389( m_switch566_g60389 , m_UV0566_g60389 , m_UV1566_g60389 , m_UV2566_g60389 , m_UV3566_g60389 );
				float2 appendResult772_g60389 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g60389 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g60389 = ( ( localfloat2switchUVMode566_g60389 * appendResult772_g60389 ) + appendResult773_g60389 );
				float4 temp_output_2_0_g61666 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_2444_0_g60389 = ( (temp_output_2_0_g61666).rgb * (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_COLOR + _CATEGORYSPACE_COLOR + _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) );
				float m_switch571_g60389 = _UVDetail;
				float2 m_UV0571_g60389 = input.ase_texcoord6.xy;
				float2 m_UV1571_g60389 = input.ase_texcoord6.zw;
				float2 m_UV2571_g60389 = input.ase_texcoord7.xy;
				float2 m_UV3571_g60389 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode571_g60389 = float2switchUVMode571_g60389( m_switch571_g60389 , m_UV0571_g60389 , m_UV1571_g60389 , m_UV2571_g60389 , m_UV3571_g60389 );
				float2 appendResult574_g60389 = (float2(_DetailAlbedoMap_ST.x , _DetailAlbedoMap_ST.y));
				float2 appendResult578_g60389 = (float2(_DetailAlbedoMap_ST.z , _DetailAlbedoMap_ST.w));
				float2 UV_DetailMap583_g60389 = ( ( localfloat2switchUVMode571_g60389 * appendResult574_g60389 ) + appendResult578_g60389 );
				float3 DetailMap2602_g60389 = (SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_BaseMap, UV_DetailMap583_g60389 )).rgb;
				float3 lerpResult3088_g60389 = lerp( DetailMap2602_g60389 , ( DetailMap2602_g60389 * (unity_ColorSpaceDouble).rgb ) , _DetailAlbedoMapScale);
				float DetailMask_A2207_g60389 = SAMPLE_TEXTURE2D( _DetailMask, sampler_DetailMask, UV_DetailMap583_g60389 ).a;
				float temp_output_2_0_g60393 = DetailMask_A2207_g60389;
				float temp_output_3_0_g60393 = ( 1.0 - temp_output_2_0_g60393 );
				float3 appendResult7_g60393 = (float3(temp_output_3_0_g60393 , temp_output_3_0_g60393 , temp_output_3_0_g60393));
				float3 lerpResult3662_g60389 = lerp( temp_output_2444_0_g60389 , ( temp_output_2444_0_g60389 * ( ( lerpResult3088_g60389 * temp_output_2_0_g60393 ) + appendResult7_g60393 ) ) , ( _DETAIL_MULX2 + ( ( _CATEGORY_DETAIL + _CATEGORYSPACE_DETAIL ) * 0.0 ) ));
				float3 temp_output_2628_0_g61671 = ( saturate( lerpResult3662_g60389 ) * 0.2 );
				float4 temp_output_2_0_g60390 = SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float3 temp_output_343_3092 = ( (temp_output_2_0_g60390).rgb * _Metallic );
				float temp_output_386_0_g61671 = ( 1.0 - saturate( max( temp_output_343_3092.x , ( ( ( 1.5 + 1.0 ) * ( ( 0.8 + 0.0 ) - 0.5 ) ) + 0.5 ) ) ) );
				float temp_output_2631_0_g61671 = saturate( max( temp_output_386_0_g61671 , min( _GlobalRainWetness , 0.94 ) ) );
				float3 lerpResult4144_g61671 = lerp( lerpResult3662_g60389 , temp_output_2628_0_g61671 , ( ( _GlobalRainWetness * 0.85 ) * temp_output_2631_0_g61671 ));
				float2 appendResult1393_g61671 = (float2(PositionWS.x , PositionWS.z));
				float4 tex2DNode30_g61671 = SAMPLE_TEXTURE2D( _RainPuddleMask, sampler_RainPuddleMask, ( ( appendResult1393_g61671 * (_RainPuddleMask_ST).xy ) + (_RainPuddleMask_ST).zw ) );
				float4 _Vector0 = float4(1E-05,0,0.4,0.2);
				float2 appendResult7_g61671 = (float2(_Vector0.x , _Vector0.y));
				float2 appendResult8_g61671 = (float2(_Vector0.z , _Vector0.w));
				float2 lerpResult9_g61671 = lerp( appendResult7_g61671 , appendResult8_g61671 , _PuddleSize);
				float2 break14_g61671 = lerpResult9_g61671;
				float saferPower17_g61671 = abs( saturate( ( ( ( saturate( ( _PuddleHeight * 10.0 ) ) * saturate(  (0.0 + ( tex2DNode30_g61671.r - 0.0 ) * ( ( ( saturate( ( _PuddleHeight + -0.1 ) ) * 50.0 ) + 1.0 ) - 0.0 ) / ( 1.0 - 0.0 ) ) ) ) * ( ( 1.0 - saturate( ( ( tex2DNode30_g61671.r - break14_g61671.y ) / break14_g61671.x ) ) ) * _PuddleSize ) ) * 5.0 ) ) );
				float Puddle1461_g61671 = pow( saferPower17_g61671 , 6.0 );
				float saferPower462_g61671 = abs( saturate( NormalWS.y ) );
				float Mask_Puddle1482_g61671 = pow( saferPower462_g61671 , 80.0 );
				float lerpResult4134_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float Puddle_Intensity3276_g61671 = _PuddleIntensity;
				float3 lerpResult305_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , ( ( 1.0 - ( temp_output_2631_0_g61671 * lerpResult4134_g61671 ) ) * ( Puddle_Intensity3276_g61671 + 0.25 ) ));
				float ENABLE_RAIN363_g61671 = ( _ENABLERAIN + ( ( _CATEGORY_RAIN + _CATEGORYSPACE_RAIN ) * 0.0 ) );
				float Global_Rain_Intensity1484_g61671 = ( _GlobalRainIntensity * ENABLE_RAIN363_g61671 );
				float3 lerpResult3545_g61671 = lerp( lerpResult3662_g60389 , lerpResult305_g61671 , Global_Rain_Intensity1484_g61671);
				float3 lerpResult3559_g61671 = lerp( temp_output_2628_0_g61671 , lerpResult3545_g61671 , _PuddleIntensity);
				float ENABLE_PUDDLE1379_g61671 = _ENABLEPUDDLE;
				float3 lerpResult3586_g61671 = lerp( temp_output_2628_0_g61671 , lerpResult3559_g61671 , ENABLE_PUDDLE1379_g61671);
				float Wind_Direction2547_g61671 = _GlobalRainWindDirection;
				float temp_output_4713_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 temp_output_183_0_g61671 = (PositionWS).yx;
				float2 lerpResult4672_g61671 = lerp( temp_output_183_0_g61671 , ( 1.0 - temp_output_183_0_g61671 ) , _RainDripMaskInvert);
				float2 break4707_g61671 = ( lerpResult4672_g61671 - float2( 0.5,0.5 ) );
				float temp_output_4712_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4717_g61671 = (float2(( ( temp_output_4713_0_g61671 * break4707_g61671.x ) + ( temp_output_4712_0_g61671 * break4707_g61671.y ) ) , ( ( temp_output_4713_0_g61671 * break4707_g61671.y ) - ( temp_output_4712_0_g61671 * break4707_g61671.x ) )));
				float Permeability387_g61671 = temp_output_386_0_g61671;
				float lerpResult193_g61671 = lerp( 0.2 , 0.03 , Permeability387_g61671);
				float lerpResult194_g61671 = lerp( 0.0 , 0.0125 , Permeability387_g61671);
				float temp_output_4405_0_g61671 = cos( Wind_Direction2547_g61671 );
				float2 _Anchor = float2(0.5,0.5);
				float2 break4413_g61671 = ( input.ase_texcoord6.xy - _Anchor );
				float temp_output_4406_0_g61671 = sin( Wind_Direction2547_g61671 );
				float2 appendResult4415_g61671 = (float2(( ( temp_output_4405_0_g61671 * break4413_g61671.x ) + ( temp_output_4406_0_g61671 * break4413_g61671.y ) ) , ( ( temp_output_4405_0_g61671 * break4413_g61671.y ) - ( temp_output_4406_0_g61671 * break4413_g61671.x ) )));
				float4 tex2DNode172_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrip, sampler_RainDrip, ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ), ddx( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ), ddy( ( ( ( appendResult4415_g61671 * (_RainDrip_ST).xy ) + _Anchor ) + (_RainDrip_ST).zw ) ) );
				float lerpResult185_g61671 = lerp( lerpResult193_g61671 , lerpResult194_g61671 , tex2DNode172_g61671.a);
				float Time1591_g61671 = _TimeParameters.x;
				float temp_output_186_0_g61671 = ( SAMPLE_TEXTURE2D( _RainDripMask, sampler_RainDrip, ( appendResult4717_g61671 + ( lerpResult185_g61671 * ( ( Time1591_g61671 * _RainDripSpeed ) + tex2DNode172_g61671.a ) ) ) ).r * tex2DNode172_g61671.b );
				float3 temp_cast_1 = (0.5).xxx;
				float3 break3837_g61671 = ( abs( NormalWS ) - temp_cast_1 );
				float smoothstepResult3838_g61671 = smoothstep( 0.1 , 1.0 , ( break3837_g61671.z + 0.5 ));
				float Mask_Vertical_Z3918_g61671 = ( smoothstepResult3838_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3929_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_Z3918_g61671);
				float smoothstepResult3864_g61671 = smoothstep( 0.0 , 1.0 , ( break3837_g61671.x + 0.45 ));
				float Mask_Vertical_X3920_g61671 = ( smoothstepResult3864_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3930_g61671 = lerp( 0.0001 , temp_output_186_0_g61671 , Mask_Vertical_X3920_g61671);
				float smoothstepResult3839_g61671 = smoothstep( 0.0 , 1.0 , ( -break3837_g61671.y + 0.45 ));
				float Mask_Vertical_Y3919_g61671 = ( smoothstepResult3839_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3931_g61671 = lerp( lerpResult3929_g61671 , ( lerpResult3929_g61671 + lerpResult3930_g61671 ) , Mask_Vertical_Y3919_g61671);
				float temp_output_1689_0_g61671 = ( lerpResult3931_g61671 * _RainDripIntensity );
				float lerpResult1663_g61671 = lerp( 0.0 , temp_output_1689_0_g61671 , _ENABLEDRIPS);
				float Drips3491_g61671 = saturate( lerpResult1663_g61671 );
				float3 lerpResult3462_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , saturate( ( temp_output_2631_0_g61671 * Drips3491_g61671 ) ));
				float3 lerpResult3546_g61671 = lerp( lerpResult3662_g60389 , lerpResult3462_g61671 , Global_Rain_Intensity1484_g61671);
				float2 temp_output_1355_0_g61671 = ( ( input.ase_texcoord6.xy * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g61671 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_1355_0_g61671, ddx( temp_output_1355_0_g61671 ), ddy( temp_output_1355_0_g61671 ) );
				float temp_output_3696_0_g61671 = ( ( tex2DNode257_g61671.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g61671 = ( frac( ( tex2DNode257_g61671.b - ( Time1591_g61671 * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g61671 ) );
				float lerpResult4471_g61671 = lerp( ( temp_output_1818_0_g61671 + saturate( -temp_output_3696_0_g61671 ) ) , temp_output_1818_0_g61671 , _RainDropStaticScale);
				float temp_output_3691_0_g61671 = ( lerpResult4471_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult1664_g61671 = lerp( 0.0 , (temp_output_3691_0_g61671*2.0 + -1.0) , _ENABLEDROPS);
				float Drops3492_g61671 = saturate( lerpResult1664_g61671 );
				float temp_output_3457_0_g61671 = saturate( ( temp_output_2631_0_g61671 * Drops3492_g61671 ) );
				float lerpResult4141_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float lerpResult4102_g61671 = lerp( temp_output_3457_0_g61671 , saturate( temp_output_2631_0_g61671 ) , lerpResult4141_g61671);
				float lerpResult4126_g61671 = lerp( temp_output_3457_0_g61671 , lerpResult4102_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult4100_g61671 = lerp( temp_output_3457_0_g61671 , lerpResult4126_g61671 , ENABLE_PUDDLE1379_g61671);
				float3 lerpResult3399_g61671 = lerp( lerpResult4144_g61671 , temp_output_2628_0_g61671 , lerpResult4100_g61671);
				float3 lerpResult3547_g61671 = lerp( lerpResult3662_g60389 , lerpResult3399_g61671 , Global_Rain_Intensity1484_g61671);
				float3 weightedBlendVar3481_g61671 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend3481_g61671 = ( weightedBlendVar3481_g61671.x*lerpResult3586_g61671 + weightedBlendVar3481_g61671.y*lerpResult3546_g61671 + weightedBlendVar3481_g61671.z*lerpResult3547_g61671 );
				float3 lerpResult799_g61671 = lerp( lerpResult3662_g60389 , weightedBlend3481_g61671 , ENABLE_RAIN363_g61671);
				
				float3 unpack268_g60389 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV_BaseMap2637_g60389 ), _BumpScale );
				unpack268_g60389.z = lerp( 1, unpack268_g60389.z, saturate(_BumpScale) );
				float3 unpack311_g60389 = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_DetailNormalMap, UV_DetailMap583_g60389 ), _DetailNormalMapScale );
				unpack311_g60389.z = lerp( 1, unpack311_g60389.z, saturate(_DetailNormalMapScale) );
				float2 weightedBlendVar3825_g60389 = float2( 0.5,0.5 );
				float3 weightedBlend3825_g60389 = ( weightedBlendVar3825_g60389.x*unpack268_g60389 + weightedBlendVar3825_g60389.y*unpack311_g60389 );
				float3 lerpResult2330_g60389 = lerp( unpack268_g60389 , weightedBlend3825_g60389 , DetailMask_A2207_g60389);
				float ENABLE_DETAIL3658_g60389 = _DETAIL_MULX2;
				float3 lerpResult3665_g60389 = lerp( unpack268_g60389 , lerpResult2330_g60389 , ENABLE_DETAIL3658_g60389);
				float3 temp_output_20_0_g61671 = lerpResult3665_g60389;
				float2 _Vector4 = float2(1,1);
				float4 appendResult3784_g61671 = (float4(1.0 , tex2DNode172_g61671.r , 0.0 , tex2DNode172_g61671.g));
				float3 unpack3786_g61671 = UnpackNormalScale( appendResult3784_g61671, _RainDripNormalScale );
				unpack3786_g61671.z = lerp( 1, unpack3786_g61671.z, saturate(_RainDripNormalScale) );
				float3 normalizeResult3787_g61671 = ASESafeNormalize( unpack3786_g61671 );
				float3 lerpResult588_g61671 = lerp( temp_output_20_0_g61671 , normalizeResult3787_g61671 , temp_output_1689_0_g61671);
				float2 weightedBlendVar1635_g61671 = _Vector4;
				float3 weightedBlend1635_g61671 = ( weightedBlendVar1635_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1635_g61671.y*lerpResult588_g61671 );
				float ENABLE_DRIPS1644_g61671 = _ENABLEDRIPS;
				float3 lerpResult1640_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1635_g61671 , ENABLE_DRIPS1644_g61671);
				float4 appendResult3767_g61671 = (float4(1.0 , tex2DNode257_g61671.r , 0.0 , tex2DNode257_g61671.g));
				float3 unpack3768_g61671 = UnpackNormalScale( appendResult3767_g61671, _RainDropNormalScale );
				unpack3768_g61671.z = lerp( 1, unpack3768_g61671.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g61671 = ASESafeNormalize( unpack3768_g61671 );
				float3 lerpResult1298_g61671 = lerp( normalizeResult3770_g61671 , temp_output_20_0_g61671 , (temp_output_3691_0_g61671*2.0 + -1.0));
				float2 weightedBlendVar1637_g61671 = _Vector4;
				float3 weightedBlend1637_g61671 = ( weightedBlendVar1637_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1637_g61671.y*lerpResult1298_g61671 );
				float ENABLE_DROPS1643_g61671 = _ENABLEDROPS;
				float3 lerpResult1641_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1637_g61671 , ENABLE_DROPS1643_g61671);
				float3 weightedBlendVar1305_g61671 = float3( 0.5, 0.5, 0.5 );
				float3 weightedBlend1305_g61671 = ( weightedBlendVar1305_g61671.x*temp_output_20_0_g61671 + weightedBlendVar1305_g61671.y*lerpResult1640_g61671 + weightedBlendVar1305_g61671.z*lerpResult1641_g61671 );
				float3 lerpResult2879_g61671 = lerp( temp_output_20_0_g61671 , weightedBlend1305_g61671 , Global_Rain_Intensity1484_g61671);
				float4 appendResult64_g61671 = (float4(PositionWS.x , PositionWS.z , PositionWS.x , PositionWS.z));
				float4 _Vector9 = float4(0.4,0.02,-0.1,0.4);
				float _WindDirection2282_g61671 = Wind_Direction2547_g61671;
				float2 localDirectionalEquation2282_g61671 = DirectionalEquation( _WindDirection2282_g61671 );
				float2 break2281_g61671 = localDirectionalEquation2282_g61671;
				float4 appendResult2278_g61671 = (float4(break2281_g61671.x , break2281_g61671.y , break2281_g61671.x , break2281_g61671.y));
				float4 temp_output_63_0_g61671 = ( ( appendResult64_g61671 * float4( 1.8,1.3,0.7,1.7 ) ) + ( ( Time1591_g61671 * _PuddleNormalSpeed ) * ( _Vector9 * appendResult2278_g61671 ) ) );
				float2 temp_output_1535_0_g61671 = (_RainPuddleNormal_ST).xy;
				float2 temp_output_1531_0_g61671 = (_RainPuddleNormal_ST).zw;
				float3 unpack44_g61671 = UnpackNormalScale( SAMPLE_TEXTURE2D( _RainPuddleNormal, sampler_RainPuddleNormal, ( ( (temp_output_63_0_g61671).xy * temp_output_1535_0_g61671 ) + temp_output_1531_0_g61671 ) ), _PuddleNormalStrength );
				unpack44_g61671.z = lerp( 1, unpack44_g61671.z, saturate(_PuddleNormalStrength) );
				float3 unpack70_g61671 = UnpackNormalScale( SAMPLE_TEXTURE2D( _RainPuddleNormal, sampler_RainPuddleNormal, ( ( (temp_output_63_0_g61671).zw * temp_output_1535_0_g61671 ) + temp_output_1531_0_g61671 ) ), _PuddleNormalStrength );
				unpack70_g61671.z = lerp( 1, unpack70_g61671.z, saturate(_PuddleNormalStrength) );
				float4 appendResult84_g61671 = (float4(PositionWS.x , PositionWS.z , PositionWS.x , PositionWS.z));
				float4 temp_output_81_0_g61671 = ( float4( 0.25,0.25,0.27,0.27 ) * ( float4( 0,0,-0.55,0.3 ) + appendResult84_g61671 ) );
				float2 temp_output_1413_0_g61671 = (_RainPuddleRipple_ST).xy;
				float2 temp_output_1417_0_g61671 = (_RainPuddleRipple_ST).zw;
				float4 tex2DNode627_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_81_0_g61671).xy * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult640_g61671 = (float2(tex2DNode627_g61671.r , tex2DNode627_g61671.g));
				float2 temp_cast_6 = (1.0).xx;
				float4 temp_cast_7 = (Global_Rain_Intensity1484_g61671).xxxx;
				float4 break764_g61671 = saturate( ( ( temp_cast_7 - float4( 0, 0.25, 0, 0.75 ) ) * float4( 4,4,4,4 ) ) );
				float temp_output_1611_0_g61671 = ( Time1591_g61671 * _PuddleRippleSpeed );
				float temp_output_637_0_g61671 = frac( ( tex2DNode627_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult633_g61671 = clamp( ( ( tex2DNode627_g61671.b + ( temp_output_637_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 break91_g61671 = ( saturate( ( ( temp_cast_7 - float4( 0, 0.25, 0, 0.75 ) ) * float4( 4,4,4,4 ) ) ) * _PuddleRippleStrength );
				float4 tex2DNode662_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_81_0_g61671).zw * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult675_g61671 = (float2(tex2DNode662_g61671.r , tex2DNode662_g61671.g));
				float2 temp_cast_8 = (1.0).xx;
				float temp_output_672_0_g61671 = frac( ( tex2DNode662_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult668_g61671 = clamp( ( ( tex2DNode662_g61671.b + ( temp_output_672_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 temp_output_80_0_g61671 = ( float4( 0.32,0.32,0.32,0.32 ) * ( appendResult84_g61671 + float4( 0.6,0.85,0.5,-0.75 ) ) );
				float4 tex2DNode693_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_80_0_g61671).xy * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult706_g61671 = (float2(tex2DNode693_g61671.r , tex2DNode693_g61671.g));
				float2 temp_cast_9 = (1.0).xx;
				float temp_output_703_0_g61671 = frac( ( tex2DNode693_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult699_g61671 = clamp( ( ( tex2DNode693_g61671.b + ( temp_output_703_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float4 tex2DNode724_g61671 = SAMPLE_TEXTURE2D( _RainPuddleRipple, sampler_RainPuddleRipple, ( ( (temp_output_80_0_g61671).zw * temp_output_1413_0_g61671 ) + temp_output_1417_0_g61671 ) );
				float2 appendResult737_g61671 = (float2(tex2DNode724_g61671.r , tex2DNode724_g61671.g));
				float2 temp_cast_10 = (1.0).xx;
				float temp_output_734_0_g61671 = frac( ( tex2DNode724_g61671.a + temp_output_1611_0_g61671 ) );
				float clampResult730_g61671 = clamp( ( ( tex2DNode724_g61671.b + ( temp_output_734_0_g61671 - 1.0 ) ) * 16.0 ) , 0.0 , 3.0 );
				float2 break27_g61671 = ( ( ( ( ( ( ( appendResult640_g61671 * 2.0 ) - temp_cast_6 ) * ( ( tex2DNode627_g61671.b * saturate( ( ( break764_g61671.x + 2.0 ) - temp_output_637_0_g61671 ) ) ) * sin( ( clampResult633_g61671 * PI ) ) ) ) * break91_g61671.x ) + ( ( ( ( appendResult675_g61671 * 2.0 ) - temp_cast_8 ) * ( ( tex2DNode662_g61671.b * saturate( ( ( break764_g61671.y + 2.0 ) - temp_output_672_0_g61671 ) ) ) * sin( ( clampResult668_g61671 * PI ) ) ) ) * break91_g61671.y ) ) + ( ( ( ( appendResult706_g61671 * 2.0 ) - temp_cast_9 ) * ( ( tex2DNode693_g61671.b * saturate( ( ( break764_g61671.z + 2.0 ) - temp_output_703_0_g61671 ) ) ) * sin( ( clampResult699_g61671 * PI ) ) ) ) * break91_g61671.z ) ) + ( ( ( ( appendResult737_g61671 * 2.0 ) - temp_cast_10 ) * ( ( tex2DNode724_g61671.b * saturate( ( ( break764_g61671.w + 2.0 ) - temp_output_734_0_g61671 ) ) ) * sin( ( clampResult730_g61671 * PI ) ) ) ) * break91_g61671.w ) );
				float3 Normal1292_g61671 = temp_output_20_0_g61671;
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal25_g61671 = Normal1292_g61671;
				float3 worldNormal25_g61671 = normalize( float3( dot( tanToWorld0, tanNormal25_g61671 ), dot( tanToWorld1, tanNormal25_g61671 ), dot( tanToWorld2, tanNormal25_g61671 ) ) );
				float3 break2850_g61671 = worldNormal25_g61671;
				float3 appendResult24_g61671 = (float3(( break27_g61671.x + break2850_g61671.x ) , 1.0 , ( break27_g61671.y + break2850_g61671.z )));
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				float3 worldToTangentDir28_g61671 = ASESafeNormalize( mul( ase_worldToTangent, appendResult24_g61671 ) );
				float3 lerpResult19_g61671 = lerp( weightedBlend1305_g61671 , BlendNormal( BlendNormal( unpack44_g61671 , unpack70_g61671 ) , worldToTangentDir28_g61671 ) , Puddle1461_g61671);
				float3 lerpResult1478_g61671 = lerp( weightedBlend1305_g61671 , lerpResult19_g61671 , Mask_Puddle1482_g61671);
				float3 break2733_g61671 = Normal1292_g61671;
				float2 appendResult2740_g61671 = (float2(break2733_g61671.x , break2733_g61671.y));
				float2 break2735_g61671 = ( appendResult2740_g61671 * _PuddleNormalStrengthBase );
				float lerpResult2736_g61671 = lerp( 1.0 , max( break2733_g61671.z , 1.0 ) , _PuddleNormalStrengthBase);
				float3 appendResult2738_g61671 = (float3(break2735_g61671.x , break2735_g61671.y , lerpResult2736_g61671));
				float3 appendResult2822_g61671 = (float3(( (appendResult2738_g61671).xy + (lerpResult1478_g61671).xy ) , ( (appendResult2738_g61671).z * (lerpResult1478_g61671).z )));
				float3 normalizeResult2823_g61671 = ASESafeNormalize( appendResult2822_g61671 );
				float3 lerpResult2717_g61671 = lerp( lerpResult1478_g61671 , normalizeResult2823_g61671 , Puddle1461_g61671);
				float3 lerpResult3261_g61671 = lerp( temp_output_20_0_g61671 , lerpResult2717_g61671 , Global_Rain_Intensity1484_g61671);
				float3 lerpResult3277_g61671 = lerp( lerpResult2879_g61671 , lerpResult3261_g61671 , _PuddleIntensity);
				float3 lerpResult1381_g61671 = lerp( lerpResult2879_g61671 , lerpResult3277_g61671 , _ENABLEPUDDLE);
				float3 lerpResult790_g61671 = lerp( temp_output_20_0_g61671 , lerpResult1381_g61671 , ENABLE_RAIN363_g61671);
				
				float Alpha_MetallicGlossMap635_g60389 = (temp_output_2_0_g60390).a;
				float temp_output_3172_0_g60389 = ( (temp_output_2_0_g61666).a * 1.0 );
				float Alpha_BaseColor2431_g60389 = temp_output_3172_0_g60389;
				float lerpResult3626_g60389 = lerp( Alpha_MetallicGlossMap635_g60389 , Alpha_BaseColor2431_g60389 , _SmoothnesstexturechannelM);
				float lerpResult3624_g60389 = lerp( _GlossMapScale , _Glossiness , _SmoothnesstexturechannelM);
				float lerpResult4136_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float lerpResult1861_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , _PuddleSmoothness , lerpResult4136_g61671);
				float lerpResult307_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult1861_g61671 , Puddle1461_g61671);
				float lerpResult1857_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult307_g61671 , ENABLE_PUDDLE1379_g61671);
				float lerpResult3218_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult1857_g61671 , Global_Rain_Intensity1484_g61671);
				float lerpResult3285_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3218_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult3582_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3285_g61671 , ENABLE_PUDDLE1379_g61671);
				float MaskDrips3024_g61671 = temp_output_1689_0_g61671;
				float saferPower3000_g61671 = abs( MaskDrips3024_g61671 );
				float lerpResult2986_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , _RainDripSmoothness , round( pow( saferPower3000_g61671 , 0.1 ) ));
				float lerpResult3013_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult2986_g61671 , Drips3491_g61671);
				float lerpResult3016_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3013_g61671 , ENABLE_DRIPS1644_g61671);
				float lerpResult3253_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3016_g61671 , Global_Rain_Intensity1484_g61671);
				float smoothstepResult3849_g61671 = smoothstep( 0.0 , 1.0 , ( NormalWS.y + 0.02 ));
				float Mask_Horizontal1481_g61671 = ( smoothstepResult3849_g61671 * Global_Rain_Intensity1484_g61671 );
				float lerpResult3963_g61671 = lerp( 0.0001 , temp_output_3691_0_g61671 , Mask_Vertical_Z3918_g61671);
				float lerpResult3962_g61671 = lerp( 0.0001 , temp_output_3691_0_g61671 , Mask_Vertical_X3920_g61671);
				float lerpResult3964_g61671 = lerp( lerpResult3963_g61671 , ( lerpResult3963_g61671 + lerpResult3962_g61671 ) , Mask_Vertical_Y3919_g61671);
				float MaskDrops1847_g61671 = (( ( temp_output_3691_0_g61671 * Mask_Horizontal1481_g61671 ) + lerpResult3964_g61671 )*2.0 + -1.0);
				float saferPower1848_g61671 = abs( MaskDrops1847_g61671 );
				float lerpResult2673_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , _RainDropSmoothness , pow( saferPower1848_g61671 , 1E-05 ));
				float lerpResult2949_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult2673_g61671 , Drops3492_g61671);
				float lerpResult2649_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult2949_g61671 , ENABLE_DROPS1643_g61671);
				float lerpResult1853_g61671 = lerp( lerpResult2649_g61671 , lerpResult1857_g61671 , ( Puddle1461_g61671 * Puddle1461_g61671 ));
				float lerpResult3296_g61671 = lerp( lerpResult2649_g61671 , lerpResult1853_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult3538_g61671 = lerp( lerpResult2649_g61671 , lerpResult3296_g61671 , ENABLE_PUDDLE1379_g61671);
				float lerpResult2869_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , lerpResult3538_g61671 , Global_Rain_Intensity1484_g61671);
				float3 weightedBlendVar3316_g61671 = float3( 0.5, 0.5, 0.5 );
				float weightedBlend3316_g61671 = ( weightedBlendVar3316_g61671.x*lerpResult3582_g61671 + weightedBlendVar3316_g61671.y*lerpResult3253_g61671 + weightedBlendVar3316_g61671.z*lerpResult2869_g61671 );
				float lerpResult801_g61671 = lerp( ( lerpResult3626_g60389 * lerpResult3624_g60389 ) , weightedBlend3316_g61671 , ENABLE_RAIN363_g61671);
				
				float4 tex2DNode610_g60389 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_BaseMap, UV_BaseMap2637_g60389 );
				float lerpResult4139_g61671 = lerp( 0.0 , Puddle1461_g61671 , Mask_Puddle1482_g61671);
				float lerpResult3811_g61671 = lerp( ( Drips3491_g61671 + Drops3492_g61671 ) , ( 1.0 - _PuddleAmbientOcclusion ) , lerpResult4139_g61671);
				float lerpResult3816_g61671 = lerp( ( Drips3491_g61671 + Drops3492_g61671 ) , lerpResult3811_g61671 , Puddle_Intensity3276_g61671);
				float lerpResult3819_g61671 = lerp( ( Drips3491_g61671 + Drops3492_g61671 ) , lerpResult3816_g61671 , ENABLE_PUDDLE1379_g61671);
				float lerpResult308_g61671 = lerp( saturate( ( tex2DNode610_g60389.r * ( 1.0 - _OcclusionStrength ) ) ) , 0.5 , lerpResult3819_g61671);
				float lerpResult2871_g61671 = lerp( saturate( ( tex2DNode610_g60389.r * ( 1.0 - _OcclusionStrength ) ) ) , lerpResult308_g61671 , Global_Rain_Intensity1484_g61671);
				float lerpResult802_g61671 = lerp( saturate( ( tex2DNode610_g60389.r * ( 1.0 - _OcclusionStrength ) ) ) , lerpResult2871_g61671 , ENABLE_RAIN363_g61671);
				
				half3 color3067_g60389 = IsGammaSpace() ? half3( 0.003921569, 0, 0 ) : half3( 0.000303527, 0, 0 );
				float m_switch592_g60389 = _UVEmissive;
				float2 m_UV0592_g60389 = input.ase_texcoord6.xy;
				float2 m_UV1592_g60389 = input.ase_texcoord6.zw;
				float2 m_UV2592_g60389 = input.ase_texcoord7.xy;
				float2 m_UV3592_g60389 = input.ase_texcoord7.zw;
				float2 localfloat2switchUVMode592_g60389 = float2switchUVMode592_g60389( m_switch592_g60389 , m_UV0592_g60389 , m_UV1592_g60389 , m_UV2592_g60389 , m_UV3592_g60389 );
				float2 appendResult593_g60389 = (float2(_EmissionMap_ST.x , _EmissionMap_ST.y));
				float2 appendResult595_g60389 = (float2(_EmissionMap_ST.z , _EmissionMap_ST.w));
				float2 UV_EmissiveMap597_g60389 = ( ( localfloat2switchUVMode592_g60389 * appendResult593_g60389 ) + appendResult595_g60389 );
				float3 lerpResult3649_g60389 = lerp( color3067_g60389 , ( (SAMPLE_TEXTURE2D( _EmissionMap, sampler_EmissionMap, UV_EmissiveMap597_g60389 )).rgb * ( (_EmissionColor).rgb * ( _EmissiveIntensity + ( _EmissionFlags * 0.0 ) ) ) ) , ( _EnableEmission + ( ( _CATEGORY_EMISSION + _CATEGORYSPACE_EMISSION ) * 0.0 ) ));
				

				float3 BaseColor = lerpResult799_g61671;
				float3 Normal = lerpResult790_g61671;
				float3 Specular = 0.5;
				float Metallic = temp_output_343_3092.x;
				float Smoothness = lerpResult801_g61671;
				float Occlusion = lerpResult802_g61671;
				float3 Emission = lerpResult3649_g60389;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
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
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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

				

				surfaceDescription.Alpha = 1;
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
			float4 _RainDrop_ST;
			float4 _RainPuddleMask_ST;
			float4 _ClearCoatMap_ST;
			float4 _DetailAlbedoMap_ST;
			float4 _RainDrip_ST;
			float4 _RainPuddleNormal_ST;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _RainPuddleRipple_ST;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _SmoothnesstexturechannelM;
			float _PuddleNormalStrengthBase;
			float _PuddleRippleStrength;
			float _PuddleNormalStrength;
			float _GlossMapScale;
			float _PuddleNormalSpeed;
			float _RainDropNormalScale;
			float _RainDripNormalScale;
			float _DetailNormalMapScale;
			float _PuddleRippleSpeed;
			float _Glossiness;
			float _RainDropSmoothness;
			float _RainDripSmoothness;
			float _BumpScale;
			float _OcclusionStrength;
			float _PuddleAmbientOcclusion;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			half _ClearCoatUVMapping;
			float _ClearCoatMask;
			half _ClearCoat;
			float _CATEGORY_COATMASK;
			float _PuddleSmoothness;
			float _ENABLEDROPS;
			float _CATEGORY_SURFACESETTINGS;
			float _RainDropSpeed;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_RAIN;
			float _CATEGORY_RAIN;
			float _CATEGORYSPACE_RAINMASK;
			float _CATEGORY_RAINMASK;
			float _UVBase;
			half _Brightness;
			float _CATEGORY_COLOR;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _UVDetail;
			float _DetailAlbedoMapScale;
			float _DETAIL_MULX2;
			float _CATEGORY_DETAIL;
			float _CATEGORYSPACE_DETAIL;
			float _CATEGORYSPACE_COATMASK;
			float _ENABLEDRIPS;
			float _RainDripIntensity;
			float _RainDripSpeed;
			float _RainDripMaskInvert;
			float _GlobalRainWindDirection;
			float _RainDropStaticScale;
			float _ENABLEPUDDLE;
			float _GlobalRainIntensity;
			float _PuddleIntensity;
			float _PuddleSize;
			half _PuddleHeight;
			float _Metallic;
			float _GlobalRainWetness;
			float _ENABLERAIN;
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

				

				surfaceDescription.Alpha = 1;
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
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;427;0,-192;Inherit;False;370.7075;302.6782;SURFACE SETTINGS;3;425;426;103;;0,0,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;-832,128;Inherit;False;LS Core Lit URP;3;;60389;53876622fa774744d8149dc81e17dda6;6,3095,0,3046,1,3050,1,3109,1,3116,0,3772,0;0;12;FLOAT3;3010;FLOAT3;3011;FLOAT3;3009;FLOAT3;3012;FLOAT3;3092;FLOAT;3015;FLOAT;3014;FLOAT;3013;FLOAT;3016;FLOAT;3032;FLOAT3;3856;FLOAT3;3857
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;426;32,-144;Inherit;False;Property;_CATEGORY_SURFACESETTINGS;CATEGORY_SURFACE SETTINGS;0;0;Create;True;0;0;0;True;1;LS_DrawerCategory(SURFACE SETTINGS,true,_Cull,0,0);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;425;32,16;Inherit;False;Property;_SPACE_SURFACESETTINGS;SPACE_SURFACE SETTINGS;2;0;Create;True;0;0;0;True;1;LS_DrawerCategorySpace(10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;103;32,-64;Inherit;False;Property;_Cull;Render Face;1;1;[Enum];Create;False;1;;0;1;Front,2,Back,1,Both,0;True;0;False;2;0;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;545;-480,16;Inherit;False;LS Weather Rain;83;;61671;459598b18c271444bb1ee555b88e658e;23,2921,1,2916,1,2944,1,4770,0,3020,1,2920,1,2217,1,3500,1,4474,1,2702,1,3815,1,811,1,2222,1,4101,1,2557,1,4722,1,2546,1,4584,0,4575,0,4576,0,4574,0,4586,0,4583,0;5;314;FLOAT3;0.5,0.5,0.5;False;20;FLOAT3;0,0,1;False;380;FLOAT;1;False;306;FLOAT;0.5;False;313;FLOAT;0.5;False;5;FLOAT3;315;FLOAT3;41;FLOAT;317;FLOAT;316;FLOAT;3826
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;428;-320,288;Inherit;False;LS URP Clear Coat;74;;61674;8a05b92f6be02ee4992379fade361e90;0;0;2;FLOAT;3744;FLOAT;3743
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;145;0,128;Float;False;True;-1;2;LS_ShaderGUI;0;12;LS/Weather/Rain;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_Cull;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForwardOnly;False;False;0;;0;0;Standard;45;Lighting Model;0;0;Workflow;1;638728375952181647;Surface;0;638691912861869887;  Refraction Model;0;0;  Blend;0;0;Two Sided;1;0;Alpha Clipping;0;638728376180229004;  Use Shadow Threshold;0;638703485322137222;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;1;0;Transmission;0;638728375827248961;  Transmission Shadow;0.5,True,_ASETransmissionShadow;638709971722742780;Translucency;0;638728375835930477;  Translucency Strength;1,True,_ASETranslucencyStrength;638709971765784237;  Normal Distortion;0.5,True,_ASETranslucencyNormalDistortion;638709971808374177;  Scattering;2,True,_ASETranslucencyScattering;638709971864493599;  Direct;0.9,True,_ASETranslucencyDirect;638709971895433110;  Ambient;0.1,True,_ASETranslucencyAmbient;638709971929436255;  Shadow;0.5,True,_ASETranslucencyShadow;638709971967448480;Cast Shadows;1;0;Receive Shadows;1;0;Receive SSAO;1;0;Specular Highlights;1;0;Environment Reflections;1;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,True,_TessellationPhong;0;  Type;0;0;  Tess;16,True,_TessellationStrength;0;  Min;10,True,_TessellationDistanceMin;0;  Max;25,True,_TessellationDistanceMax;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;0;0;Clear Coat;1;638709964944237641;0;10;False;True;True;True;True;True;True;True;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;146;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;147;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;True;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;148;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;149;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;150;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;151;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;152;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;153;0,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;144;-144,128;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
WireConnection;545;314;343;3010
WireConnection;545;20;343;3011
WireConnection;545;380;343;3092
WireConnection;545;306;343;3015
WireConnection;545;313;343;3014
WireConnection;145;0;545;315
WireConnection;145;1;545;41
WireConnection;145;3;343;3092
WireConnection;145;4;545;317
WireConnection;145;5;545;316
WireConnection;145;2;343;3009
WireConnection;145;18;428;3744
WireConnection;145;20;428;3743
ASEEND*/
//CHKSM=99C25B5976D32A9CD2333859054F2AA2B45FC330