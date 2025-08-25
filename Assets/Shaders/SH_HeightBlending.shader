// Made with Amplify Shader Editor v1.9.9.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_HeightBlending"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		_BaseColorBase( "BaseColor Base", 2D ) = "white" {}
		_NormalBase( "Normal Base", 2D ) = "bump" {}
		_HeightBase( "Height Base", 2D ) = "white" {}
		_BaseColorR( "BaseColor R", 2D ) = "white" {}
		_HeightR( "Height R", 2D ) = "white" {}
		_NormalR( "Normal R", 2D ) = "bump" {}
		_BaseColorG( "BaseColor G", 2D ) = "white" {}
		_NormalG( "Normal G", 2D ) = "bump" {}
		_HeightG( "Height G", 2D ) = "white" {}
		_BaseColorB( "BaseColor B", 2D ) = "white" {}
		_NormalB( "Normal B", 2D ) = "bump" {}
		_HeightB( "Height B", 2D ) = "white" {}
		_Smoothness( "Smoothness", Range( 0, 1 ) ) = 0
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_RContrast( "R Contrast", Range( 0, 1 ) ) = 0
		_GContrast( "G Contrast", Range( 0, 1 ) ) = 0
		_BContrast( "B Contrast", Range( 0, 1 ) ) = 0
		_GlobalMeshHeight( "Global Mesh Height", Range( 0, 1 ) ) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 16
		_TessMin( "Tess Min Distance", Float ) = 10
		_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		//_InstancedTerrainNormals("Instanced Terrain Normals", Float) = 1.0

		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0
		[ToggleUI] _ReceiveShadows("Receive Shadows", Float) = 1.0

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

		Cull Back
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

			

			#define ASE_GEOMETRY 1
			#pragma multi_compile_local_fragment _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma shader_feature_local_fragment _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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

			#if defined(UNITY_INSTANCING_ENABLED) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR


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
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 lightmapUVOrVertexSH : TEXCOORD3;
				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					half4 fogFactorAndVertexLight : TEXCOORD4;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD5;
				#endif
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);
			TEXTURE2D(_BaseColorBase);
			SAMPLER(sampler_Linear_Repeat);
			TEXTURE2D(_BaseColorR);
			TEXTURE2D(_BaseColorG);
			TEXTURE2D(_BaseColorB);
			TEXTURE2D(_NormalBase);
			SAMPLER(sampler_NormalBase);
			TEXTURE2D(_NormalR);
			SAMPLER(sampler_NormalR);
			TEXTURE2D(_NormalG);
			SAMPLER(sampler_NormalG);
			TEXTURE2D(_NormalB);
			SAMPLER(sampler_NormalB);


			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_HeightBase = input.texcoord.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.texcoord.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.texcoord.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.texcoord.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				
				output.ase_texcoord6.xy = input.texcoord.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord6.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );

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

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = input.texcoord.xy;
					output.tangentWS.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
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
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

				#if defined( _SURFACE_TYPE_TRANSPARENT )
					const bool isTransparent = true;
				#else
					const bool isTransparent = false;
				#endif

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

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (input.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					BitangentWS = cross(NormalWS, -TangentWS);
				#endif

				float2 uv_BaseColorBase = input.ase_texcoord6.xy * _BaseColorBase_ST.xy + _BaseColorBase_ST.zw;
				float2 uv_BaseColorR = input.ase_texcoord6.xy * _BaseColorR_ST.xy + _BaseColorR_ST.zw;
				float2 uv_HeightR = input.ase_texcoord6.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D( _HeightR, sampler_HeightR, uv_HeightR );
				float temp_output_1_0_g110 = tex2DNode94.r;
				float2 uv_HeightBase = input.ase_texcoord6.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D( _HeightBase, sampler_HeightBase, uv_HeightBase );
				float temp_output_6_0_g110 = tex2DNode92.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g110 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g110 - temp_output_6_0_g110 ) + (Vertex_Colors53_g110).r )).xxxx;
				float temp_output_30_0_g110 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float3 lerpResult28_g110 = lerp( SAMPLE_TEXTURE2D( _BaseColorBase, sampler_Linear_Repeat, uv_BaseColorBase ).rgb , SAMPLE_TEXTURE2D( _BaseColorR, sampler_Linear_Repeat, uv_BaseColorR ).rgb , temp_output_30_0_g110);
				float2 uv_BaseColorG = input.ase_texcoord6.xy * _BaseColorG_ST.xy + _BaseColorG_ST.zw;
				float2 uv_HeightG = input.ase_texcoord6.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D( _HeightG, sampler_HeightG, uv_HeightG );
				float temp_output_58_0_g110 = tex2DNode132.r;
				float lerpResult73_g110 = lerp( temp_output_6_0_g110 , temp_output_1_0_g110 , temp_output_30_0_g110);
				float Blending_BR64_g110 = lerpResult73_g110;
				float4 temp_cast_5 = (( ( temp_output_58_0_g110 - Blending_BR64_g110 ) + (Vertex_Colors53_g110).g )).xxxx;
				float temp_output_63_0_g110 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float3 lerpResult51_g110 = lerp( lerpResult28_g110 , SAMPLE_TEXTURE2D( _BaseColorG, sampler_Linear_Repeat, uv_BaseColorG ).rgb , temp_output_63_0_g110);
				float2 uv_BaseColorB = input.ase_texcoord6.xy * _BaseColorB_ST.xy + _BaseColorB_ST.zw;
				float2 uv_HeightB = input.ase_texcoord6.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D( _HeightB, sampler_HeightB, uv_HeightB );
				float temp_output_82_0_g110 = tex2DNode174.r;
				float lerpResult74_g110 = lerp( Blending_BR64_g110 , temp_output_58_0_g110 , temp_output_63_0_g110);
				float Blending_BRG66_g110 = lerpResult74_g110;
				float4 temp_cast_6 = (( ( temp_output_82_0_g110 - Blending_BRG66_g110 ) + (Vertex_Colors53_g110).b )).xxxx;
				float temp_output_81_0_g110 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float3 lerpResult91_g110 = lerp( lerpResult51_g110 , SAMPLE_TEXTURE2D( _BaseColorB, sampler_Linear_Repeat, uv_BaseColorB ).rgb , temp_output_81_0_g110);
				
				float2 uv_NormalBase = input.ase_texcoord6.xy * _NormalBase_ST.xy + _NormalBase_ST.zw;
				float2 uv_NormalR = input.ase_texcoord6.xy * _NormalR_ST.xy + _NormalR_ST.zw;
				float temp_output_1_0_g111 = tex2DNode94.r;
				float temp_output_6_0_g111 = tex2DNode92.r;
				float4 temp_cast_7 = (_Vector0.x).xxxx;
				float4 temp_cast_8 = (_Vector0.y).xxxx;
				float4 temp_cast_9 = (_Vector1.x).xxxx;
				float4 temp_cast_10 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_9 + ( input.ase_color - temp_cast_7 ) * ( temp_cast_10 - temp_cast_9 ) / ( temp_cast_8 - temp_cast_7 ) );
				float4 temp_cast_11 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_11)).r );
				float3 lerpResult28_g111 = lerp( UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalBase, sampler_NormalBase, uv_NormalBase ), 1.0f ) , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalR, sampler_NormalR, uv_NormalR ), 1.0f ) , temp_output_30_0_g111);
				float2 uv_NormalG = input.ase_texcoord6.xy * _NormalG_ST.xy + _NormalG_ST.zw;
				float temp_output_58_0_g111 = tex2DNode132.r;
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float4 temp_cast_12 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_12)).r );
				float3 lerpResult51_g111 = lerp( lerpResult28_g111 , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalG, sampler_NormalG, uv_NormalG ), 1.0f ) , temp_output_63_0_g111);
				float2 uv_NormalB = input.ase_texcoord6.xy * _NormalB_ST.xy + _NormalB_ST.zw;
				float temp_output_82_0_g111 = tex2DNode174.r;
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float4 temp_cast_13 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_13)).r );
				float3 lerpResult91_g111 = lerp( lerpResult51_g111 , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalB, sampler_NormalB, uv_NormalB ), 1.0f ) , temp_output_81_0_g111);
				

				float3 BaseColor = lerpResult91_g110;
				float3 Normal = lerpResult91_g111;
				float3 Specular = 0.5;
				float Metallic = _Metallic;
				float Smoothness = _Smoothness;
				float Occlusion = 1;
				float3 Emission = 0;
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
					float CoatMask = 0;
					float CoatSmoothness = 0;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
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

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
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

				#if defined(_DBUFFER)
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

				return half4( color.rgb, OutputAlpha( color.a, isTransparent ) );
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

			

			#define ASE_GEOMETRY 1
			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL


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
				float4 ase_color : COLOR;
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
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);


			float3 _LightDirection;
			float3 _LightPosition;

			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}

			PackedVaryings VertexFunction( Attributes input )
			{
				PackedVaryings output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float2 uv_HeightBase = input.ase_texcoord.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.ase_texcoord.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.ase_texcoord.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.ase_texcoord.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );
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
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

				#if defined( _ALPHATEST_ON )
					#if defined( _ALPHATEST_SHADOW_ON )
						AlphaDiscard( Alpha, AlphaClipThresholdShadow );
					#else
						AlphaDiscard( Alpha, AlphaClipThreshold );
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

			

			#define ASE_GEOMETRY 1
			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL


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
				float4 ase_color : COLOR;
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
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);


			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_HeightBase = input.ase_texcoord.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.ase_texcoord.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.ase_texcoord.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.ase_texcoord.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );

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
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
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
			#define ASE_GEOMETRY 1
			#pragma multi_compile_local_fragment _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
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
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);
			TEXTURE2D(_BaseColorBase);
			SAMPLER(sampler_Linear_Repeat);
			TEXTURE2D(_BaseColorR);
			TEXTURE2D(_BaseColorG);
			TEXTURE2D(_BaseColorB);


			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_HeightBase = input.texcoord0.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.texcoord0.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.texcoord0.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.texcoord0.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				
				output.ase_texcoord3.xy = input.texcoord0.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );

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
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

				float2 uv_BaseColorBase = input.ase_texcoord3.xy * _BaseColorBase_ST.xy + _BaseColorBase_ST.zw;
				float2 uv_BaseColorR = input.ase_texcoord3.xy * _BaseColorR_ST.xy + _BaseColorR_ST.zw;
				float2 uv_HeightR = input.ase_texcoord3.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D( _HeightR, sampler_HeightR, uv_HeightR );
				float temp_output_1_0_g110 = tex2DNode94.r;
				float2 uv_HeightBase = input.ase_texcoord3.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D( _HeightBase, sampler_HeightBase, uv_HeightBase );
				float temp_output_6_0_g110 = tex2DNode92.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g110 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g110 - temp_output_6_0_g110 ) + (Vertex_Colors53_g110).r )).xxxx;
				float temp_output_30_0_g110 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float3 lerpResult28_g110 = lerp( SAMPLE_TEXTURE2D( _BaseColorBase, sampler_Linear_Repeat, uv_BaseColorBase ).rgb , SAMPLE_TEXTURE2D( _BaseColorR, sampler_Linear_Repeat, uv_BaseColorR ).rgb , temp_output_30_0_g110);
				float2 uv_BaseColorG = input.ase_texcoord3.xy * _BaseColorG_ST.xy + _BaseColorG_ST.zw;
				float2 uv_HeightG = input.ase_texcoord3.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D( _HeightG, sampler_HeightG, uv_HeightG );
				float temp_output_58_0_g110 = tex2DNode132.r;
				float lerpResult73_g110 = lerp( temp_output_6_0_g110 , temp_output_1_0_g110 , temp_output_30_0_g110);
				float Blending_BR64_g110 = lerpResult73_g110;
				float4 temp_cast_5 = (( ( temp_output_58_0_g110 - Blending_BR64_g110 ) + (Vertex_Colors53_g110).g )).xxxx;
				float temp_output_63_0_g110 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float3 lerpResult51_g110 = lerp( lerpResult28_g110 , SAMPLE_TEXTURE2D( _BaseColorG, sampler_Linear_Repeat, uv_BaseColorG ).rgb , temp_output_63_0_g110);
				float2 uv_BaseColorB = input.ase_texcoord3.xy * _BaseColorB_ST.xy + _BaseColorB_ST.zw;
				float2 uv_HeightB = input.ase_texcoord3.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D( _HeightB, sampler_HeightB, uv_HeightB );
				float temp_output_82_0_g110 = tex2DNode174.r;
				float lerpResult74_g110 = lerp( Blending_BR64_g110 , temp_output_58_0_g110 , temp_output_63_0_g110);
				float Blending_BRG66_g110 = lerpResult74_g110;
				float4 temp_cast_6 = (( ( temp_output_82_0_g110 - Blending_BRG66_g110 ) + (Vertex_Colors53_g110).b )).xxxx;
				float temp_output_81_0_g110 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float3 lerpResult91_g110 = lerp( lerpResult51_g110 , SAMPLE_TEXTURE2D( _BaseColorB, sampler_Linear_Repeat, uv_BaseColorB ).rgb , temp_output_81_0_g110);
				

				float3 BaseColor = lerpResult91_g110;
				float3 Emission = 0;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
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

			#define ASE_GEOMETRY 1
			#pragma multi_compile_local_fragment _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);
			TEXTURE2D(_BaseColorBase);
			SAMPLER(sampler_Linear_Repeat);
			TEXTURE2D(_BaseColorR);
			TEXTURE2D(_BaseColorG);
			TEXTURE2D(_BaseColorB);


			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_TRANSFER_INSTANCE_ID( input, output );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float2 uv_HeightBase = input.ase_texcoord.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.ase_texcoord.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.ase_texcoord.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.ase_texcoord.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				
				output.ase_texcoord1.xy = input.ase_texcoord.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord1.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );

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
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

				float2 uv_BaseColorBase = input.ase_texcoord1.xy * _BaseColorBase_ST.xy + _BaseColorBase_ST.zw;
				float2 uv_BaseColorR = input.ase_texcoord1.xy * _BaseColorR_ST.xy + _BaseColorR_ST.zw;
				float2 uv_HeightR = input.ase_texcoord1.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D( _HeightR, sampler_HeightR, uv_HeightR );
				float temp_output_1_0_g110 = tex2DNode94.r;
				float2 uv_HeightBase = input.ase_texcoord1.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D( _HeightBase, sampler_HeightBase, uv_HeightBase );
				float temp_output_6_0_g110 = tex2DNode92.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g110 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g110 - temp_output_6_0_g110 ) + (Vertex_Colors53_g110).r )).xxxx;
				float temp_output_30_0_g110 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float3 lerpResult28_g110 = lerp( SAMPLE_TEXTURE2D( _BaseColorBase, sampler_Linear_Repeat, uv_BaseColorBase ).rgb , SAMPLE_TEXTURE2D( _BaseColorR, sampler_Linear_Repeat, uv_BaseColorR ).rgb , temp_output_30_0_g110);
				float2 uv_BaseColorG = input.ase_texcoord1.xy * _BaseColorG_ST.xy + _BaseColorG_ST.zw;
				float2 uv_HeightG = input.ase_texcoord1.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D( _HeightG, sampler_HeightG, uv_HeightG );
				float temp_output_58_0_g110 = tex2DNode132.r;
				float lerpResult73_g110 = lerp( temp_output_6_0_g110 , temp_output_1_0_g110 , temp_output_30_0_g110);
				float Blending_BR64_g110 = lerpResult73_g110;
				float4 temp_cast_5 = (( ( temp_output_58_0_g110 - Blending_BR64_g110 ) + (Vertex_Colors53_g110).g )).xxxx;
				float temp_output_63_0_g110 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float3 lerpResult51_g110 = lerp( lerpResult28_g110 , SAMPLE_TEXTURE2D( _BaseColorG, sampler_Linear_Repeat, uv_BaseColorG ).rgb , temp_output_63_0_g110);
				float2 uv_BaseColorB = input.ase_texcoord1.xy * _BaseColorB_ST.xy + _BaseColorB_ST.zw;
				float2 uv_HeightB = input.ase_texcoord1.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D( _HeightB, sampler_HeightB, uv_HeightB );
				float temp_output_82_0_g110 = tex2DNode174.r;
				float lerpResult74_g110 = lerp( Blending_BR64_g110 , temp_output_58_0_g110 , temp_output_63_0_g110);
				float Blending_BRG66_g110 = lerpResult74_g110;
				float4 temp_cast_6 = (( ( temp_output_82_0_g110 - Blending_BRG66_g110 ) + (Vertex_Colors53_g110).b )).xxxx;
				float temp_output_81_0_g110 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float3 lerpResult91_g110 = lerp( lerpResult51_g110 , SAMPLE_TEXTURE2D( _BaseColorB, sampler_Linear_Repeat, uv_BaseColorB ).rgb , temp_output_81_0_g110);
				

				float3 BaseColor = lerpResult91_g110;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				half4 color = half4(BaseColor, Alpha );

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
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

			

			

			#define ASE_GEOMETRY 1
			#pragma multi_compile_local _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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

			#if defined(UNITY_INSTANCING_ENABLED) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0


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
				half4 texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);
			TEXTURE2D(_NormalBase);
			SAMPLER(sampler_NormalBase);
			TEXTURE2D(_NormalR);
			SAMPLER(sampler_NormalR);
			TEXTURE2D(_NormalG);
			SAMPLER(sampler_NormalG);
			TEXTURE2D(_NormalB);
			SAMPLER(sampler_NormalB);


			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_HeightBase = input.texcoord.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.texcoord.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.texcoord.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.texcoord.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				
				output.ase_texcoord3.xy = input.texcoord.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );

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

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = input.texcoord.xy;
					output.tangentWS.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (input.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					BitangentWS = cross(NormalWS, -TangentWS);
				#endif

				float2 uv_NormalBase = input.ase_texcoord3.xy * _NormalBase_ST.xy + _NormalBase_ST.zw;
				float2 uv_NormalR = input.ase_texcoord3.xy * _NormalR_ST.xy + _NormalR_ST.zw;
				float2 uv_HeightR = input.ase_texcoord3.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D( _HeightR, sampler_HeightR, uv_HeightR );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 uv_HeightBase = input.ase_texcoord3.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D( _HeightBase, sampler_HeightBase, uv_HeightBase );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float3 lerpResult28_g111 = lerp( UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalBase, sampler_NormalBase, uv_NormalBase ), 1.0f ) , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalR, sampler_NormalR, uv_NormalR ), 1.0f ) , temp_output_30_0_g111);
				float2 uv_NormalG = input.ase_texcoord3.xy * _NormalG_ST.xy + _NormalG_ST.zw;
				float2 uv_HeightG = input.ase_texcoord3.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D( _HeightG, sampler_HeightG, uv_HeightG );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float3 lerpResult51_g111 = lerp( lerpResult28_g111 , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalG, sampler_NormalG, uv_NormalG ), 1.0f ) , temp_output_63_0_g111);
				float2 uv_NormalB = input.ase_texcoord3.xy * _NormalB_ST.xy + _NormalB_ST.zw;
				float2 uv_HeightB = input.ase_texcoord3.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D( _HeightB, sampler_HeightB, uv_HeightB );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float3 lerpResult91_g111 = lerp( lerpResult51_g111 , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalB, sampler_NormalB, uv_NormalB ), 1.0f ) , temp_output_81_0_g111);
				

				float3 Normal = lerpResult91_g111;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#if defined( ASE_DEPTH_WRITE_ON )
					float DeviceDepth = input.positionCS.z;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
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

			

			#define ASE_GEOMETRY 1
			#pragma multi_compile_local_fragment _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma shader_feature_local_fragment _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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

			#if defined(UNITY_INSTANCING_ENABLED) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR


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
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 lightmapUVOrVertexSH : TEXCOORD3;
				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					half4 fogFactorAndVertexLight : TEXCOORD4;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD5;
				#endif
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);
			TEXTURE2D(_BaseColorBase);
			SAMPLER(sampler_Linear_Repeat);
			TEXTURE2D(_BaseColorR);
			TEXTURE2D(_BaseColorG);
			TEXTURE2D(_BaseColorB);
			TEXTURE2D(_NormalBase);
			SAMPLER(sampler_NormalBase);
			TEXTURE2D(_NormalR);
			SAMPLER(sampler_NormalR);
			TEXTURE2D(_NormalG);
			SAMPLER(sampler_NormalG);
			TEXTURE2D(_NormalB);
			SAMPLER(sampler_NormalB);


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_HeightBase = input.texcoord.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.texcoord.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.texcoord.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.texcoord.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				
				output.ase_texcoord6.xy = input.texcoord.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord6.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );

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

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = input.texcoord.xy;
					output.tangentWS.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
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
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (input.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					BitangentWS = cross(NormalWS, -TangentWS);
				#endif

				float2 uv_BaseColorBase = input.ase_texcoord6.xy * _BaseColorBase_ST.xy + _BaseColorBase_ST.zw;
				float2 uv_BaseColorR = input.ase_texcoord6.xy * _BaseColorR_ST.xy + _BaseColorR_ST.zw;
				float2 uv_HeightR = input.ase_texcoord6.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D( _HeightR, sampler_HeightR, uv_HeightR );
				float temp_output_1_0_g110 = tex2DNode94.r;
				float2 uv_HeightBase = input.ase_texcoord6.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D( _HeightBase, sampler_HeightBase, uv_HeightBase );
				float temp_output_6_0_g110 = tex2DNode92.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g110 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g110 - temp_output_6_0_g110 ) + (Vertex_Colors53_g110).r )).xxxx;
				float temp_output_30_0_g110 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float3 lerpResult28_g110 = lerp( SAMPLE_TEXTURE2D( _BaseColorBase, sampler_Linear_Repeat, uv_BaseColorBase ).rgb , SAMPLE_TEXTURE2D( _BaseColorR, sampler_Linear_Repeat, uv_BaseColorR ).rgb , temp_output_30_0_g110);
				float2 uv_BaseColorG = input.ase_texcoord6.xy * _BaseColorG_ST.xy + _BaseColorG_ST.zw;
				float2 uv_HeightG = input.ase_texcoord6.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D( _HeightG, sampler_HeightG, uv_HeightG );
				float temp_output_58_0_g110 = tex2DNode132.r;
				float lerpResult73_g110 = lerp( temp_output_6_0_g110 , temp_output_1_0_g110 , temp_output_30_0_g110);
				float Blending_BR64_g110 = lerpResult73_g110;
				float4 temp_cast_5 = (( ( temp_output_58_0_g110 - Blending_BR64_g110 ) + (Vertex_Colors53_g110).g )).xxxx;
				float temp_output_63_0_g110 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float3 lerpResult51_g110 = lerp( lerpResult28_g110 , SAMPLE_TEXTURE2D( _BaseColorG, sampler_Linear_Repeat, uv_BaseColorG ).rgb , temp_output_63_0_g110);
				float2 uv_BaseColorB = input.ase_texcoord6.xy * _BaseColorB_ST.xy + _BaseColorB_ST.zw;
				float2 uv_HeightB = input.ase_texcoord6.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D( _HeightB, sampler_HeightB, uv_HeightB );
				float temp_output_82_0_g110 = tex2DNode174.r;
				float lerpResult74_g110 = lerp( Blending_BR64_g110 , temp_output_58_0_g110 , temp_output_63_0_g110);
				float Blending_BRG66_g110 = lerpResult74_g110;
				float4 temp_cast_6 = (( ( temp_output_82_0_g110 - Blending_BRG66_g110 ) + (Vertex_Colors53_g110).b )).xxxx;
				float temp_output_81_0_g110 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float3 lerpResult91_g110 = lerp( lerpResult51_g110 , SAMPLE_TEXTURE2D( _BaseColorB, sampler_Linear_Repeat, uv_BaseColorB ).rgb , temp_output_81_0_g110);
				
				float2 uv_NormalBase = input.ase_texcoord6.xy * _NormalBase_ST.xy + _NormalBase_ST.zw;
				float2 uv_NormalR = input.ase_texcoord6.xy * _NormalR_ST.xy + _NormalR_ST.zw;
				float temp_output_1_0_g111 = tex2DNode94.r;
				float temp_output_6_0_g111 = tex2DNode92.r;
				float4 temp_cast_7 = (_Vector0.x).xxxx;
				float4 temp_cast_8 = (_Vector0.y).xxxx;
				float4 temp_cast_9 = (_Vector1.x).xxxx;
				float4 temp_cast_10 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_9 + ( input.ase_color - temp_cast_7 ) * ( temp_cast_10 - temp_cast_9 ) / ( temp_cast_8 - temp_cast_7 ) );
				float4 temp_cast_11 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_11)).r );
				float3 lerpResult28_g111 = lerp( UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalBase, sampler_NormalBase, uv_NormalBase ), 1.0f ) , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalR, sampler_NormalR, uv_NormalR ), 1.0f ) , temp_output_30_0_g111);
				float2 uv_NormalG = input.ase_texcoord6.xy * _NormalG_ST.xy + _NormalG_ST.zw;
				float temp_output_58_0_g111 = tex2DNode132.r;
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float4 temp_cast_12 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_12)).r );
				float3 lerpResult51_g111 = lerp( lerpResult28_g111 , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalG, sampler_NormalG, uv_NormalG ), 1.0f ) , temp_output_63_0_g111);
				float2 uv_NormalB = input.ase_texcoord6.xy * _NormalB_ST.xy + _NormalB_ST.zw;
				float temp_output_82_0_g111 = tex2DNode174.r;
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float4 temp_cast_13 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_13)).r );
				float3 lerpResult91_g111 = lerp( lerpResult51_g111 , UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalB, sampler_NormalB, uv_NormalB ), 1.0f ) , temp_output_81_0_g111);
				

				float3 BaseColor = lerpResult91_g110;
				float3 Normal = lerpResult91_g111;
				float3 Specular = 0.5;
				float Metallic = _Metallic;
				float Smoothness = _Smoothness;
				float Occlusion = 1;
				float3 Emission = 0;
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

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
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

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
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

			

			#define ASE_GEOMETRY 1
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL


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
				float4 ase_color : COLOR;
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
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);


			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
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

				float2 uv_HeightBase = input.ase_texcoord.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.ase_texcoord.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.ase_texcoord.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.ase_texcoord.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );

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
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

			

			#define ASE_GEOMETRY 1
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define ASE_DISTANCE_TESSELLATION
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define _NORMALMAP 1
			#define ASE_VERSION 19902
			#define ASE_SRP_VERSION 140011
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
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL


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
				float4 ase_color : COLOR;
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
			float4 _HeightBase_ST;
			float4 _NormalB_ST;
			float4 _NormalG_ST;
			float4 _NormalR_ST;
			float4 _NormalBase_ST;
			float4 _BaseColorB_ST;
			float4 _BaseColorG_ST;
			float4 _BaseColorR_ST;
			float4 _BaseColorBase_ST;
			float4 _HeightB_ST;
			float4 _HeightG_ST;
			float4 _HeightR_ST;
			float _GlobalMeshHeight;
			float _BContrast;
			float _GContrast;
			float _RContrast;
			float _Metallic;
			float _Smoothness;
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

			TEXTURE2D(_HeightBase);
			SAMPLER(sampler_HeightBase);
			TEXTURE2D(_HeightR);
			SAMPLER(sampler_HeightR);
			TEXTURE2D(_HeightG);
			SAMPLER(sampler_HeightG);
			TEXTURE2D(_HeightB);
			SAMPLER(sampler_HeightB);


			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
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

				float2 uv_HeightBase = input.ase_texcoord.xy * _HeightBase_ST.xy + _HeightBase_ST.zw;
				float4 tex2DNode92 = SAMPLE_TEXTURE2D_LOD( _HeightBase, sampler_HeightBase, uv_HeightBase, 0.0 );
				float temp_output_6_0_g111 = tex2DNode92.r;
				float2 uv_HeightR = input.ase_texcoord.xy * _HeightR_ST.xy + _HeightR_ST.zw;
				float4 tex2DNode94 = SAMPLE_TEXTURE2D_LOD( _HeightR, sampler_HeightR, uv_HeightR, 0.0 );
				float temp_output_1_0_g111 = tex2DNode94.r;
				float2 _Vector0 = float2(0,1);
				float4 temp_cast_0 = (_Vector0.x).xxxx;
				float4 temp_cast_1 = (_Vector0.y).xxxx;
				float2 _Vector1 = float2(-1,1);
				float4 temp_cast_2 = (_Vector1.x).xxxx;
				float4 temp_cast_3 = (_Vector1.y).xxxx;
				float4 Vertex_Colors53_g111 =  (temp_cast_2 + ( input.ase_color - temp_cast_0 ) * ( temp_cast_3 - temp_cast_2 ) / ( temp_cast_1 - temp_cast_0 ) );
				float4 temp_cast_4 = (( ( temp_output_1_0_g111 - temp_output_6_0_g111 ) + (Vertex_Colors53_g111).r )).xxxx;
				float temp_output_30_0_g111 = saturate( (CalculateContrast(( _RContrast * 10 ),temp_cast_4)).r );
				float lerpResult73_g111 = lerp( temp_output_6_0_g111 , temp_output_1_0_g111 , temp_output_30_0_g111);
				float Blending_BR64_g111 = lerpResult73_g111;
				float2 uv_HeightG = input.ase_texcoord.xy * _HeightG_ST.xy + _HeightG_ST.zw;
				float4 tex2DNode132 = SAMPLE_TEXTURE2D_LOD( _HeightG, sampler_HeightG, uv_HeightG, 0.0 );
				float temp_output_58_0_g111 = tex2DNode132.r;
				float4 temp_cast_5 = (( ( temp_output_58_0_g111 - Blending_BR64_g111 ) + (Vertex_Colors53_g111).g )).xxxx;
				float temp_output_63_0_g111 = saturate( (CalculateContrast(( _GContrast * 10 ),temp_cast_5)).r );
				float lerpResult74_g111 = lerp( Blending_BR64_g111 , temp_output_58_0_g111 , temp_output_63_0_g111);
				float Blending_BRG66_g111 = lerpResult74_g111;
				float2 uv_HeightB = input.ase_texcoord.xy * _HeightB_ST.xy + _HeightB_ST.zw;
				float4 tex2DNode174 = SAMPLE_TEXTURE2D_LOD( _HeightB, sampler_HeightB, uv_HeightB, 0.0 );
				float temp_output_82_0_g111 = tex2DNode174.r;
				float4 temp_cast_6 = (( ( temp_output_82_0_g111 - Blending_BRG66_g111 ) + (Vertex_Colors53_g111).b )).xxxx;
				float temp_output_81_0_g111 = saturate( (CalculateContrast(( _BContrast * 10 ),temp_cast_6)).r );
				float lerpResult89_g111 = lerp( Blending_BRG66_g111 , temp_output_82_0_g111 , temp_output_81_0_g111);
				float Blending_BRGB90_g111 = lerpResult89_g111;
				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( ( ( Blending_BRGB90_g111 * input.normalOS ) + float3( 0,0,0 ) ) * _GlobalMeshHeight );

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
				float4 ase_color : COLOR;

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
				output.ase_color = input.ase_color;
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
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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
	
	CustomEditor "UnityEditor.ShaderGraphLitGUI"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback Off
}

/*ASEBEGIN
Version=19902
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;61;-2848,-64;Inherit;True;Property;_HeightBase;Height Base;2;0;Create;True;0;0;0;False;0;False;None;3cfe1d3004ac9ef41983f0705cb12da8;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;-2848,144;Inherit;True;Property;_HeightR;Height R;4;0;Create;True;0;0;0;False;0;False;None;fd665857096a83e498161748cc6c4080;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;133;-2848,368;Inherit;True;Property;_HeightG;Height G;8;0;Create;True;0;0;0;False;0;False;None;27f53a8b1771ff14ea8ac6580927f20d;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;173;-2848,608;Inherit;True;Property;_HeightB;Height B;11;0;Create;True;0;0;0;False;0;False;None;b35fb3f06eff93e42b7387637c10cd40;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;132;-1680,368;Inherit;True;Property;_TextureSample4;Texture Sample 4;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;174;-1680,608;Inherit;True;Property;_TextureSample6;Texture Sample 6;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;89;-1184,160;Inherit;True;Property;_NormalBase;Normal Base;1;0;Create;True;0;0;0;False;0;False;-1;None;165b6cc6c8551994f9e631d21853e74c;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;88;-1184,368;Inherit;True;Property;_NormalR;Normal R;5;0;Create;True;0;0;0;False;0;False;-1;None;a2c8ec3301169e144a787f90060b963f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;128;-1184,576;Inherit;True;Property;_NormalG;Normal G;7;0;Create;True;0;0;0;False;0;False;-1;None;32f7e6f790405ee4988c1931d8ea969d;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;172;-1184,784;Inherit;True;Property;_NormalB;Normal B;10;0;Create;True;0;0;0;False;0;False;-1;None;6442986dca3c5cb499af585ffc0feaf3;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;94;-1680,144;Inherit;True;Property;_TextureSample1;Texture Sample 1;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;92;-1680,-64;Inherit;True;Property;_TextureSample0;Texture Sample 0;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;95;-1200,-816;Inherit;True;Property;_TextureSample2;Texture Sample 2;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;96;-1200,-608;Inherit;True;Property;_TextureSample3;Texture Sample 3;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;21;-1504,-608;Inherit;True;Property;_BaseColorR;BaseColor R;3;0;Create;True;0;0;0;False;0;False;None;1276f800abbc9ef42a5e05b1c6937aac;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-1504,-816;Inherit;True;Property;_BaseColorBase;BaseColor Base;0;0;Create;True;0;0;0;False;0;False;None;61b10b9a6b9062a4bb19837c81df4153;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-304,288;Inherit;False;Property;_Metallic;Metallic;13;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-304,352;Inherit;False;Property;_Smoothness;Smoothness;12;0;Create;True;0;0;0;False;0;False;0;0.577;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;134;-1200,-400;Inherit;True;Property;_TextureSample5;Texture Sample 5;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;135;-1504,-400;Inherit;True;Property;_BaseColorG;BaseColor G;6;0;Create;True;0;0;0;False;0;False;None;be6841c06cadbc949ae4af8e65f7281b;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;175;-1200,-192;Inherit;True;Property;_TextureSample7;Texture Sample 7;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerStateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;177;-1776,-816;Inherit;False;0;0;0;1;-1;None;1;0;SAMPLER2D;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;178;-432,-160;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;190;-752,-608;Inherit;False;RS Height Blending;14;;110;27d4b967f3beadd4599e3286fbe3aed7;7,67,0,24,0,33,0,94,0,113,0,95,2,117,2;19;37;FLOAT3;0,0,0;False;34;FLOAT3;0,0,0;False;6;FLOAT;0;False;38;FLOAT3;0,0,0;False;35;FLOAT3;0,0,0;False;1;FLOAT;0;False;13;FLOAT;0;False;68;FLOAT3;0,0,0;False;69;FLOAT3;0,0,0;False;58;FLOAT;0;False;71;FLOAT;0;False;93;FLOAT3;0,0,0;False;92;FLOAT3;0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;115;FLOAT3;0,0,0;False;114;FLOAT3;0,0,0;False;108;FLOAT;0;False;109;FLOAT;0;False;3;FLOAT3;0;FLOAT;116;FLOAT3;132
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;191;-848,160;Inherit;False;RS Height Blending;14;;111;27d4b967f3beadd4599e3286fbe3aed7;7,67,1,24,1,33,1,94,1,113,1,95,2,117,2;19;37;FLOAT3;0,0,0;False;34;FLOAT3;0,0,0;False;6;FLOAT;0;False;38;FLOAT3;0,0,0;False;35;FLOAT3;0,0,0;False;1;FLOAT;0;False;13;FLOAT;0;False;68;FLOAT3;0,0,0;False;69;FLOAT3;0,0,0;False;58;FLOAT;0;False;71;FLOAT;0;False;93;FLOAT3;0,0,0;False;92;FLOAT3;0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;115;FLOAT3;0,0,0;False;114;FLOAT3;0,0,0;False;108;FLOAT;0;False;109;FLOAT;0;False;3;FLOAT3;0;FLOAT;116;FLOAT3;132
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;176;-1504,-192;Inherit;True;Property;_BaseColorB;BaseColor B;9;0;Create;True;0;0;0;False;0;False;None;1b3404db715f51e4fb1140187d72ae6b;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;13;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;True;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;16;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;19;0,0;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;11;752,80;Float;False;True;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;SH_HeightBlending;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForwardOnly;False;False;0;;0;0;Standard;47;Category;0;0;  Instanced Terrain Normals;1;0;Lighting Model;0;0;Workflow;1;0;Surface;0;0;  Refraction Model;0;0;  Blend;0;0;Two Sided;1;0;Alpha Clipping;1;0;  Use Shadow Threshold;0;638905886289910171;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;1;638905886308707696;Transmission;0;638905886384509217;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;2;0;Specular Highlights;2;0;Environment Reflections;2;0;Receive SSAO;1;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;1;638905917944907401;  Phong;0;638905893740825006;  Strength;0.5,False,;0;  Type;1;638905900998993613;  Tess;32,False,;638905901202248323;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;1;0;Clear Coat;0;0;0;10;False;True;True;True;True;True;True;True;True;True;False;;True;0
WireConnection;132;0;133;0
WireConnection;174;0;173;0
WireConnection;94;0;40;0
WireConnection;92;0;61;0
WireConnection;95;0;22;0
WireConnection;95;7;177;0
WireConnection;96;0;21;0
WireConnection;96;7;177;0
WireConnection;134;0;135;0
WireConnection;134;7;177;0
WireConnection;175;0;176;0
WireConnection;175;7;177;0
WireConnection;190;37;95;5
WireConnection;190;6;92;1
WireConnection;190;38;96;5
WireConnection;190;1;94;1
WireConnection;190;68;134;5
WireConnection;190;58;132;1
WireConnection;190;93;175;5
WireConnection;190;82;174;1
WireConnection;191;34;89;0
WireConnection;191;6;92;1
WireConnection;191;35;88;0
WireConnection;191;1;94;1
WireConnection;191;69;128;0
WireConnection;191;58;132;1
WireConnection;191;92;172;0
WireConnection;191;82;174;1
WireConnection;11;0;190;0
WireConnection;11;1;191;0
WireConnection;11;3;24;0
WireConnection;11;4;23;0
WireConnection;11;8;191;132
ASEEND*/
//CHKSM=B1672766787C378BB154CE241BD999A0BF84ECFD