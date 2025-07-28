// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader  "LS/Weather/Decal Rain Drops"
{
	Properties
    {
        [HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
        [HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
        [LS_DrawerCategory(OPACITY,true,_DecalOpacityGlobal,0,0)] _CATEGORY_OPACITY( "CATEGORY_OPACITY", Float ) = 1
        _DecalOpacityGlobal( "Opacity Global", Range( 0, 1 ) ) = 0.85
        [LS_DrawerToggleLeft] _DecalEdgeMask( "Edge Mask", Float ) = 1
        _EdgeMaskSharpness( "Edge Mask Sharpness", Float ) = 10000
        [LS_DrawerCategorySpace(10)] _SPACE_OPACITY( "SPACE_OPACITY", Float ) = 0
        [LS_DrawerCategory(RAIN DROPS,true,_ENABLERAINDROPS,0,0)] _CATEGORY_RAINDROPS( "CATEGORY_RAINDROPS", Float ) = 0
        [LS_DrawerToggleLeft] _ENABLERAINDROPS( "ENABLE RAIN DROPS", Float ) = 1
        _GlobalRainIntensity( "Global Rain Intensity", Float ) = 2
        _MetallicStrength( "Metallic Strength", Range( 0, 1 ) ) = 0.65
        _SmoothnessStrength( "Smoothness Strength", Range( 0, 1 ) ) = 1
        _OcclusionStrengthAO( "Occlusion Strength", Range( 0, 1 ) ) = 0
        [Space(5)][LS_DrawerTextureSingleLine] _RainDrop( "Rain Drop", 2D ) = "white" {}
        _Color( "Color", Color ) = ( 0.7098039, 0.7176471, 0.7137255 )
        [LS_DrawerTextureScaleOffset] _RainDrop_ST( "Tilling Offset", Vector ) = ( 1, 1, 0, 0 )
        _RainDropNormalScale( "Rain Drop Normal Scale", Float ) = 1
        _RainDropSpeed( "Rain Drop Speed", Float ) = 0.7
        _RainDropStaticScale( "Rain Drop Static Scale", Range( 0, 1 ) ) = 0.75
        [LS_DrawerCategorySpace(10)] _CATEGORYSPACE_RAINDROPS( "CATEGORYSPACE_RAINDROPS", Float ) = 0


        [HideInInspector] _DrawOrder("Draw Order", Range(-50, 50)) = 0
        [HideInInspector][Enum(Depth Bias, 0, View Bias, 1)] _DecalMeshBiasType("DecalMesh BiasType", Float) = 0

        [HideInInspector] _DecalMeshDepthBias("DecalMesh DepthBias", Float) = 0
        [HideInInspector] _DecalMeshViewBias("DecalMesh ViewBias", Float) = 0

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

        [HideInInspector] _DecalAngleFadeSupported("Decal Angle Fade Supported", Float) = 1
    }

    SubShader
    {
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "PreviewType"="Plane" "DisableBatching"="LODFading" "ShaderGraphShader"="true" "ShaderGraphTargetId"="UniversalDecalSubTarget" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"
		ENDHLSL

		
        Pass
        {
			
            Name "DBufferProjector"
            Tags { "LightMode"="DBufferProjector" }

			Cull Front
			Blend 0 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			Blend 1 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			Blend 2 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ZTest Greater
			ZWrite Off
			ColorMask RGBA
			ColorMask RGBA 1
			ColorMask RGBA 2

            HLSLPROGRAM

			#define _MATERIAL_AFFECTS_ALBEDO 1
			#define _MATERIAL_AFFECTS_NORMAL_BLEND 1
			#define DECAL_ANGLE_FADE 1
			#define  _MATERIAL_AFFECTS_MAOS 1
			#define _MATERIAL_AFFECTS_NORMAL 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex Vert
			#pragma fragment Frag

		    #pragma exclude_renderers glcore gles gles3 
			#pragma multi_compile_instancing
			#pragma editor_sync_compilation

			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile _ _DECAL_LAYERS

			

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"

            #define HAVE_MESH_MODIFICATION
            #define SHADERPASS SHADERPASS_DBUFFER_PROJECTOR

			#if _RENDER_PASS_ENABLED
			#define GBUFFER3 0
			#define GBUFFER4 1
			FRAMEBUFFER_INPUT_HALF(GBUFFER3);
			FRAMEBUFFER_INPUT_HALF(GBUFFER4);
			#endif

			

			
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
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DecalInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderVariablesDecal.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			struct SurfaceDescription
			{
				float3 BaseColor;
				float Alpha;
				float3 NormalTS;
				float NormalAlpha;
				float Metallic;
				float Occlusion;
				float Smoothness;
				float MAOSAlpha;
			};

			struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

            CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float3 _Color;
			float _CATEGORYSPACE_RAINDROPS;
			half _MetallicStrength;
			float _RainDropNormalScale;
			float _DecalEdgeMask;
			float _EdgeMaskSharpness;
			float _SPACE_OPACITY;
			float _CATEGORY_OPACITY;
			half _DecalOpacityGlobal;
			float _ENABLERAINDROPS;
			float _GlobalRainIntensity;
			float _RainDropStaticScale;
			float _RainDropSpeed;
			float _CATEGORY_RAINDROPS;
			half _OcclusionStrengthAO;
			half _SmoothnessStrength;
			float _DrawOrder;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;
			#if defined(DECAL_ANGLE_FADE)
			float _DecalAngleFadeSupported;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
				float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
            #endif

			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			

            void GetSurfaceData(SurfaceDescription surfaceDescription, float angleFadeFactor, out DecalSurfaceData surfaceData)
            {
                half4x4 normalToWorld = UNITY_ACCESS_INSTANCED_PROP(Decal, _NormalToWorld);
                half fadeFactor = clamp(normalToWorld[0][3], 0.0f, 1.0f) * angleFadeFactor;
                float2 scale = float2(normalToWorld[3][0], normalToWorld[3][1]);
                float2 offset = float2(normalToWorld[3][2], normalToWorld[3][3]);

                ZERO_INITIALIZE(DecalSurfaceData, surfaceData);
                surfaceData.occlusion = half(1.0);
                surfaceData.smoothness = half(0);

                #ifdef _MATERIAL_AFFECTS_NORMAL
                    surfaceData.normalWS.w = half(1.0);
                #else
                    surfaceData.normalWS.w = half(0.0);
                #endif

                surfaceData.baseColor.xyz = half3(surfaceDescription.BaseColor);
                surfaceData.baseColor.w = half(surfaceDescription.Alpha * fadeFactor);

                #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
					    

						
						surfaceData.normalWS.xyz = normalize(mul((half3x3)normalToWorld, surfaceDescription.NormalTS.xyz));
					

                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(normalToWorld[2].xyz);
					
                    #endif
                #elif (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
                        float sgn = input.tangentWS.w;
                        float3 bitangent = sgn * cross(input.normalWS.xyz, input.tangentWS.xyz);
                        half3x3 tangentToWorld = half3x3(input.tangentWS.xyz, bitangent.xyz, input.normalWS.xyz);
                        surfaceData.normalWS.xyz = normalize(TransformTangentToWorld(surfaceDescription.NormalTS, tangentToWorld));
                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(half3(input.normalWS));
					
                    #endif
                #endif

                surfaceData.normalWS.w = surfaceDescription.NormalAlpha * fadeFactor;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceData.metallic = half(surfaceDescription.Metallic);
					surfaceData.occlusion = half(surfaceDescription.Occlusion);
					surfaceData.smoothness = half(surfaceDescription.Smoothness);
					surfaceData.MAOSAlpha = half(surfaceDescription.MAOSAlpha * fadeFactor);
				#endif
            }

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
            #define DECAL_PROJECTOR
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_MESH
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DBUFFER_MESH)
            #define DECAL_DBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH)
            #define DECAL_SCREEN_SPACE
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_GBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH)
            #define DECAL_FORWARD_EMISSIVE
            #endif

            #if ((!defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_ALBEDO)) || (defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_NORMAL_BLEND))) && (defined(DECAL_SCREEN_SPACE) || defined(DECAL_GBUFFER))
            #define DECAL_RECONSTRUCT_NORMAL
            #elif defined(DECAL_ANGLE_FADE)
            #define DECAL_LOAD_NORMAL
            #endif

            #ifdef _DECAL_LAYERS
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareRenderingLayerTexture.hlsl"
            #endif

            #if defined(DECAL_LOAD_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
            #endif

            #if defined(DECAL_PROJECTOR) || defined(DECAL_RECONSTRUCT_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #endif

            #ifdef DECAL_MESH
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DecalMeshBiasTypeEnum.cs.hlsl"
            #endif

            #ifdef DECAL_RECONSTRUCT_NORMAL
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/NormalReconstruction.hlsl"
            #endif

			PackedVaryings Vert(Attributes inputMesh  )
			{
				PackedVaryings packedOutput;
				ZERO_INITIALIZE(PackedVaryings, packedOutput);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, packedOutput);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(packedOutput);

				inputMesh.tangentOS = float4( 1, 0, 0, -1 );
				inputMesh.normalOS = float3( 0, 1, 0 );

				

				VertexPositionInputs vertexInput = GetVertexPositionInputs(inputMesh.positionOS.xyz);

				float3 positionWS = TransformObjectToWorld(inputMesh.positionOS);
				packedOutput.positionCS = TransformWorldToHClip(positionWS);

				return packedOutput;
			}

			void Frag(PackedVaryings packedInput,
				OUTPUT_DBUFFER(outDBuffer)
				
			)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				half angleFadeFactor = 1.0;

            #ifdef _DECAL_LAYERS
            #ifdef _RENDER_PASS_ENABLED
				uint surfaceRenderingLayer = DecodeMeshRenderingLayer(LOAD_FRAMEBUFFER_INPUT(GBUFFER4, packedInput.positionCS.xy).r);
            #else
				uint surfaceRenderingLayer = LoadSceneRenderingLayer(packedInput.positionCS.xy);
            #endif
				uint projectorRenderingLayer = uint(UNITY_ACCESS_INSTANCED_PROP(Decal, _DecalLayerMaskFromDecal));
				clip((surfaceRenderingLayer & projectorRenderingLayer) - 0.1);
            #endif

			#if defined(DECAL_PROJECTOR)
			#if UNITY_REVERSED_Z
			#if _RENDER_PASS_ENABLED
				float depth = LOAD_FRAMEBUFFER_INPUT(GBUFFER3, packedInput.positionCS.xy).x;
			#else
				float depth = LoadSceneDepth(packedInput.positionCS.xy);
			#endif
			#else
			#if _RENDER_PASS_ENABLED
				float depth = lerp(UNITY_NEAR_CLIP_VALUE, 1, LOAD_FRAMEBUFFER_INPUT(GBUFFER3, packedInput.positionCS.xy));
			#else
				float depth = lerp(UNITY_NEAR_CLIP_VALUE, 1, LoadSceneDepth(packedInput.positionCS.xy));
			#endif
			#endif
			#endif

				#if defined(DECAL_RECONSTRUCT_NORMAL)
					#if defined(_DECAL_NORMAL_BLEND_HIGH)
						half3 normalWS = half3(ReconstructNormalTap9(packedInput.positionCS.xy));
					#elif defined(_DECAL_NORMAL_BLEND_MEDIUM)
						half3 normalWS = half3(ReconstructNormalTap5(packedInput.positionCS.xy));
					#else
						half3 normalWS = half3(ReconstructNormalDerivative(packedInput.positionCS.xy));
					#endif
				#elif defined(DECAL_LOAD_NORMAL)
					half3 normalWS = half3(LoadSceneNormals(packedInput.positionCS.xy));
				#endif

				

				
				#if ASE_SRP_VERSION >=140011
					float2 positionSS = FoveatedRemapNonUniformToLinearCS(packedInput.positionCS.xy) * _ScreenSize.zw;
				#endif
			

				float4 positionCS = ComputeClipSpacePosition( positionSS, depth );
				float4 hpositionVS = mul( UNITY_MATRIX_I_P, positionCS );

				float4 ScreenPosNorm = float4( positionSS, positionCS.zw );
				float4 ClipPos = positionCS * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 PositionRWS = mul( ( float3x3 )UNITY_MATRIX_I_V, hpositionVS.xyz / hpositionVS.w );
				float3 PositionWS = PositionRWS + _WorldSpaceCameraPos;
				float3 PositionOS = TransformWorldToObject( PositionWS );
				float3 PositionVS = TransformWorldToView( PositionWS );

				float3 positionDS = TransformWorldToObject(PositionWS);
				positionDS = positionDS * float3(1.0, -1.0, 1.0);

				float clipValue = 0.5 - Max3(abs(positionDS).x, abs(positionDS).y, abs(positionDS).z);
				clip(clipValue);

				float2 texCoord = positionDS.xz + float2(0.5, 0.5);

				float4x4 normalToWorld = UNITY_ACCESS_INSTANCED_PROP(Decal, _NormalToWorld);
				float2 scale = float2(normalToWorld[3][0], normalToWorld[3][1]);
				float2 offset = float2(normalToWorld[3][2], normalToWorld[3][3]);
				texCoord.xy = texCoord.xy * scale + offset;

				float2 texCoord0 = texCoord;
				float2 texCoord1 = texCoord;
				float2 texCoord2 = texCoord;
				float2 texCoord3 = texCoord;

				float3 worldTangent = TransformObjectToWorldDir(float3(1, 0, 0));
				float3 worldNormal = TransformObjectToWorldDir(float3(0, 1, 0));
				float3 worldBitangent = TransformObjectToWorldDir(float3(0, 0, 1));

				#ifdef DECAL_ANGLE_FADE
					half2 angleFade = half2(normalToWorld[1][3], normalToWorld[2][3]);

					if (angleFade.y < 0.0f)
					{
						half3 decalNormal = half3(normalToWorld[0].z, normalToWorld[1].z, normalToWorld[2].z);
						half dotAngle = dot(normalWS, decalNormal);
						angleFadeFactor = saturate(angleFade.x + angleFade.y * (dotAngle * (dotAngle - 2.0)));
					}
				#endif

				half3 viewDirectionWS = half3(1.0, 1.0, 1.0);
				DecalSurfaceData surfaceData;

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float3 worldToObj3943_g58931 = mul( GetWorldToObjectMatrix(), float4( PositionWS, 1 ) ).xyz;
				float3 break3933_g58931 = worldToObj3943_g58931;
				float2 appendResult3945_g58931 = (float2(break3933_g58931.y , break3933_g58931.z));
				float3 temp_output_94_0_g58932 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g58932 = normalize( temp_output_94_0_g58932 );
				float3 break3923_g58931 = sinh( normalizeResult79_g58932 );
				float2 appendResult3922_g58931 = (float2(break3923_g58931.x , 1.0));
				float2 appendResult3946_g58931 = (float2(break3933_g58931.x , break3933_g58931.z));
				float2 appendResult3927_g58931 = (float2(-break3923_g58931.y , 1.0));
				float3 temp_output_3925_0_g58931 = pow( abs( normalizeResult79_g58932 ) , 64.0 );
				float dotResult3919_g58931 = dot( temp_output_3925_0_g58931 , float3( 1,1,1 ) );
				float3 break3936_g58931 = round( ( temp_output_3925_0_g58931 / ( dotResult3919_g58931 + 1E-37 ) ) );
				float2 lerpResult3918_g58931 = lerp( ( appendResult3945_g58931 * appendResult3922_g58931 ) , ( appendResult3946_g58931 * appendResult3927_g58931 ) , break3936_g58931.y);
				float2 appendResult3944_g58931 = (float2(break3933_g58931.x , break3933_g58931.y));
				float2 appendResult3935_g58931 = (float2(-break3923_g58931.z , 1.0));
				float2 lerpResult3937_g58931 = lerp( lerpResult3918_g58931 , ( appendResult3944_g58931 * appendResult3935_g58931 ) , break3936_g58931.z);
				float2 temp_output_3906_0_g58931 = ( ( lerpResult3937_g58931 * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g58931 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_3906_0_g58931, ddx( temp_output_3906_0_g58931 ), ddy( temp_output_3906_0_g58931 ) );
				float temp_output_3696_0_g58931 = ( ( tex2DNode257_g58931.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g58931 = ( frac( ( tex2DNode257_g58931.b - ( _TimeParameters.x * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g58931 ) );
				float lerpResult4008_g58931 = lerp( temp_output_1818_0_g58931 , ( temp_output_1818_0_g58931 + saturate( -temp_output_3696_0_g58931 ) ) , _RainDropStaticScale);
				float temp_output_3866_0_g58931 = ( (( ( lerpResult4008_g58931 * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) * ( pow( saturate( ( ( ( saturate( worldNormal.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) )*2.0 + -1.0) * ( 1.0 - ( _DecalOpacityGlobal + ( ( _CATEGORY_OPACITY + _SPACE_OPACITY ) * 0.0 ) ) ) );
				float3 worldToObj3854_g58931 = mul( GetWorldToObjectMatrix(), float4( PositionWS, 1 ) ).xyz;
				float3 temp_output_3855_0_g58931 = ( worldToObj3854_g58931 + float3( 0.5,0.5,0.5 ) );
				float3 break3859_g58931 = ( temp_output_3855_0_g58931 * ( 1.0 - temp_output_3855_0_g58931 ) );
				float temp_output_3861_0_g58931 = ( ( break3859_g58931.x * break3859_g58931.y ) * break3859_g58931.z );
				float lerpResult3865_g58931 = lerp( temp_output_3866_0_g58931 , ( temp_output_3866_0_g58931 * saturate( ( ( temp_output_3861_0_g58931 * temp_output_3861_0_g58931 ) * _EdgeMaskSharpness ) ) ) , _DecalEdgeMask);
				
				float4 appendResult3767_g58931 = (float4(1.0 , tex2DNode257_g58931.r , 0.0 , tex2DNode257_g58931.g));
				float3 unpack3768_g58931 = UnpackNormalScale( appendResult3767_g58931, _RainDropNormalScale );
				unpack3768_g58931.z = lerp( 1, unpack3768_g58931.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g58931 = ASESafeNormalize( unpack3768_g58931 );
				

				surfaceDescription.BaseColor = _Color;
				surfaceDescription.Alpha = lerpResult3865_g58931;
				surfaceDescription.NormalTS = ( normalizeResult3770_g58931 * ( pow( saturate( ( ( ( saturate( worldNormal.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) );
				surfaceDescription.NormalAlpha = lerpResult3865_g58931;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceDescription.Metallic = _MetallicStrength;
					surfaceDescription.Occlusion = saturate( ( 1.0 - _OcclusionStrengthAO ) );
					surfaceDescription.Smoothness =_SmoothnessStrength;
					surfaceDescription.MAOSAlpha = lerpResult3865_g58931;
				#endif

				GetSurfaceData(surfaceDescription, angleFadeFactor, surfaceData);
				ENCODE_INTO_DBUFFER(surfaceData, outDBuffer);

				

			}
            ENDHLSL
        }

		
        Pass
        {
			
            Name "DecalScreenSpaceProjector"
            Tags { "LightMode"="DecalScreenSpaceProjector" }

			Cull Front
			Blend SrcAlpha OneMinusSrcAlpha
			ZTest Greater
			ZWrite Off

			HLSLPROGRAM

			#define _MATERIAL_AFFECTS_ALBEDO 1
			#define _MATERIAL_AFFECTS_NORMAL_BLEND 1
			#define DECAL_ANGLE_FADE 1
			#define  _MATERIAL_AFFECTS_MAOS 1
			#define _MATERIAL_AFFECTS_NORMAL 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex Vert
			#pragma fragment Frag
			#pragma multi_compile_instancing
			#pragma multi_compile_fog
			#pragma editor_sync_compilation

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS

			

			
            #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
           

			#pragma multi_compile _ _FORWARD_PLUS

			
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
		

			

			#pragma multi_compile _DECAL_NORMAL_BLEND_LOW _DECAL_NORMAL_BLEND_MEDIUM _DECAL_NORMAL_BLEND_HIGH
			#pragma multi_compile _ _DECAL_LAYERS

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"

            #define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_NORMAL_WS
			#define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define VARYINGS_NEED_SH
            #define VARYINGS_NEED_STATIC_LIGHTMAP_UV
            #define VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV

            #define HAVE_MESH_MODIFICATION

            #define SHADERPASS SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR

			#if _RENDER_PASS_ENABLED
			#define GBUFFER3 0
			#define GBUFFER4 1
			FRAMEBUFFER_INPUT_HALF(GBUFFER3);
			FRAMEBUFFER_INPUT_HALF(GBUFFER4);
			#endif

			

			
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
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DecalInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderVariablesDecal.hlsl"

		    #if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			struct SurfaceDescription
			{
				float3 BaseColor;
				float Alpha;
				float3 NormalTS;
				float NormalAlpha;
				float Metallic;
				float Occlusion;
				float Smoothness;
				float MAOSAlpha;
				float3 Emission;
			};

			struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 normalWS : TEXCOORD0;
				float3 viewDirectionWS : TEXCOORD1;
				float4 lightmapUVs : TEXCOORD2; // @diogo: packs both static (xy) and dynamic (zw)
				float3 sh : TEXCOORD3;
				float4 fogFactorAndVertexLight : TEXCOORD4;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

            CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float3 _Color;
			float _CATEGORYSPACE_RAINDROPS;
			half _MetallicStrength;
			float _RainDropNormalScale;
			float _DecalEdgeMask;
			float _EdgeMaskSharpness;
			float _SPACE_OPACITY;
			float _CATEGORY_OPACITY;
			half _DecalOpacityGlobal;
			float _ENABLERAINDROPS;
			float _GlobalRainIntensity;
			float _RainDropStaticScale;
			float _RainDropSpeed;
			float _CATEGORY_RAINDROPS;
			half _OcclusionStrengthAO;
			half _SmoothnessStrength;
			float _DrawOrder;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;
			#if defined(DECAL_ANGLE_FADE)
			float _DecalAngleFadeSupported;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
				float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
            #endif

			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			

            void GetSurfaceData(SurfaceDescription surfaceDescription, float angleFadeFactor, out DecalSurfaceData surfaceData)
            {
                half4x4 normalToWorld = UNITY_ACCESS_INSTANCED_PROP(Decal, _NormalToWorld);
                half fadeFactor = clamp(normalToWorld[0][3], 0.0f, 1.0f) * angleFadeFactor;
                float2 scale = float2(normalToWorld[3][0], normalToWorld[3][1]);
                float2 offset = float2(normalToWorld[3][2], normalToWorld[3][3]);

                ZERO_INITIALIZE(DecalSurfaceData, surfaceData);
                surfaceData.occlusion = half(1.0);
                surfaceData.smoothness = half(0);

                #ifdef _MATERIAL_AFFECTS_NORMAL
                    surfaceData.normalWS.w = half(1.0);
                #else
                    surfaceData.normalWS.w = half(0.0);
                #endif

				#if defined( _MATERIAL_AFFECTS_EMISSION )
                	surfaceData.emissive.rgb = half3(surfaceDescription.Emission.rgb * fadeFactor);
				#endif

                surfaceData.baseColor.xyz = half3(surfaceDescription.BaseColor);
                surfaceData.baseColor.w = half(surfaceDescription.Alpha * fadeFactor);

                #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
					    

						
						surfaceData.normalWS.xyz = normalize(mul((half3x3)normalToWorld, surfaceDescription.NormalTS.xyz));
					

                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(normalToWorld[2].xyz);
					
                    #endif
                #elif (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
                        float sgn = input.tangentWS.w;
                        float3 bitangent = sgn * cross(input.normalWS.xyz, input.tangentWS.xyz);
                        half3x3 tangentToWorld = half3x3(input.tangentWS.xyz, bitangent.xyz, input.normalWS.xyz);
                        surfaceData.normalWS.xyz = normalize(TransformTangentToWorld(surfaceDescription.NormalTS, tangentToWorld));
                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(half3(input.normalWS));
					
                    #endif
                #endif

                surfaceData.normalWS.w = surfaceDescription.NormalAlpha * fadeFactor;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceData.metallic = half(surfaceDescription.Metallic);
					surfaceData.occlusion = half(surfaceDescription.Occlusion);
					surfaceData.smoothness = half(surfaceDescription.Smoothness);
					surfaceData.MAOSAlpha = half(surfaceDescription.MAOSAlpha * fadeFactor);
				#endif
            }

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
            #define DECAL_PROJECTOR
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_MESH
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DBUFFER_MESH)
            #define DECAL_DBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH)
            #define DECAL_SCREEN_SPACE
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_GBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH)
            #define DECAL_FORWARD_EMISSIVE
            #endif

            #if ((!defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_ALBEDO)) || (defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_NORMAL_BLEND))) && (defined(DECAL_SCREEN_SPACE) || defined(DECAL_GBUFFER))
            #define DECAL_RECONSTRUCT_NORMAL
            #elif defined(DECAL_ANGLE_FADE)
            #define DECAL_LOAD_NORMAL
            #endif

            #ifdef _DECAL_LAYERS
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareRenderingLayerTexture.hlsl"
            #endif

            #if defined(DECAL_LOAD_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
            #endif

            #if defined(DECAL_PROJECTOR) || defined(DECAL_RECONSTRUCT_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #endif

            #ifdef DECAL_MESH
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DecalMeshBiasTypeEnum.cs.hlsl"
            #endif

            #ifdef DECAL_RECONSTRUCT_NORMAL
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/NormalReconstruction.hlsl"
            #endif

			void InitializeInputData(PackedVaryings input, float3 positionWS, half3 normalWS, half3 viewDirectionWS, out InputData inputData)
			{
				inputData = (InputData)0;

				inputData.positionWS = positionWS;
				inputData.normalWS = normalWS;
				inputData.viewDirectionWS = viewDirectionWS;
				inputData.shadowCoord = float4(0, 0, 0, 0);

				#ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
					inputData.fogCoord = InitializeInputDataFog(float4(positionWS, 1.0), input.fogFactorAndVertexLight.x);
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined(VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV) && defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVs.xy, input.lightmapUVs.zw, input.sh, normalWS);
				#elif defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVs.xy, half3(input.sh), normalWS);
				#endif

				#if defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV)
					inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVs.xy);
				#endif

				#if defined(DEBUG_DISPLAY)
					#if defined(VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV) && defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.lightmapUVs.zw;
					#endif
					#if defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV) && defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVs.xy;
					#elif defined(VARYINGS_NEED_SH)
						inputData.vertexSH = input.sh;
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);
			}

			void GetSurface(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData)
			{
				surfaceData.albedo = decalSurfaceData.baseColor.rgb;
				surfaceData.metallic = saturate(decalSurfaceData.metallic);
				surfaceData.specular = 0;
				surfaceData.smoothness = saturate(decalSurfaceData.smoothness);
				surfaceData.occlusion = decalSurfaceData.occlusion;
				surfaceData.emission = decalSurfaceData.emissive;
				surfaceData.alpha = saturate(decalSurfaceData.baseColor.w);
				surfaceData.clearCoatMask = 0;
				surfaceData.clearCoatSmoothness = 1;
			}

			PackedVaryings Vert(Attributes inputMesh  )
			{
				PackedVaryings packedOutput;
				ZERO_INITIALIZE(PackedVaryings, packedOutput);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, packedOutput);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(packedOutput);

				inputMesh.tangentOS = float4( 1, 0, 0, -1 );
				inputMesh.normalOS = float3( 0, 1, 0 );

				

				VertexPositionInputs vertexInput = GetVertexPositionInputs(inputMesh.positionOS.xyz);
				float3 positionWS = TransformObjectToWorld(inputMesh.positionOS);

				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);

				packedOutput.positionCS = TransformWorldToHClip(positionWS);

				half fogFactor = 0;
				#if !defined(_FOG_FRAGMENT)
					fogFactor = ComputeFogFactor(packedOutput.positionCS.z);
				#endif
				half3 vertexLight = VertexLighting(positionWS, normalWS);
				packedOutput.fogFactorAndVertexLight = half4(fogFactor, vertexLight);

				packedOutput.normalWS.xyz =  normalWS;
				packedOutput.viewDirectionWS.xyz =  GetWorldSpaceViewDir(positionWS);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(inputMesh.uv1, unity_LightmapST, packedOutput.lightmapUVs.xy);
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					packedOutput.lightmapUVs.zw = inputMesh.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
					packedOutput.sh.xyz =  float3(SampleSHVertex(half3(normalWS)));
				#endif

				return packedOutput;
			}

			void Frag(PackedVaryings packedInput,
				out half4 outColor : SV_Target0
				
			)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				half angleFadeFactor = 1.0;

            #ifdef _DECAL_LAYERS
            #ifdef _RENDER_PASS_ENABLED
				uint surfaceRenderingLayer = DecodeMeshRenderingLayer(LOAD_FRAMEBUFFER_INPUT(GBUFFER4, packedInput.positionCS.xy).r);
            #else
				uint surfaceRenderingLayer = LoadSceneRenderingLayer(packedInput.positionCS.xy);
            #endif
				uint projectorRenderingLayer = uint(UNITY_ACCESS_INSTANCED_PROP(Decal, _DecalLayerMaskFromDecal));
				clip((surfaceRenderingLayer & projectorRenderingLayer) - 0.1);
            #endif

			#if defined(DECAL_PROJECTOR)
			#if UNITY_REVERSED_Z
			#if _RENDER_PASS_ENABLED
				float depth = LOAD_FRAMEBUFFER_INPUT(GBUFFER3, packedInput.positionCS.xy).x;
			#else
				float depth = LoadSceneDepth(packedInput.positionCS.xy);
			#endif
			#else
			#if _RENDER_PASS_ENABLED
				float depth = lerp(UNITY_NEAR_CLIP_VALUE, 1, LOAD_FRAMEBUFFER_INPUT(GBUFFER3, packedInput.positionCS.xy));
			#else
				float depth = lerp(UNITY_NEAR_CLIP_VALUE, 1, LoadSceneDepth(packedInput.positionCS.xy));
			#endif
			#endif
			#endif

				#if defined(DECAL_RECONSTRUCT_NORMAL)
					#if defined(_DECAL_NORMAL_BLEND_HIGH)
						half3 normalWS = half3(ReconstructNormalTap9(packedInput.positionCS.xy));
					#elif defined(_DECAL_NORMAL_BLEND_MEDIUM)
						half3 normalWS = half3(ReconstructNormalTap5(packedInput.positionCS.xy));
					#else
						half3 normalWS = half3(ReconstructNormalDerivative(packedInput.positionCS.xy));
					#endif
				#elif defined(DECAL_LOAD_NORMAL)
					half3 normalWS = half3(LoadSceneNormals(packedInput.positionCS.xy));
				#endif

				

				
				#if ASE_SRP_VERSION >=140011
					float2 positionSS = FoveatedRemapNonUniformToLinearCS(packedInput.positionCS.xy) * _ScreenSize.zw;
				#endif
			

				float4 positionCS = ComputeClipSpacePosition( positionSS, depth );
				float4 hpositionVS = mul( UNITY_MATRIX_I_P, positionCS );

				float4 ScreenPosNorm = float4( positionSS, positionCS.zw );
				float4 ClipPos = positionCS * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 PositionRWS = mul( ( float3x3 )UNITY_MATRIX_I_V, hpositionVS.xyz / hpositionVS.w );
				float3 PositionWS = PositionRWS + _WorldSpaceCameraPos;
				float3 PositionOS = TransformWorldToObject( PositionWS );
				float3 PositionVS = TransformWorldToView( PositionWS );

				float3 positionDS = TransformWorldToObject(PositionWS);
				positionDS = positionDS * float3(1.0, -1.0, 1.0);

				float clipValue = 0.5 - Max3(abs(positionDS).x, abs(positionDS).y, abs(positionDS).z);
				clip(clipValue);

				float2 texCoord = positionDS.xz + float2(0.5, 0.5);

				float4x4 normalToWorld = UNITY_ACCESS_INSTANCED_PROP(Decal, _NormalToWorld);
				float2 scale = float2(normalToWorld[3][0], normalToWorld[3][1]);
				float2 offset = float2(normalToWorld[3][2], normalToWorld[3][3]);
				texCoord.xy = texCoord.xy * scale + offset;

				float2 texCoord0 = texCoord;
				float2 texCoord1 = texCoord;
				float2 texCoord2 = texCoord;
				float2 texCoord3 = texCoord;

				float3 worldTangent = TransformObjectToWorldDir(float3(1, 0, 0));
				float3 worldNormal = TransformObjectToWorldDir(float3(0, 1, 0));
				float3 worldBitangent = TransformObjectToWorldDir(float3(0, 0, 1));

				#ifdef DECAL_ANGLE_FADE
					half2 angleFade = half2(normalToWorld[1][3], normalToWorld[2][3]);

					if (angleFade.y < 0.0f)
					{
						half3 decalNormal = half3(normalToWorld[0].z, normalToWorld[1].z, normalToWorld[2].z);
						half dotAngle = dot(normalWS, decalNormal);
						angleFadeFactor = saturate(angleFade.x + angleFade.y * (dotAngle * (dotAngle - 2.0)));
					}
				#endif

				half3 viewDirectionWS = half3(packedInput.viewDirectionWS);

				DecalSurfaceData surfaceData;

				float3 worldToObj3943_g58931 = mul( GetWorldToObjectMatrix(), float4( PositionWS, 1 ) ).xyz;
				float3 break3933_g58931 = worldToObj3943_g58931;
				float2 appendResult3945_g58931 = (float2(break3933_g58931.y , break3933_g58931.z));
				float3 temp_output_94_0_g58932 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g58932 = normalize( temp_output_94_0_g58932 );
				float3 break3923_g58931 = sinh( normalizeResult79_g58932 );
				float2 appendResult3922_g58931 = (float2(break3923_g58931.x , 1.0));
				float2 appendResult3946_g58931 = (float2(break3933_g58931.x , break3933_g58931.z));
				float2 appendResult3927_g58931 = (float2(-break3923_g58931.y , 1.0));
				float3 temp_output_3925_0_g58931 = pow( abs( normalizeResult79_g58932 ) , 64.0 );
				float dotResult3919_g58931 = dot( temp_output_3925_0_g58931 , float3( 1,1,1 ) );
				float3 break3936_g58931 = round( ( temp_output_3925_0_g58931 / ( dotResult3919_g58931 + 1E-37 ) ) );
				float2 lerpResult3918_g58931 = lerp( ( appendResult3945_g58931 * appendResult3922_g58931 ) , ( appendResult3946_g58931 * appendResult3927_g58931 ) , break3936_g58931.y);
				float2 appendResult3944_g58931 = (float2(break3933_g58931.x , break3933_g58931.y));
				float2 appendResult3935_g58931 = (float2(-break3923_g58931.z , 1.0));
				float2 lerpResult3937_g58931 = lerp( lerpResult3918_g58931 , ( appendResult3944_g58931 * appendResult3935_g58931 ) , break3936_g58931.z);
				float2 temp_output_3906_0_g58931 = ( ( lerpResult3937_g58931 * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g58931 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_3906_0_g58931, ddx( temp_output_3906_0_g58931 ), ddy( temp_output_3906_0_g58931 ) );
				float temp_output_3696_0_g58931 = ( ( tex2DNode257_g58931.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g58931 = ( frac( ( tex2DNode257_g58931.b - ( _TimeParameters.x * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g58931 ) );
				float lerpResult4008_g58931 = lerp( temp_output_1818_0_g58931 , ( temp_output_1818_0_g58931 + saturate( -temp_output_3696_0_g58931 ) ) , _RainDropStaticScale);
				float temp_output_3866_0_g58931 = ( (( ( lerpResult4008_g58931 * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) * ( pow( saturate( ( ( ( saturate( worldNormal.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) )*2.0 + -1.0) * ( 1.0 - ( _DecalOpacityGlobal + ( ( _CATEGORY_OPACITY + _SPACE_OPACITY ) * 0.0 ) ) ) );
				float3 worldToObj3854_g58931 = mul( GetWorldToObjectMatrix(), float4( PositionWS, 1 ) ).xyz;
				float3 temp_output_3855_0_g58931 = ( worldToObj3854_g58931 + float3( 0.5,0.5,0.5 ) );
				float3 break3859_g58931 = ( temp_output_3855_0_g58931 * ( 1.0 - temp_output_3855_0_g58931 ) );
				float temp_output_3861_0_g58931 = ( ( break3859_g58931.x * break3859_g58931.y ) * break3859_g58931.z );
				float lerpResult3865_g58931 = lerp( temp_output_3866_0_g58931 , ( temp_output_3866_0_g58931 * saturate( ( ( temp_output_3861_0_g58931 * temp_output_3861_0_g58931 ) * _EdgeMaskSharpness ) ) ) , _DecalEdgeMask);
				
				float4 appendResult3767_g58931 = (float4(1.0 , tex2DNode257_g58931.r , 0.0 , tex2DNode257_g58931.g));
				float3 unpack3768_g58931 = UnpackNormalScale( appendResult3767_g58931, _RainDropNormalScale );
				unpack3768_g58931.z = lerp( 1, unpack3768_g58931.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g58931 = ASESafeNormalize( unpack3768_g58931 );
				

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				surfaceDescription.BaseColor = _Color;
				surfaceDescription.Alpha = lerpResult3865_g58931;
				surfaceDescription.NormalTS = ( normalizeResult3770_g58931 * ( pow( saturate( ( ( ( saturate( worldNormal.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) );
				surfaceDescription.NormalAlpha = lerpResult3865_g58931;
				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceDescription.Metallic = _MetallicStrength;
					surfaceDescription.Occlusion = saturate( ( 1.0 - _OcclusionStrengthAO ) );
					surfaceDescription.Smoothness = _SmoothnessStrength;
					surfaceDescription.MAOSAlpha = lerpResult3865_g58931;
				#endif

				#if defined( _MATERIAL_AFFECTS_EMISSION )
					surfaceDescription.Emission = float3(0, 0, 0);
				#endif

				GetSurfaceData( surfaceDescription, angleFadeFactor, surfaceData);

				#ifdef DECAL_RECONSTRUCT_NORMAL
					surfaceData.normalWS.xyz = normalize(lerp(normalWS.xyz, surfaceData.normalWS.xyz, surfaceData.normalWS.w));
				#endif

				InputData inputData;
				InitializeInputData( packedInput, PositionWS, surfaceData.normalWS.xyz, viewDirectionWS, inputData);

				SurfaceData surface = (SurfaceData)0;
				GetSurface(surfaceData, surface);

				half4 color = UniversalFragmentPBR(inputData, surface);
				color.rgb = MixFog(color.rgb, inputData.fogCoord);
				outColor = color;

				

			}
			ENDHLSL
        }

		
        Pass
        {
            
			Name "DecalGBufferProjector"
            Tags { "LightMode"="DecalGBufferProjector" }

			Cull Front
			Blend 0 SrcAlpha OneMinusSrcAlpha
			Blend 1 SrcAlpha OneMinusSrcAlpha
			Blend 2 SrcAlpha OneMinusSrcAlpha
			Blend 3 SrcAlpha OneMinusSrcAlpha
			ZTest Greater
			ZWrite Off
			ColorMask RGB
			ColorMask 0 1
			ColorMask RGB 2
			ColorMask RGB 3

			HLSLPROGRAM

			#define _MATERIAL_AFFECTS_ALBEDO 1
			#define _MATERIAL_AFFECTS_NORMAL_BLEND 1
			#define DECAL_ANGLE_FADE 1
			#define  _MATERIAL_AFFECTS_MAOS 1
			#define _MATERIAL_AFFECTS_NORMAL 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex Vert
			#pragma fragment Frag
			#pragma multi_compile_instancing
			#pragma multi_compile_fog
			#pragma editor_sync_compilation

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN

			

			
            #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
           

			#pragma multi_compile _DECAL_NORMAL_BLEND_LOW _DECAL_NORMAL_BLEND_MEDIUM _DECAL_NORMAL_BLEND_HIGH
			#pragma multi_compile _ _DECAL_LAYERS
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"

            #define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TEXCOORD0
			#define VARYINGS_NEED_NORMAL_WS
			#define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_SH
            #define VARYINGS_NEED_STATIC_LIGHTMAP_UV
            #define VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV

            #define HAVE_MESH_MODIFICATION

            #define SHADERPASS SHADERPASS_DECAL_GBUFFER_PROJECTOR

			#if _RENDER_PASS_ENABLED
			#define GBUFFER3 0
			#define GBUFFER4 1
			FRAMEBUFFER_INPUT_HALF(GBUFFER3);
			FRAMEBUFFER_INPUT_HALF(GBUFFER4);
			#endif

			

			
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
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DecalInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderVariablesDecal.hlsl"

		    #if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			struct SurfaceDescription
			{
				float3 BaseColor;
				float Alpha;
				float3 NormalTS;
				float NormalAlpha;
				float Metallic;
				float Occlusion;
				float Smoothness;
				float MAOSAlpha;
				float3 Emission;
			};

			struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 normalWS : TEXCOORD0;
				float3 viewDirectionWS : TEXCOORD1;
				float4 lightmapUVs : TEXCOORD2; // @diogo: packs both static (xy) and dynamic (zw)
				float3 sh : TEXCOORD3;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

            CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float3 _Color;
			float _CATEGORYSPACE_RAINDROPS;
			half _MetallicStrength;
			float _RainDropNormalScale;
			float _DecalEdgeMask;
			float _EdgeMaskSharpness;
			float _SPACE_OPACITY;
			float _CATEGORY_OPACITY;
			half _DecalOpacityGlobal;
			float _ENABLERAINDROPS;
			float _GlobalRainIntensity;
			float _RainDropStaticScale;
			float _RainDropSpeed;
			float _CATEGORY_RAINDROPS;
			half _OcclusionStrengthAO;
			half _SmoothnessStrength;
			float _DrawOrder;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;
			#if defined(DECAL_ANGLE_FADE)
			float _DecalAngleFadeSupported;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
				float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
            #endif

			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			

            void GetSurfaceData(SurfaceDescription surfaceDescription, float angleFadeFactor, out DecalSurfaceData surfaceData)
            {
                half4x4 normalToWorld = UNITY_ACCESS_INSTANCED_PROP(Decal, _NormalToWorld);
                half fadeFactor = clamp(normalToWorld[0][3], 0.0f, 1.0f) * angleFadeFactor;
                float2 scale = float2(normalToWorld[3][0], normalToWorld[3][1]);
                float2 offset = float2(normalToWorld[3][2], normalToWorld[3][3]);

                ZERO_INITIALIZE(DecalSurfaceData, surfaceData);
                surfaceData.occlusion = half(1.0);
                surfaceData.smoothness = half(0);

                #ifdef _MATERIAL_AFFECTS_NORMAL
                    surfaceData.normalWS.w = half(1.0);
                #else
                    surfaceData.normalWS.w = half(0.0);
                #endif

				#if defined( _MATERIAL_AFFECTS_EMISSION )
					surfaceData.emissive.rgb = half3(surfaceDescription.Emission.rgb * fadeFactor);
				#endif

                surfaceData.baseColor.xyz = half3(surfaceDescription.BaseColor);
                surfaceData.baseColor.w = half(surfaceDescription.Alpha * fadeFactor);

                #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
					    

						
						surfaceData.normalWS.xyz = normalize(mul((half3x3)normalToWorld, surfaceDescription.NormalTS.xyz));
					

                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(normalToWorld[2].xyz);
					
                    #endif
                #elif (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
                        float sgn = input.tangentWS.w;
                        float3 bitangent = sgn * cross(input.normalWS.xyz, input.tangentWS.xyz);
                        half3x3 tangentToWorld = half3x3(input.tangentWS.xyz, bitangent.xyz, input.normalWS.xyz);
                        surfaceData.normalWS.xyz = normalize(TransformTangentToWorld(surfaceDescription.NormalTS, tangentToWorld));
                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(half3(input.normalWS));
					
                    #endif
                #endif

                surfaceData.normalWS.w = surfaceDescription.NormalAlpha * fadeFactor;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceData.metallic = half(surfaceDescription.Metallic);
					surfaceData.occlusion = half(surfaceDescription.Occlusion);
					surfaceData.smoothness = half(surfaceDescription.Smoothness);
					surfaceData.MAOSAlpha = half(surfaceDescription.MAOSAlpha * fadeFactor);
				#endif
            }

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
            #define DECAL_PROJECTOR
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_MESH
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DBUFFER_MESH)
            #define DECAL_DBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH)
            #define DECAL_SCREEN_SPACE
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_GBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH)
            #define DECAL_FORWARD_EMISSIVE
            #endif

            #if ((!defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_ALBEDO)) || (defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_NORMAL_BLEND))) && (defined(DECAL_SCREEN_SPACE) || defined(DECAL_GBUFFER))
            #define DECAL_RECONSTRUCT_NORMAL
            #elif defined(DECAL_ANGLE_FADE)
            #define DECAL_LOAD_NORMAL
            #endif

            #ifdef _DECAL_LAYERS
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareRenderingLayerTexture.hlsl"
            #endif

            #if defined(DECAL_LOAD_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
            #endif

            #if defined(DECAL_PROJECTOR) || defined(DECAL_RECONSTRUCT_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #endif

            #ifdef DECAL_MESH
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DecalMeshBiasTypeEnum.cs.hlsl"
            #endif

            #ifdef DECAL_RECONSTRUCT_NORMAL
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/NormalReconstruction.hlsl"
            #endif

			void InitializeInputData(PackedVaryings input, float3 positionWS, half3 normalWS, half3 viewDirectionWS, out InputData inputData)
			{
				inputData = (InputData)0;

				inputData.positionWS = positionWS;
				inputData.normalWS = normalWS;
				inputData.viewDirectionWS = viewDirectionWS;
				inputData.shadowCoord = float4(0, 0, 0, 0);

				#ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
					inputData.fogCoord = InitializeInputDataFog(float4(positionWS, 1.0), input.fogFactorAndVertexLight.x);
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined(VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV) && defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVs.xy, input.lightmapUVs.zw, input.sh, normalWS);
				#elif defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVs.xy, half3(input.sh), normalWS);
				#endif

				#if defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV)
					inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVs.xy);
				#endif

				#if defined(DEBUG_DISPLAY)
					#if defined(VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV) && defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.lightmapUVs.zw;
					#endif
					#if defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV) && defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVs.xy;
					#elif defined(VARYINGS_NEED_SH)
						inputData.vertexSH = input.sh;
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);
			}

			void GetSurface(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData)
			{
				surfaceData.albedo = decalSurfaceData.baseColor.rgb;
				surfaceData.metallic = saturate(decalSurfaceData.metallic);
				surfaceData.specular = 0;
				surfaceData.smoothness = saturate(decalSurfaceData.smoothness);
				surfaceData.occlusion = decalSurfaceData.occlusion;
				surfaceData.emission = decalSurfaceData.emissive;
				surfaceData.alpha = saturate(decalSurfaceData.baseColor.w);
				surfaceData.clearCoatMask = 0;
				surfaceData.clearCoatSmoothness = 1;
			}

			PackedVaryings Vert(Attributes inputMesh  )
			{
				PackedVaryings packedOutput;
				ZERO_INITIALIZE(PackedVaryings, packedOutput);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, packedOutput);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(packedOutput);

				inputMesh.tangentOS = float4( 1, 0, 0, -1 );
				inputMesh.normalOS = float3( 0, 1, 0 );

				

				float3 positionWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);

				packedOutput.positionCS = TransformWorldToHClip(positionWS);
				packedOutput.normalWS.xyz =  normalWS;
				packedOutput.viewDirectionWS.xyz =  GetWorldSpaceViewDir(positionWS);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(inputMesh.uv1, unity_LightmapST, packedOutput.lightmapUVs.xy);
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					packedOutput.lightmapUVs.zw = inputMesh.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
					packedOutput.sh = float3(SampleSHVertex(half3(normalWS)));
				#endif

				return packedOutput;
			}

			void Frag(PackedVaryings packedInput,
				out FragmentOutput fragmentOutput
				
			)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				half angleFadeFactor = 1.0;

            #ifdef _DECAL_LAYERS
            #ifdef _RENDER_PASS_ENABLED
				uint surfaceRenderingLayer = DecodeMeshRenderingLayer(LOAD_FRAMEBUFFER_INPUT(GBUFFER4, packedInput.positionCS.xy).r);
            #else
				uint surfaceRenderingLayer = LoadSceneRenderingLayer(packedInput.positionCS.xy);
            #endif
				uint projectorRenderingLayer = uint(UNITY_ACCESS_INSTANCED_PROP(Decal, _DecalLayerMaskFromDecal));
				clip((surfaceRenderingLayer & projectorRenderingLayer) - 0.1);
            #endif

			#if defined(DECAL_PROJECTOR)
			#if UNITY_REVERSED_Z
			#if _RENDER_PASS_ENABLED
				float depth = LOAD_FRAMEBUFFER_INPUT(GBUFFER3, packedInput.positionCS.xy).x;
			#else
				float depth = LoadSceneDepth(packedInput.positionCS.xy);
			#endif
			#else
			#if _RENDER_PASS_ENABLED
				float depth = lerp(UNITY_NEAR_CLIP_VALUE, 1, LOAD_FRAMEBUFFER_INPUT(GBUFFER3, packedInput.positionCS.xy));
			#else
				float depth = lerp(UNITY_NEAR_CLIP_VALUE, 1, LoadSceneDepth(packedInput.positionCS.xy));
			#endif
			#endif
			#endif

				#if defined(DECAL_RECONSTRUCT_NORMAL)
					#if defined(_DECAL_NORMAL_BLEND_HIGH)
						half3 normalWS = half3(ReconstructNormalTap9(packedInput.positionCS.xy));
					#elif defined(_DECAL_NORMAL_BLEND_MEDIUM)
						half3 normalWS = half3(ReconstructNormalTap5(packedInput.positionCS.xy));
					#else
						half3 normalWS = half3(ReconstructNormalDerivative(packedInput.positionCS.xy));
					#endif
				#elif defined(DECAL_LOAD_NORMAL)
					half3 normalWS = half3(LoadSceneNormals(packedInput.positionCS.xy));
				#endif

				

				
				#if ASE_SRP_VERSION >=140011
					float2 positionSS = FoveatedRemapNonUniformToLinearCS(packedInput.positionCS.xy) * _ScreenSize.zw;
				#endif
			

				float4 positionCS = ComputeClipSpacePosition( positionSS, depth );
				float4 hpositionVS = mul( UNITY_MATRIX_I_P, positionCS );

				float4 ScreenPosNorm = float4( positionSS, positionCS.zw );
				float4 ClipPos = positionCS * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 PositionRWS = mul( ( float3x3 )UNITY_MATRIX_I_V, hpositionVS.xyz / hpositionVS.w );
				float3 PositionWS = PositionRWS + _WorldSpaceCameraPos;
				float3 PositionOS = TransformWorldToObject( PositionWS );
				float3 PositionVS = TransformWorldToView( PositionWS );

				float3 positionDS = TransformWorldToObject(PositionWS);
				positionDS = positionDS * float3(1.0, -1.0, 1.0);

				float clipValue = 0.5 - Max3(abs(positionDS).x, abs(positionDS).y, abs(positionDS).z);
				clip(clipValue);

				float2 texCoord = positionDS.xz + float2(0.5, 0.5);

				float4x4 normalToWorld = UNITY_ACCESS_INSTANCED_PROP(Decal, _NormalToWorld);
				float2 scale = float2(normalToWorld[3][0], normalToWorld[3][1]);
				float2 offset = float2(normalToWorld[3][2], normalToWorld[3][3]);
				texCoord.xy = texCoord.xy * scale + offset;

				float2 texCoord0 = texCoord;
				float2 texCoord1 = texCoord;
				float2 texCoord2 = texCoord;
				float2 texCoord3 = texCoord;

				float3 worldTangent = TransformObjectToWorldDir(float3(1, 0, 0));
				float3 worldNormal = TransformObjectToWorldDir(float3(0, 1, 0));
				float3 worldBitangent = TransformObjectToWorldDir(float3(0, 0, 1));

				#ifdef DECAL_ANGLE_FADE
					half2 angleFade = half2(normalToWorld[1][3], normalToWorld[2][3]);

					if (angleFade.y < 0.0f)
					{
						half3 decalNormal = half3(normalToWorld[0].z, normalToWorld[1].z, normalToWorld[2].z);
						half dotAngle = dot(normalWS, decalNormal);
						angleFadeFactor = saturate(angleFade.x + angleFade.y * (dotAngle * (dotAngle - 2.0)));
					}
				#endif

				half3 viewDirectionWS = half3(packedInput.viewDirectionWS);
				DecalSurfaceData surfaceData;

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float3 worldToObj3943_g58931 = mul( GetWorldToObjectMatrix(), float4( PositionWS, 1 ) ).xyz;
				float3 break3933_g58931 = worldToObj3943_g58931;
				float2 appendResult3945_g58931 = (float2(break3933_g58931.y , break3933_g58931.z));
				float3 temp_output_94_0_g58932 = ( cross( ddx( PositionRWS ) , ddy( PositionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g58932 = normalize( temp_output_94_0_g58932 );
				float3 break3923_g58931 = sinh( normalizeResult79_g58932 );
				float2 appendResult3922_g58931 = (float2(break3923_g58931.x , 1.0));
				float2 appendResult3946_g58931 = (float2(break3933_g58931.x , break3933_g58931.z));
				float2 appendResult3927_g58931 = (float2(-break3923_g58931.y , 1.0));
				float3 temp_output_3925_0_g58931 = pow( abs( normalizeResult79_g58932 ) , 64.0 );
				float dotResult3919_g58931 = dot( temp_output_3925_0_g58931 , float3( 1,1,1 ) );
				float3 break3936_g58931 = round( ( temp_output_3925_0_g58931 / ( dotResult3919_g58931 + 1E-37 ) ) );
				float2 lerpResult3918_g58931 = lerp( ( appendResult3945_g58931 * appendResult3922_g58931 ) , ( appendResult3946_g58931 * appendResult3927_g58931 ) , break3936_g58931.y);
				float2 appendResult3944_g58931 = (float2(break3933_g58931.x , break3933_g58931.y));
				float2 appendResult3935_g58931 = (float2(-break3923_g58931.z , 1.0));
				float2 lerpResult3937_g58931 = lerp( lerpResult3918_g58931 , ( appendResult3944_g58931 * appendResult3935_g58931 ) , break3936_g58931.z);
				float2 temp_output_3906_0_g58931 = ( ( lerpResult3937_g58931 * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g58931 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_3906_0_g58931, ddx( temp_output_3906_0_g58931 ), ddy( temp_output_3906_0_g58931 ) );
				float temp_output_3696_0_g58931 = ( ( tex2DNode257_g58931.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g58931 = ( frac( ( tex2DNode257_g58931.b - ( _TimeParameters.x * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g58931 ) );
				float lerpResult4008_g58931 = lerp( temp_output_1818_0_g58931 , ( temp_output_1818_0_g58931 + saturate( -temp_output_3696_0_g58931 ) ) , _RainDropStaticScale);
				float temp_output_3866_0_g58931 = ( (( ( lerpResult4008_g58931 * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) * ( pow( saturate( ( ( ( saturate( worldNormal.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) )*2.0 + -1.0) * ( 1.0 - ( _DecalOpacityGlobal + ( ( _CATEGORY_OPACITY + _SPACE_OPACITY ) * 0.0 ) ) ) );
				float3 worldToObj3854_g58931 = mul( GetWorldToObjectMatrix(), float4( PositionWS, 1 ) ).xyz;
				float3 temp_output_3855_0_g58931 = ( worldToObj3854_g58931 + float3( 0.5,0.5,0.5 ) );
				float3 break3859_g58931 = ( temp_output_3855_0_g58931 * ( 1.0 - temp_output_3855_0_g58931 ) );
				float temp_output_3861_0_g58931 = ( ( break3859_g58931.x * break3859_g58931.y ) * break3859_g58931.z );
				float lerpResult3865_g58931 = lerp( temp_output_3866_0_g58931 , ( temp_output_3866_0_g58931 * saturate( ( ( temp_output_3861_0_g58931 * temp_output_3861_0_g58931 ) * _EdgeMaskSharpness ) ) ) , _DecalEdgeMask);
				
				float4 appendResult3767_g58931 = (float4(1.0 , tex2DNode257_g58931.r , 0.0 , tex2DNode257_g58931.g));
				float3 unpack3768_g58931 = UnpackNormalScale( appendResult3767_g58931, _RainDropNormalScale );
				unpack3768_g58931.z = lerp( 1, unpack3768_g58931.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g58931 = ASESafeNormalize( unpack3768_g58931 );
				

				surfaceDescription.BaseColor = _Color;
				surfaceDescription.Alpha = lerpResult3865_g58931;
				surfaceDescription.NormalTS = ( normalizeResult3770_g58931 * ( pow( saturate( ( ( ( saturate( worldNormal.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) );
				surfaceDescription.NormalAlpha = lerpResult3865_g58931;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceDescription.Metallic = _MetallicStrength;
					surfaceDescription.Occlusion =saturate( ( 1.0 - _OcclusionStrengthAO ) );
					surfaceDescription.Smoothness = _SmoothnessStrength;
					surfaceDescription.MAOSAlpha = lerpResult3865_g58931;
				#endif

				#if defined( _MATERIAL_AFFECTS_EMISSION )
					surfaceDescription.Emission = float3(0, 0, 0);
				#endif

				GetSurfaceData(surfaceDescription, angleFadeFactor, surfaceData);

				half3 normalToPack = surfaceData.normalWS.xyz;
				#ifdef DECAL_RECONSTRUCT_NORMAL
					surfaceData.normalWS.xyz = normalize(lerp(normalWS.xyz, surfaceData.normalWS.xyz, surfaceData.normalWS.w));
				#endif

					InputData inputData;
					InitializeInputData(packedInput, PositionWS, surfaceData.normalWS.xyz, viewDirectionWS, inputData);

					SurfaceData surface = (SurfaceData)0;
					GetSurface(surfaceData, surface);

					BRDFData brdfData;
					InitializeBRDFData(surface.albedo, surface.metallic, 0, surface.smoothness, surface.alpha, brdfData);

				#ifdef _MATERIAL_AFFECTS_ALBEDO
					Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
					MixRealtimeAndBakedGI(mainLight, surfaceData.normalWS.xyz, inputData.bakedGI, inputData.shadowMask);
					half3 color = GlobalIllumination(brdfData, inputData.bakedGI, surface.occlusion, surfaceData.normalWS.xyz, inputData.viewDirectionWS);
				#else
					half3 color = 0;
				#endif

				#pragma warning (disable : 3578) // The output value isn't completely initialized.
				half3 packedNormalWS = PackNormal(normalToPack);
				fragmentOutput.GBuffer0 = half4(surfaceData.baseColor.rgb, surfaceData.baseColor.a);
				fragmentOutput.GBuffer1 = 0;
				fragmentOutput.GBuffer2 = half4(packedNormalWS, surfaceData.normalWS.a);
				fragmentOutput.GBuffer3 = half4(surfaceData.emissive + color, surfaceData.baseColor.a);
				#if OUTPUT_SHADOWMASK
					fragmentOutput.GBuffer4 = inputData.shadowMask;
				#endif
				#pragma warning (default : 3578) // Restore output value isn't completely initialized.

				

			}
            ENDHLSL
        }

		
        Pass
        {
            
			Name "DBufferMesh"
            Tags { "LightMode"="DBufferMesh" }

			Blend 0 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			Blend 1 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			Blend 2 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ZTest LEqual
			ZWrite Off
			ColorMask RGBA
			ColorMask RGBA 1
			ColorMask RGBA 2

			HLSLPROGRAM

			#define _MATERIAL_AFFECTS_ALBEDO 1
			#define _MATERIAL_AFFECTS_NORMAL_BLEND 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define  _MATERIAL_AFFECTS_MAOS 1
			#define _MATERIAL_AFFECTS_NORMAL 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex Vert
			#pragma fragment Frag
			#pragma multi_compile_instancing
			#pragma editor_sync_compilation

			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile _ _DECAL_LAYERS

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0

            #define HAVE_MESH_MODIFICATION

            #define SHADERPASS SHADERPASS_DBUFFER_MESH

			#if _RENDER_PASS_ENABLED
			#define GBUFFER3 0
			#define GBUFFER4 1
			FRAMEBUFFER_INPUT_HALF(GBUFFER3);
			FRAMEBUFFER_INPUT_HALF(GBUFFER4);
			#endif

			

			
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
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DecalInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderVariablesDecal.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

            #define ASE_NEEDS_WORLD_POSITION
            #define ASE_NEEDS_FRAG_WORLD_POSITION
            #define ASE_NEEDS_VERT_POSITION
            #define ASE_NEEDS_WORLD_NORMAL
            #define ASE_NEEDS_FRAG_WORLD_NORMAL


			struct SurfaceDescription
			{
				float3 BaseColor;
				float Alpha;
				float3 NormalTS;
				float NormalAlpha;
				float Metallic;
				float Occlusion;
				float Smoothness;
				float MAOSAlpha;
			};

			struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 texCoord0 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

            CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float3 _Color;
			float _CATEGORYSPACE_RAINDROPS;
			half _MetallicStrength;
			float _RainDropNormalScale;
			float _DecalEdgeMask;
			float _EdgeMaskSharpness;
			float _SPACE_OPACITY;
			float _CATEGORY_OPACITY;
			half _DecalOpacityGlobal;
			float _ENABLERAINDROPS;
			float _GlobalRainIntensity;
			float _RainDropStaticScale;
			float _RainDropSpeed;
			float _CATEGORY_RAINDROPS;
			half _OcclusionStrengthAO;
			half _SmoothnessStrength;
			float _DrawOrder;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;
			#if defined(DECAL_ANGLE_FADE)
			float _DecalAngleFadeSupported;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
				float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
            #endif

			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			

            void GetSurfaceData(PackedVaryings input, SurfaceDescription surfaceDescription, out DecalSurfaceData surfaceData)
            {
                #if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
                #endif

                half fadeFactor = half(1.0);

                ZERO_INITIALIZE(DecalSurfaceData, surfaceData);
                surfaceData.occlusion = half(1.0);
                surfaceData.smoothness = half(0);

                #ifdef _MATERIAL_AFFECTS_NORMAL
                    surfaceData.normalWS.w = half(1.0);
                #else
                    surfaceData.normalWS.w = half(0.0);
                #endif

                surfaceData.baseColor.xyz = half3(surfaceDescription.BaseColor);
                surfaceData.baseColor.w = half(surfaceDescription.Alpha * fadeFactor);

                #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
					    

						
						surfaceData.normalWS.xyz = normalize(mul((half3x3)normalToWorld, surfaceDescription.NormalTS.xyz));
					

                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(normalToWorld[2].xyz);
					
                    #endif
                #elif (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
                        float sgn = input.tangentWS.w;
                        float3 bitangent = sgn * cross(input.normalWS.xyz, input.tangentWS.xyz);
                        half3x3 tangentToWorld = half3x3(input.tangentWS.xyz, bitangent.xyz, input.normalWS.xyz);
                        surfaceData.normalWS.xyz = normalize(TransformTangentToWorld(surfaceDescription.NormalTS, tangentToWorld));
                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(half3(input.normalWS));
					
                    #endif
                #endif

                surfaceData.normalWS.w = surfaceDescription.NormalAlpha * fadeFactor;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceData.metallic = half(surfaceDescription.Metallic);
					surfaceData.occlusion = half(surfaceDescription.Occlusion);
					surfaceData.smoothness = half(surfaceDescription.Smoothness);
					surfaceData.MAOSAlpha = half(surfaceDescription.MAOSAlpha * fadeFactor);
				#endif
            }

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
            #define DECAL_PROJECTOR
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_MESH
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DBUFFER_MESH)
            #define DECAL_DBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH)
            #define DECAL_SCREEN_SPACE
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_GBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH)
            #define DECAL_FORWARD_EMISSIVE
            #endif

            #if ((!defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_ALBEDO)) || (defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_NORMAL_BLEND))) && (defined(DECAL_SCREEN_SPACE) || defined(DECAL_GBUFFER))
            #define DECAL_RECONSTRUCT_NORMAL
            #elif defined(DECAL_ANGLE_FADE)
            #define DECAL_LOAD_NORMAL
            #endif

            #ifdef _DECAL_LAYERS
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareRenderingLayerTexture.hlsl"
            #endif

            #if defined(DECAL_LOAD_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
            #endif

            #if defined(DECAL_PROJECTOR) || defined(DECAL_RECONSTRUCT_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #endif

            #ifdef DECAL_MESH
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DecalMeshBiasTypeEnum.cs.hlsl"
            #endif

            #ifdef DECAL_RECONSTRUCT_NORMAL
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/NormalReconstruction.hlsl"
            #endif

			void MeshDecalsPositionZBias(inout PackedVaryings input)
			{
            #if UNITY_REVERSED_Z
				input.positionCS.z -= _DecalMeshDepthBias;
            #else
				input.positionCS.z += _DecalMeshDepthBias;
            #endif
			}

			PackedVaryings Vert(Attributes inputMesh  )
			{
				if (_DecalMeshBiasType == DECALMESHDEPTHBIASTYPE_VIEW_BIAS)
				{
					float3 viewDirectionOS = GetObjectSpaceNormalizeViewDir(inputMesh.positionOS);
					inputMesh.positionOS += viewDirectionOS * (_DecalMeshViewBias);
				}

				PackedVaryings packedOutput;
				ZERO_INITIALIZE(PackedVaryings, packedOutput);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, packedOutput);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(packedOutput);

				inputMesh.tangentOS = float4( 1, 0, 0, -1 );
				inputMesh.normalOS = float3( 0, 1, 0 );

				float4 ase_positionCS = TransformObjectToHClip( ( inputMesh.positionOS ).xyz );
				float4x4 ase_matrixInvP = UNITY_MATRIX_I_P;
				float4 ase_hpositionVS = mul( ase_matrixInvP, ase_positionCS );
				float3 ase_positionRWS = mul( ( float3x3 )UNITY_MATRIX_I_V, ase_hpositionVS.xyz / ase_hpositionVS.w );
				packedOutput.ase_texcoord4.xyz = ase_positionRWS;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				packedOutput.ase_texcoord4.w = 0;

				VertexPositionInputs vertexInput = GetVertexPositionInputs(inputMesh.positionOS.xyz);

				float3 positionWS = TransformObjectToWorld(inputMesh.positionOS);

				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				packedOutput.positionWS.xyz =  positionWS;
				packedOutput.normalWS.xyz =  normalWS;
				packedOutput.tangentWS.xyzw =  tangentWS;
				packedOutput.texCoord0.xyzw =  inputMesh.uv0;
				packedOutput.positionCS = TransformWorldToHClip(positionWS);

				if (_DecalMeshBiasType == DECALMESHDEPTHBIASTYPE_DEPTH_BIAS)
				{
					MeshDecalsPositionZBias(packedOutput);
				}

				return packedOutput;
			}

			void Frag(PackedVaryings packedInput,
				OUTPUT_DBUFFER(outDBuffer)
				
			)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				half angleFadeFactor = 1.0;

            #ifdef _DECAL_LAYERS
            #ifdef _RENDER_PASS_ENABLED
				uint surfaceRenderingLayer = DecodeMeshRenderingLayer(LOAD_FRAMEBUFFER_INPUT(GBUFFER4, packedInput.positionCS.xy).r);
            #else
				uint surfaceRenderingLayer = LoadSceneRenderingLayer(packedInput.positionCS.xy);
            #endif
				uint projectorRenderingLayer = uint(UNITY_ACCESS_INSTANCED_PROP(Decal, _DecalLayerMaskFromDecal));
				clip((surfaceRenderingLayer & projectorRenderingLayer) - 0.1);
            #endif

				#if defined(DECAL_RECONSTRUCT_NORMAL)
					#if defined(_DECAL_NORMAL_BLEND_HIGH)
						half3 normalWS = half3(ReconstructNormalTap9(packedInput.positionCS.xy));
					#elif defined(_DECAL_NORMAL_BLEND_MEDIUM)
						half3 normalWS = half3(ReconstructNormalTap5(packedInput.positionCS.xy));
					#else
						half3 normalWS = half3(ReconstructNormalDerivative(packedInput.positionCS.xy));
					#endif
				#elif defined(DECAL_LOAD_NORMAL)
					half3 normalWS = half3(LoadSceneNormals(packedInput.positionCS.xy));
				#endif

				

				
				#if ASE_SRP_VERSION >=140011
					float2 positionSS = FoveatedRemapNonUniformToLinearCS(packedInput.positionCS.xy) * _ScreenSize.zw;
				#endif
			

				float3 positionWS = packedInput.positionWS.xyz;
				half3 viewDirectionWS = half3(1.0, 1.0, 1.0);

				DecalSurfaceData surfaceData;
				SurfaceDescription surfaceDescription;

				float3 worldToObj3943_g58931 = mul( GetWorldToObjectMatrix(), float4( packedInput.positionWS, 1 ) ).xyz;
				float3 break3933_g58931 = worldToObj3943_g58931;
				float2 appendResult3945_g58931 = (float2(break3933_g58931.y , break3933_g58931.z));
				float3 ase_positionRWS = packedInput.ase_texcoord4.xyz;
				float3 temp_output_94_0_g58932 = ( cross( ddx( ase_positionRWS ) , ddy( ase_positionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g58932 = normalize( temp_output_94_0_g58932 );
				float3 break3923_g58931 = sinh( normalizeResult79_g58932 );
				float2 appendResult3922_g58931 = (float2(break3923_g58931.x , 1.0));
				float2 appendResult3946_g58931 = (float2(break3933_g58931.x , break3933_g58931.z));
				float2 appendResult3927_g58931 = (float2(-break3923_g58931.y , 1.0));
				float3 temp_output_3925_0_g58931 = pow( abs( normalizeResult79_g58932 ) , 64.0 );
				float dotResult3919_g58931 = dot( temp_output_3925_0_g58931 , float3( 1,1,1 ) );
				float3 break3936_g58931 = round( ( temp_output_3925_0_g58931 / ( dotResult3919_g58931 + 1E-37 ) ) );
				float2 lerpResult3918_g58931 = lerp( ( appendResult3945_g58931 * appendResult3922_g58931 ) , ( appendResult3946_g58931 * appendResult3927_g58931 ) , break3936_g58931.y);
				float2 appendResult3944_g58931 = (float2(break3933_g58931.x , break3933_g58931.y));
				float2 appendResult3935_g58931 = (float2(-break3923_g58931.z , 1.0));
				float2 lerpResult3937_g58931 = lerp( lerpResult3918_g58931 , ( appendResult3944_g58931 * appendResult3935_g58931 ) , break3936_g58931.z);
				float2 temp_output_3906_0_g58931 = ( ( lerpResult3937_g58931 * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g58931 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_3906_0_g58931, ddx( temp_output_3906_0_g58931 ), ddy( temp_output_3906_0_g58931 ) );
				float temp_output_3696_0_g58931 = ( ( tex2DNode257_g58931.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g58931 = ( frac( ( tex2DNode257_g58931.b - ( _TimeParameters.x * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g58931 ) );
				float lerpResult4008_g58931 = lerp( temp_output_1818_0_g58931 , ( temp_output_1818_0_g58931 + saturate( -temp_output_3696_0_g58931 ) ) , _RainDropStaticScale);
				float temp_output_3866_0_g58931 = ( (( ( lerpResult4008_g58931 * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) * ( pow( saturate( ( ( ( saturate( packedInput.normalWS.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) )*2.0 + -1.0) * ( 1.0 - ( _DecalOpacityGlobal + ( ( _CATEGORY_OPACITY + _SPACE_OPACITY ) * 0.0 ) ) ) );
				float3 worldToObj3854_g58931 = mul( GetWorldToObjectMatrix(), float4( packedInput.positionWS, 1 ) ).xyz;
				float3 temp_output_3855_0_g58931 = ( worldToObj3854_g58931 + float3( 0.5,0.5,0.5 ) );
				float3 break3859_g58931 = ( temp_output_3855_0_g58931 * ( 1.0 - temp_output_3855_0_g58931 ) );
				float temp_output_3861_0_g58931 = ( ( break3859_g58931.x * break3859_g58931.y ) * break3859_g58931.z );
				float lerpResult3865_g58931 = lerp( temp_output_3866_0_g58931 , ( temp_output_3866_0_g58931 * saturate( ( ( temp_output_3861_0_g58931 * temp_output_3861_0_g58931 ) * _EdgeMaskSharpness ) ) ) , _DecalEdgeMask);
				
				float4 appendResult3767_g58931 = (float4(1.0 , tex2DNode257_g58931.r , 0.0 , tex2DNode257_g58931.g));
				float3 unpack3768_g58931 = UnpackNormalScale( appendResult3767_g58931, _RainDropNormalScale );
				unpack3768_g58931.z = lerp( 1, unpack3768_g58931.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g58931 = ASESafeNormalize( unpack3768_g58931 );
				

				surfaceDescription.BaseColor = _Color;
				surfaceDescription.Alpha = lerpResult3865_g58931;
				surfaceDescription.NormalTS = ( normalizeResult3770_g58931 * ( pow( saturate( ( ( ( saturate( packedInput.normalWS.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) );
				surfaceDescription.NormalAlpha = lerpResult3865_g58931;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceDescription.Metallic = _MetallicStrength;
					surfaceDescription.Occlusion = saturate( ( 1.0 - _OcclusionStrengthAO ) );
					surfaceDescription.Smoothness = _SmoothnessStrength;
					surfaceDescription.MAOSAlpha = lerpResult3865_g58931;
				#endif

				GetSurfaceData(packedInput, surfaceDescription, surfaceData);
				ENCODE_INTO_DBUFFER(surfaceData, outDBuffer);

				

			}

            ENDHLSL
        }

		
        Pass
        {
            
			Name "DecalScreenSpaceMesh"
            Tags { "LightMode"="DecalScreenSpaceMesh" }

			Blend SrcAlpha OneMinusSrcAlpha
			ZTest LEqual
			ZWrite Off

			HLSLPROGRAM

			#define _MATERIAL_AFFECTS_ALBEDO 1
			#define _MATERIAL_AFFECTS_NORMAL_BLEND 1
			#define USE_UNITY_CROSSFADE 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define  _MATERIAL_AFFECTS_MAOS 1
			#define _MATERIAL_AFFECTS_NORMAL 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex Vert
			#pragma fragment Frag
			#pragma multi_compile_instancing
			#pragma multi_compile_fog
			#pragma editor_sync_compilation

			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS

			

			
            #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
           

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ _FORWARD_PLUS
			#pragma multi_compile _DECAL_NORMAL_BLEND_LOW _DECAL_NORMAL_BLEND_MEDIUM _DECAL_NORMAL_BLEND_HIGH
			#pragma multi_compile _ _DECAL_LAYERS

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define VARYINGS_NEED_SH
            #define VARYINGS_NEED_STATIC_LIGHTMAP_UV
            #define VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV

            #define HAVE_MESH_MODIFICATION

            #define SHADERPASS SHADERPASS_DECAL_SCREEN_SPACE_MESH

			#if _RENDER_PASS_ENABLED
			#define GBUFFER3 0
			#define GBUFFER4 1
			FRAMEBUFFER_INPUT_HALF(GBUFFER3);
			FRAMEBUFFER_INPUT_HALF(GBUFFER4);
			#endif

			

			
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
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DecalInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderVariablesDecal.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


            struct SurfaceDescription
			{
				float3 BaseColor;
				float Alpha;
				float3 NormalTS;
				float NormalAlpha;
				float Metallic;
				float Occlusion;
				float Smoothness;
				float MAOSAlpha;
				float3 Emission;
			};

            struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 texCoord0 : TEXCOORD3;
				float3 viewDirectionWS : TEXCOORD4;
				float4 lightmapUVs : TEXCOORD5; // @diogo: packs both static (xy) and dynamic (zw)
				float3 sh : TEXCOORD6;
				float4 fogFactorAndVertexLight : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

            CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float3 _Color;
			float _CATEGORYSPACE_RAINDROPS;
			half _MetallicStrength;
			float _RainDropNormalScale;
			float _DecalEdgeMask;
			float _EdgeMaskSharpness;
			float _SPACE_OPACITY;
			float _CATEGORY_OPACITY;
			half _DecalOpacityGlobal;
			float _ENABLERAINDROPS;
			float _GlobalRainIntensity;
			float _RainDropStaticScale;
			float _RainDropSpeed;
			float _CATEGORY_RAINDROPS;
			half _OcclusionStrengthAO;
			half _SmoothnessStrength;
			float _DrawOrder;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;
			#if defined(DECAL_ANGLE_FADE)
			float _DecalAngleFadeSupported;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
				float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
            #endif

			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			

            void GetSurfaceData(PackedVaryings input, SurfaceDescription surfaceDescription, out DecalSurfaceData surfaceData)
            {
                #if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
                #endif

                half fadeFactor = half(1.0);

                ZERO_INITIALIZE(DecalSurfaceData, surfaceData);
                surfaceData.occlusion = half(1.0);
                surfaceData.smoothness = half(0);

                #ifdef _MATERIAL_AFFECTS_NORMAL
                    surfaceData.normalWS.w = half(1.0);
                #else
                    surfaceData.normalWS.w = half(0.0);
                #endif

				#if defined( _MATERIAL_AFFECTS_EMISSION )
					surfaceData.emissive.rgb = half3(surfaceDescription.Emission.rgb * fadeFactor);
				#endif

                surfaceData.baseColor.xyz = half3(surfaceDescription.BaseColor);
                surfaceData.baseColor.w = half(surfaceDescription.Alpha * fadeFactor);

                #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
					    

						
						surfaceData.normalWS.xyz = normalize(mul((half3x3)normalToWorld, surfaceDescription.NormalTS.xyz));
					

                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(normalToWorld[2].xyz);
					
                    #endif
                #elif (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
                        float sgn = input.tangentWS.w;
                        float3 bitangent = sgn * cross(input.normalWS.xyz, input.tangentWS.xyz);
                        half3x3 tangentToWorld = half3x3(input.tangentWS.xyz, bitangent.xyz, input.normalWS.xyz);
                        surfaceData.normalWS.xyz = normalize(TransformTangentToWorld(surfaceDescription.NormalTS, tangentToWorld));
                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(half3(input.normalWS));
					
                    #endif
                #endif

                surfaceData.normalWS.w = surfaceDescription.NormalAlpha * fadeFactor;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceData.metallic = half(surfaceDescription.Metallic);
					surfaceData.occlusion = half(surfaceDescription.Occlusion);
					surfaceData.smoothness = half(surfaceDescription.Smoothness);
					surfaceData.MAOSAlpha = half(surfaceDescription.MAOSAlpha * fadeFactor);
				#endif
            }


            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
            #define DECAL_PROJECTOR
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_MESH
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DBUFFER_MESH)
            #define DECAL_DBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH)
            #define DECAL_SCREEN_SPACE
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_GBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH)
            #define DECAL_FORWARD_EMISSIVE
            #endif

            #if ((!defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_ALBEDO)) || (defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_NORMAL_BLEND))) && (defined(DECAL_SCREEN_SPACE) || defined(DECAL_GBUFFER))
            #define DECAL_RECONSTRUCT_NORMAL
            #elif defined(DECAL_ANGLE_FADE)
            #define DECAL_LOAD_NORMAL
            #endif

            #ifdef _DECAL_LAYERS
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareRenderingLayerTexture.hlsl"
            #endif

            #if defined(DECAL_LOAD_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
            #endif

            #if defined(DECAL_PROJECTOR) || defined(DECAL_RECONSTRUCT_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #endif

            #ifdef DECAL_MESH
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DecalMeshBiasTypeEnum.cs.hlsl"
            #endif

            #ifdef DECAL_RECONSTRUCT_NORMAL
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/NormalReconstruction.hlsl"
            #endif

			void MeshDecalsPositionZBias(inout PackedVaryings input)
			{
			#if UNITY_REVERSED_Z
				input.positionCS.z -= _DecalMeshDepthBias;
			#else
				input.positionCS.z += _DecalMeshDepthBias;
			#endif
			}

			void InitializeInputData(PackedVaryings input, float3 positionWS, half3 normalWS, half3 viewDirectionWS, out InputData inputData)
			{
				inputData = (InputData)0;

				inputData.positionWS = positionWS;
				inputData.normalWS = normalWS;
				inputData.viewDirectionWS = viewDirectionWS;
				inputData.shadowCoord = float4(0, 0, 0, 0);

				#ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
					inputData.fogCoord = InitializeInputDataFog(float4(positionWS, 1.0), input.fogFactorAndVertexLight.x);
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined(VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV) && defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVs.xy, input.lightmapUVs.zw, input.sh, normalWS);
				#elif defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVs.xy, half3(input.sh), normalWS);
				#endif

				#if defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV)
					inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVs.xy);
				#endif

				#if defined(DEBUG_DISPLAY)
					#if defined(VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV) && defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.lightmapUVs.zw;
					#endif
					#if defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV) && defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVs.xy;
					#elif defined(VARYINGS_NEED_SH)
						inputData.vertexSH = input.sh;
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);
			}

			void GetSurface(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData)
			{
				surfaceData.albedo = decalSurfaceData.baseColor.rgb;
				surfaceData.metallic = saturate(decalSurfaceData.metallic);
				surfaceData.specular = 0;
				surfaceData.smoothness = saturate(decalSurfaceData.smoothness);
				surfaceData.occlusion = decalSurfaceData.occlusion;
				surfaceData.emission = decalSurfaceData.emissive;
				surfaceData.alpha = saturate(decalSurfaceData.baseColor.w);
				surfaceData.clearCoatMask = 0;
				surfaceData.clearCoatSmoothness = 1;
			}

			PackedVaryings Vert(Attributes inputMesh  )
			{
				if (_DecalMeshBiasType == DECALMESHDEPTHBIASTYPE_VIEW_BIAS)
				{
					float3 viewDirectionOS = GetObjectSpaceNormalizeViewDir(inputMesh.positionOS);
					inputMesh.positionOS += viewDirectionOS * (_DecalMeshViewBias);
				}

				PackedVaryings packedOutput;
				ZERO_INITIALIZE(PackedVaryings, packedOutput);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, packedOutput);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(packedOutput);

				inputMesh.tangentOS = float4( 1, 0, 0, -1 );
				inputMesh.normalOS = float3( 0, 1, 0 );

				float4 ase_positionCS = TransformObjectToHClip( ( inputMesh.positionOS ).xyz );
				float4x4 ase_matrixInvP = UNITY_MATRIX_I_P;
				float4 ase_hpositionVS = mul( ase_matrixInvP, ase_positionCS );
				float3 ase_positionRWS = mul( ( float3x3 )UNITY_MATRIX_I_V, ase_hpositionVS.xyz / ase_hpositionVS.w );
				packedOutput.ase_texcoord8.xyz = ase_positionRWS;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				packedOutput.ase_texcoord8.w = 0;

				VertexPositionInputs vertexInput = GetVertexPositionInputs(inputMesh.positionOS.xyz);
				float3 positionWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				packedOutput.positionCS = TransformWorldToHClip(positionWS);

				half fogFactor = 0;
				#if !defined(_FOG_FRAGMENT)
					fogFactor = ComputeFogFactor(packedOutput.positionCS.z);
				#endif

				half3 vertexLight = VertexLighting(positionWS, normalWS);
				packedOutput.fogFactorAndVertexLight = half4(fogFactor, vertexLight);

				if (_DecalMeshBiasType == DECALMESHDEPTHBIASTYPE_DEPTH_BIAS)
				{
					MeshDecalsPositionZBias(packedOutput);
				}

				packedOutput.positionWS.xyz = positionWS;
				packedOutput.normalWS.xyz =  normalWS;
				packedOutput.tangentWS.xyzw =  tangentWS;
				packedOutput.texCoord0.xyzw =  inputMesh.uv0;
				packedOutput.viewDirectionWS.xyz =  GetWorldSpaceViewDir(positionWS);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(inputMesh.uv1, unity_LightmapST, packedOutput.lightmapUVs.xy);
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					packedOutput.lightmapUVs.zw = inputMesh.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
					packedOutput.sh = float3(SampleSHVertex(half3(normalWS)));
				#endif

				return packedOutput;
			}

			void Frag(PackedVaryings packedInput,
						out half4 outColor : SV_Target0
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				half angleFadeFactor = 1.0;

            #ifdef _DECAL_LAYERS
            #ifdef _RENDER_PASS_ENABLED
				uint surfaceRenderingLayer = DecodeMeshRenderingLayer(LOAD_FRAMEBUFFER_INPUT(GBUFFER4, packedInput.positionCS.xy).r);
            #else
				uint surfaceRenderingLayer = LoadSceneRenderingLayer(packedInput.positionCS.xy);
            #endif
				uint projectorRenderingLayer = uint(UNITY_ACCESS_INSTANCED_PROP(Decal, _DecalLayerMaskFromDecal));
				clip((surfaceRenderingLayer & projectorRenderingLayer) - 0.1);
            #endif

				#if defined(DECAL_RECONSTRUCT_NORMAL)
					#if defined(_DECAL_NORMAL_BLEND_HIGH)
						half3 normalWS = half3(ReconstructNormalTap9(packedInput.positionCS.xy));
					#elif defined(_DECAL_NORMAL_BLEND_MEDIUM)
						half3 normalWS = half3(ReconstructNormalTap5(packedInput.positionCS.xy));
					#else
						half3 normalWS = half3(ReconstructNormalDerivative(packedInput.positionCS.xy));
					#endif
				#elif defined(DECAL_LOAD_NORMAL)
					half3 normalWS = half3(LoadSceneNormals(packedInput.positionCS.xy));
				#endif

				

				
				#if ASE_SRP_VERSION >=140011
					float2 positionSS = FoveatedRemapNonUniformToLinearCS(packedInput.positionCS.xy) * _ScreenSize.zw;
				#endif
			

				float3 positionWS = packedInput.positionWS.xyz;
				half3 viewDirectionWS = half3(packedInput.viewDirectionWS);

				DecalSurfaceData surfaceData;
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float3 worldToObj3943_g58931 = mul( GetWorldToObjectMatrix(), float4( packedInput.positionWS, 1 ) ).xyz;
				float3 break3933_g58931 = worldToObj3943_g58931;
				float2 appendResult3945_g58931 = (float2(break3933_g58931.y , break3933_g58931.z));
				float3 ase_positionRWS = packedInput.ase_texcoord8.xyz;
				float3 temp_output_94_0_g58932 = ( cross( ddx( ase_positionRWS ) , ddy( ase_positionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g58932 = normalize( temp_output_94_0_g58932 );
				float3 break3923_g58931 = sinh( normalizeResult79_g58932 );
				float2 appendResult3922_g58931 = (float2(break3923_g58931.x , 1.0));
				float2 appendResult3946_g58931 = (float2(break3933_g58931.x , break3933_g58931.z));
				float2 appendResult3927_g58931 = (float2(-break3923_g58931.y , 1.0));
				float3 temp_output_3925_0_g58931 = pow( abs( normalizeResult79_g58932 ) , 64.0 );
				float dotResult3919_g58931 = dot( temp_output_3925_0_g58931 , float3( 1,1,1 ) );
				float3 break3936_g58931 = round( ( temp_output_3925_0_g58931 / ( dotResult3919_g58931 + 1E-37 ) ) );
				float2 lerpResult3918_g58931 = lerp( ( appendResult3945_g58931 * appendResult3922_g58931 ) , ( appendResult3946_g58931 * appendResult3927_g58931 ) , break3936_g58931.y);
				float2 appendResult3944_g58931 = (float2(break3933_g58931.x , break3933_g58931.y));
				float2 appendResult3935_g58931 = (float2(-break3923_g58931.z , 1.0));
				float2 lerpResult3937_g58931 = lerp( lerpResult3918_g58931 , ( appendResult3944_g58931 * appendResult3935_g58931 ) , break3936_g58931.z);
				float2 temp_output_3906_0_g58931 = ( ( lerpResult3937_g58931 * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g58931 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_3906_0_g58931, ddx( temp_output_3906_0_g58931 ), ddy( temp_output_3906_0_g58931 ) );
				float temp_output_3696_0_g58931 = ( ( tex2DNode257_g58931.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g58931 = ( frac( ( tex2DNode257_g58931.b - ( _TimeParameters.x * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g58931 ) );
				float lerpResult4008_g58931 = lerp( temp_output_1818_0_g58931 , ( temp_output_1818_0_g58931 + saturate( -temp_output_3696_0_g58931 ) ) , _RainDropStaticScale);
				float temp_output_3866_0_g58931 = ( (( ( lerpResult4008_g58931 * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) * ( pow( saturate( ( ( ( saturate( packedInput.normalWS.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) )*2.0 + -1.0) * ( 1.0 - ( _DecalOpacityGlobal + ( ( _CATEGORY_OPACITY + _SPACE_OPACITY ) * 0.0 ) ) ) );
				float3 worldToObj3854_g58931 = mul( GetWorldToObjectMatrix(), float4( packedInput.positionWS, 1 ) ).xyz;
				float3 temp_output_3855_0_g58931 = ( worldToObj3854_g58931 + float3( 0.5,0.5,0.5 ) );
				float3 break3859_g58931 = ( temp_output_3855_0_g58931 * ( 1.0 - temp_output_3855_0_g58931 ) );
				float temp_output_3861_0_g58931 = ( ( break3859_g58931.x * break3859_g58931.y ) * break3859_g58931.z );
				float lerpResult3865_g58931 = lerp( temp_output_3866_0_g58931 , ( temp_output_3866_0_g58931 * saturate( ( ( temp_output_3861_0_g58931 * temp_output_3861_0_g58931 ) * _EdgeMaskSharpness ) ) ) , _DecalEdgeMask);
				
				float4 appendResult3767_g58931 = (float4(1.0 , tex2DNode257_g58931.r , 0.0 , tex2DNode257_g58931.g));
				float3 unpack3768_g58931 = UnpackNormalScale( appendResult3767_g58931, _RainDropNormalScale );
				unpack3768_g58931.z = lerp( 1, unpack3768_g58931.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g58931 = ASESafeNormalize( unpack3768_g58931 );
				

				surfaceDescription.BaseColor = _Color;
				surfaceDescription.Alpha = lerpResult3865_g58931;
				surfaceDescription.NormalTS = ( normalizeResult3770_g58931 * ( pow( saturate( ( ( ( saturate( packedInput.normalWS.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) );
				surfaceDescription.NormalAlpha = lerpResult3865_g58931;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceDescription.Metallic = _MetallicStrength;
					surfaceDescription.Occlusion = saturate( ( 1.0 - _OcclusionStrengthAO ) );
					surfaceDescription.Smoothness = _SmoothnessStrength;
					surfaceDescription.MAOSAlpha = lerpResult3865_g58931;
				#endif

				#if defined( _MATERIAL_AFFECTS_EMISSION )
					surfaceDescription.Emission = float3(0, 0, 0);
				#endif

				GetSurfaceData(packedInput, surfaceDescription, surfaceData);

				#ifdef DECAL_RECONSTRUCT_NORMAL
					surfaceData.normalWS.xyz = normalize(lerp(normalWS.xyz, surfaceData.normalWS.xyz, surfaceData.normalWS.w));
				#endif

				InputData inputData;
				InitializeInputData(packedInput, positionWS, surfaceData.normalWS.xyz, viewDirectionWS, inputData);

				SurfaceData surface = (SurfaceData)0;
				GetSurface(surfaceData, surface);

				half4 color = UniversalFragmentPBR(inputData, surface);
				color.rgb = MixFog(color.rgb, inputData.fogCoord);
				outColor = color;

				

			}
            ENDHLSL
        }

		
        Pass
        {
            
			Name "DecalGBufferMesh"
            Tags { "LightMode"="DecalGBufferMesh" }

			Blend 0 SrcAlpha OneMinusSrcAlpha
			Blend 1 SrcAlpha OneMinusSrcAlpha
			Blend 2 SrcAlpha OneMinusSrcAlpha
			Blend 3 SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			ColorMask RGB
			ColorMask 0 1
			ColorMask RGB 2
			ColorMask RGB 3

			HLSLPROGRAM

			#define _MATERIAL_AFFECTS_ALBEDO 1
			#define _MATERIAL_AFFECTS_NORMAL_BLEND 1
			#define USE_UNITY_CROSSFADE 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define  _MATERIAL_AFFECTS_MAOS 1
			#define _MATERIAL_AFFECTS_NORMAL 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex Vert
			#pragma fragment Frag
			#pragma multi_compile_instancing
			#pragma multi_compile_fog
			#pragma editor_sync_compilation

			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN

			

			
            #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
           

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			#pragma multi_compile _DECAL_NORMAL_BLEND_LOW _DECAL_NORMAL_BLEND_MEDIUM _DECAL_NORMAL_BLEND_HIGH
			#pragma multi_compile _ _DECAL_LAYERS
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define VARYINGS_NEED_SH
            #define VARYINGS_NEED_STATIC_LIGHTMAP_UV
            #define VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV

            #define HAVE_MESH_MODIFICATION

            #define SHADERPASS SHADERPASS_DECAL_GBUFFER_MESH

			#if _RENDER_PASS_ENABLED
			#define GBUFFER3 0
			#define GBUFFER4 1
			FRAMEBUFFER_INPUT_HALF(GBUFFER3);
			FRAMEBUFFER_INPUT_HALF(GBUFFER4);
			#endif

			

			
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
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DecalInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderVariablesDecal.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			struct SurfaceDescription
			{
				float3 BaseColor;
				float Alpha;
				float3 NormalTS;
				float NormalAlpha;
				float Metallic;
				float Occlusion;
				float Smoothness;
				float MAOSAlpha;
				float3 Emission;
			};

            struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 texCoord0 : TEXCOORD3;
				float3 viewDirectionWS : TEXCOORD4;
				float4 lightmapUVs : TEXCOORD5; // @diogo: packs both static (xy) and dynamic (zw)
				float3 sh : TEXCOORD6;
				float4 fogFactorAndVertexLight : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

            CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float3 _Color;
			float _CATEGORYSPACE_RAINDROPS;
			half _MetallicStrength;
			float _RainDropNormalScale;
			float _DecalEdgeMask;
			float _EdgeMaskSharpness;
			float _SPACE_OPACITY;
			float _CATEGORY_OPACITY;
			half _DecalOpacityGlobal;
			float _ENABLERAINDROPS;
			float _GlobalRainIntensity;
			float _RainDropStaticScale;
			float _RainDropSpeed;
			float _CATEGORY_RAINDROPS;
			half _OcclusionStrengthAO;
			half _SmoothnessStrength;
			float _DrawOrder;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;
			#if defined(DECAL_ANGLE_FADE)
			float _DecalAngleFadeSupported;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
				float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
            #endif

			TEXTURE2D(_RainDrop);
			SAMPLER(sampler_RainDrop);


			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			

            void GetSurfaceData(PackedVaryings input, SurfaceDescription surfaceDescription, out DecalSurfaceData surfaceData)
            {
                #if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
                #endif

                half fadeFactor = half(1.0);

                ZERO_INITIALIZE(DecalSurfaceData, surfaceData);
                surfaceData.occlusion = half(1.0);
                surfaceData.smoothness = half(0);

                #ifdef _MATERIAL_AFFECTS_NORMAL
                    surfaceData.normalWS.w = half(1.0);
                #else
                    surfaceData.normalWS.w = half(0.0);
                #endif

				#if defined( _MATERIAL_AFFECTS_EMISSION )
					surfaceData.emissive.rgb = half3(surfaceDescription.Emission.rgb * fadeFactor);
				#endif

                surfaceData.baseColor.xyz = half3(surfaceDescription.BaseColor);
                surfaceData.baseColor.w = half(surfaceDescription.Alpha * fadeFactor);

                #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
					    

						
						surfaceData.normalWS.xyz = normalize(mul((half3x3)normalToWorld, surfaceDescription.NormalTS.xyz));
					

                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(normalToWorld[2].xyz);
					
                    #endif
                #elif (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
                    #if defined(_MATERIAL_AFFECTS_NORMAL)
                        float sgn = input.tangentWS.w;
                        float3 bitangent = sgn * cross(input.normalWS.xyz, input.tangentWS.xyz);
                        half3x3 tangentToWorld = half3x3(input.tangentWS.xyz, bitangent.xyz, input.normalWS.xyz);
                        surfaceData.normalWS.xyz = normalize(TransformTangentToWorld(surfaceDescription.NormalTS, tangentToWorld));
                    #else
					    

						
						surfaceData.normalWS.xyz = normalize(half3(input.normalWS));
					
                    #endif
                #endif

                surfaceData.normalWS.w = surfaceDescription.NormalAlpha * fadeFactor;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceData.metallic = half(surfaceDescription.Metallic);
					surfaceData.occlusion = half(surfaceDescription.Occlusion);
					surfaceData.smoothness = half(surfaceDescription.Smoothness);
					surfaceData.MAOSAlpha = half(surfaceDescription.MAOSAlpha * fadeFactor);
				#endif
            }

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
            #define DECAL_PROJECTOR
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_MESH
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DBUFFER_MESH)
            #define DECAL_DBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH)
            #define DECAL_SCREEN_SPACE
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_GBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH)
            #define DECAL_FORWARD_EMISSIVE
            #endif

            #if ((!defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_ALBEDO)) || (defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_NORMAL_BLEND))) && (defined(DECAL_SCREEN_SPACE) || defined(DECAL_GBUFFER))
            #define DECAL_RECONSTRUCT_NORMAL
            #elif defined(DECAL_ANGLE_FADE)
            #define DECAL_LOAD_NORMAL
            #endif

            #ifdef _DECAL_LAYERS
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareRenderingLayerTexture.hlsl"
            #endif

            #if defined(DECAL_LOAD_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
            #endif

            #if defined(DECAL_PROJECTOR) || defined(DECAL_RECONSTRUCT_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #endif

            #ifdef DECAL_MESH
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DecalMeshBiasTypeEnum.cs.hlsl"
            #endif

            #ifdef DECAL_RECONSTRUCT_NORMAL
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/NormalReconstruction.hlsl"
            #endif

			void MeshDecalsPositionZBias(inout PackedVaryings input)
			{
			#if UNITY_REVERSED_Z
				input.positionCS.z -= _DecalMeshDepthBias;
			#else
				input.positionCS.z += _DecalMeshDepthBias;
			#endif
			}

			void InitializeInputData(PackedVaryings input, float3 positionWS, half3 normalWS, half3 viewDirectionWS, out InputData inputData)
			{
				inputData = (InputData)0;

				inputData.positionWS = positionWS;
				inputData.normalWS = normalWS;
				inputData.viewDirectionWS = viewDirectionWS;
				inputData.shadowCoord = float4(0, 0, 0, 0);

				#ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
					inputData.fogCoord = InitializeInputDataFog(float4(positionWS, 1.0), input.fogFactorAndVertexLight.x);
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined(VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV) && defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVs.xy, input.lightmapUVs.zw, input.sh, normalWS);
				#elif defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVs.xy, half3(input.sh), normalWS);
				#endif

				#if defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV)
					inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVs.xy);
				#endif

				#if defined(DEBUG_DISPLAY)
					#if defined(VARYINGS_NEED_DYNAMIC_LIGHTMAP_UV) && defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.lightmapUVs.zw;
					#endif
					#if defined(VARYINGS_NEED_STATIC_LIGHTMAP_UV) && defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVs.xy;
					#elif defined(VARYINGS_NEED_SH)
						inputData.vertexSH = input.sh;
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);
			}

			void GetSurface(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData)
			{
				surfaceData.albedo = decalSurfaceData.baseColor.rgb;
				surfaceData.metallic = saturate(decalSurfaceData.metallic);
				surfaceData.specular = 0;
				surfaceData.smoothness = saturate(decalSurfaceData.smoothness);
				surfaceData.occlusion = decalSurfaceData.occlusion;
				surfaceData.emission = decalSurfaceData.emissive;
				surfaceData.alpha = saturate(decalSurfaceData.baseColor.w);
				surfaceData.clearCoatMask = 0;
				surfaceData.clearCoatSmoothness = 1;
			}

			PackedVaryings Vert(Attributes inputMesh  )
			{
				if (_DecalMeshBiasType == DECALMESHDEPTHBIASTYPE_VIEW_BIAS)
				{
					float3 viewDirectionOS = GetObjectSpaceNormalizeViewDir(inputMesh.positionOS);
					inputMesh.positionOS += viewDirectionOS * (_DecalMeshViewBias);
				}

				PackedVaryings packedOutput;
				ZERO_INITIALIZE(PackedVaryings, packedOutput);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, packedOutput);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(packedOutput);

				inputMesh.tangentOS = float4( 1, 0, 0, -1 );
				inputMesh.normalOS = float3( 0, 1, 0 );

				float4 ase_positionCS = TransformObjectToHClip( ( inputMesh.positionOS ).xyz );
				float4x4 ase_matrixInvP = UNITY_MATRIX_I_P;
				float4 ase_hpositionVS = mul( ase_matrixInvP, ase_positionCS );
				float3 ase_positionRWS = mul( ( float3x3 )UNITY_MATRIX_I_V, ase_hpositionVS.xyz / ase_hpositionVS.w );
				packedOutput.ase_texcoord8.xyz = ase_positionRWS;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				packedOutput.ase_texcoord8.w = 0;

				VertexPositionInputs vertexInput = GetVertexPositionInputs(inputMesh.positionOS.xyz);

				float3 positionWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				packedOutput.positionCS = TransformWorldToHClip(positionWS);

				if (_DecalMeshBiasType == DECALMESHDEPTHBIASTYPE_DEPTH_BIAS)
				{
					MeshDecalsPositionZBias(packedOutput);
				}

				packedOutput.positionWS.xyz = positionWS;
				packedOutput.normalWS.xyz =  normalWS;
				packedOutput.tangentWS.xyzw =  tangentWS;
				packedOutput.texCoord0.xyzw =  inputMesh.uv0;
				packedOutput.viewDirectionWS.xyz =  GetWorldSpaceViewDir(positionWS);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(inputMesh.uv1, unity_LightmapST, packedOutput.lightmapUVs.xy);
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					packedOutput.lightmapUVs.zw = inputMesh.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
					packedOutput.sh.xyz =  float3(SampleSHVertex(half3(normalWS)));
				#endif

				half fogFactor = 0;
				#if !defined(_FOG_FRAGMENT)
						fogFactor = ComputeFogFactor(packedOutput.positionCS.z);
				#endif

				half3 vertexLight = VertexLighting(positionWS, normalWS);
				packedOutput.fogFactorAndVertexLight = half4(fogFactor, vertexLight);

				return packedOutput;
			}

			void Frag(PackedVaryings packedInput,
				out FragmentOutput fragmentOutput
				
			)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				half angleFadeFactor = 1.0;

            #ifdef _DECAL_LAYERS
            #ifdef _RENDER_PASS_ENABLED
				uint surfaceRenderingLayer = DecodeMeshRenderingLayer(LOAD_FRAMEBUFFER_INPUT(GBUFFER4, packedInput.positionCS.xy).r);
            #else
				uint surfaceRenderingLayer = LoadSceneRenderingLayer(packedInput.positionCS.xy);
            #endif
				uint projectorRenderingLayer = uint(UNITY_ACCESS_INSTANCED_PROP(Decal, _DecalLayerMaskFromDecal));
				clip((surfaceRenderingLayer & projectorRenderingLayer) - 0.1);
            #endif

			#if defined(DECAL_RECONSTRUCT_NORMAL)
				#if defined(_DECAL_NORMAL_BLEND_HIGH)
					half3 normalWS = half3(ReconstructNormalTap9(packedInput.positionCS.xy));
				#elif defined(_DECAL_NORMAL_BLEND_MEDIUM)
					half3 normalWS = half3(ReconstructNormalTap5(packedInput.positionCS.xy));
				#else
					half3 normalWS = half3(ReconstructNormalDerivative(packedInput.positionCS.xy));
				#endif
			#elif defined(DECAL_LOAD_NORMAL)
				half3 normalWS = half3(LoadSceneNormals(packedInput.positionCS.xy));
			#endif

				

				
				#if ASE_SRP_VERSION >=140011
					float2 positionSS = FoveatedRemapNonUniformToLinearCS(packedInput.positionCS.xy) * _ScreenSize.zw;
				#endif
			

				float3 positionWS = packedInput.positionWS.xyz;
				half3 viewDirectionWS = half3(packedInput.viewDirectionWS);

				DecalSurfaceData surfaceData;
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float3 worldToObj3943_g58931 = mul( GetWorldToObjectMatrix(), float4( packedInput.positionWS, 1 ) ).xyz;
				float3 break3933_g58931 = worldToObj3943_g58931;
				float2 appendResult3945_g58931 = (float2(break3933_g58931.y , break3933_g58931.z));
				float3 ase_positionRWS = packedInput.ase_texcoord8.xyz;
				float3 temp_output_94_0_g58932 = ( cross( ddx( ase_positionRWS ) , ddy( ase_positionRWS ) ) * _ProjectionParams.x );
				float3 normalizeResult79_g58932 = normalize( temp_output_94_0_g58932 );
				float3 break3923_g58931 = sinh( normalizeResult79_g58932 );
				float2 appendResult3922_g58931 = (float2(break3923_g58931.x , 1.0));
				float2 appendResult3946_g58931 = (float2(break3933_g58931.x , break3933_g58931.z));
				float2 appendResult3927_g58931 = (float2(-break3923_g58931.y , 1.0));
				float3 temp_output_3925_0_g58931 = pow( abs( normalizeResult79_g58932 ) , 64.0 );
				float dotResult3919_g58931 = dot( temp_output_3925_0_g58931 , float3( 1,1,1 ) );
				float3 break3936_g58931 = round( ( temp_output_3925_0_g58931 / ( dotResult3919_g58931 + 1E-37 ) ) );
				float2 lerpResult3918_g58931 = lerp( ( appendResult3945_g58931 * appendResult3922_g58931 ) , ( appendResult3946_g58931 * appendResult3927_g58931 ) , break3936_g58931.y);
				float2 appendResult3944_g58931 = (float2(break3933_g58931.x , break3933_g58931.y));
				float2 appendResult3935_g58931 = (float2(-break3923_g58931.z , 1.0));
				float2 lerpResult3937_g58931 = lerp( lerpResult3918_g58931 , ( appendResult3944_g58931 * appendResult3935_g58931 ) , break3936_g58931.z);
				float2 temp_output_3906_0_g58931 = ( ( lerpResult3937_g58931 * (_RainDrop_ST).xy ) + (_RainDrop_ST).zw );
				float4 tex2DNode257_g58931 = SAMPLE_TEXTURE2D_GRAD( _RainDrop, sampler_RainDrop, temp_output_3906_0_g58931, ddx( temp_output_3906_0_g58931 ), ddy( temp_output_3906_0_g58931 ) );
				float temp_output_3696_0_g58931 = ( ( tex2DNode257_g58931.a * 4.0 ) - 2.0 );
				float temp_output_1818_0_g58931 = ( frac( ( tex2DNode257_g58931.b - ( _TimeParameters.x * _RainDropSpeed ) ) ) * saturate( temp_output_3696_0_g58931 ) );
				float lerpResult4008_g58931 = lerp( temp_output_1818_0_g58931 , ( temp_output_1818_0_g58931 + saturate( -temp_output_3696_0_g58931 ) ) , _RainDropStaticScale);
				float temp_output_3866_0_g58931 = ( (( ( lerpResult4008_g58931 * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) * ( pow( saturate( ( ( ( saturate( packedInput.normalWS.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) )*2.0 + -1.0) * ( 1.0 - ( _DecalOpacityGlobal + ( ( _CATEGORY_OPACITY + _SPACE_OPACITY ) * 0.0 ) ) ) );
				float3 worldToObj3854_g58931 = mul( GetWorldToObjectMatrix(), float4( packedInput.positionWS, 1 ) ).xyz;
				float3 temp_output_3855_0_g58931 = ( worldToObj3854_g58931 + float3( 0.5,0.5,0.5 ) );
				float3 break3859_g58931 = ( temp_output_3855_0_g58931 * ( 1.0 - temp_output_3855_0_g58931 ) );
				float temp_output_3861_0_g58931 = ( ( break3859_g58931.x * break3859_g58931.y ) * break3859_g58931.z );
				float lerpResult3865_g58931 = lerp( temp_output_3866_0_g58931 , ( temp_output_3866_0_g58931 * saturate( ( ( temp_output_3861_0_g58931 * temp_output_3861_0_g58931 ) * _EdgeMaskSharpness ) ) ) , _DecalEdgeMask);
				
				float4 appendResult3767_g58931 = (float4(1.0 , tex2DNode257_g58931.r , 0.0 , tex2DNode257_g58931.g));
				float3 unpack3768_g58931 = UnpackNormalScale( appendResult3767_g58931, _RainDropNormalScale );
				unpack3768_g58931.z = lerp( 1, unpack3768_g58931.z, saturate(_RainDropNormalScale) );
				float3 normalizeResult3770_g58931 = ASESafeNormalize( unpack3768_g58931 );
				

				surfaceDescription.BaseColor = _Color;
				surfaceDescription.Alpha = lerpResult3865_g58931;
				surfaceDescription.NormalTS = ( normalizeResult3770_g58931 * ( pow( saturate( ( ( ( saturate( packedInput.normalWS.y ) + -0.5 ) * 2.0 ) + 0.5 ) ) , 3.5 ) * ( _GlobalRainIntensity * ( _ENABLERAINDROPS + ( ( _CATEGORY_RAINDROPS + _CATEGORYSPACE_RAINDROPS ) * 0.0 ) ) ) ) );
				surfaceDescription.NormalAlpha = lerpResult3865_g58931;

				#if defined( _MATERIAL_AFFECTS_MAOS )
					surfaceDescription.Metallic = _MetallicStrength;
					surfaceDescription.Occlusion = saturate( ( 1.0 - _OcclusionStrengthAO ) );
					surfaceDescription.Smoothness = _SmoothnessStrength;
					surfaceDescription.MAOSAlpha = 1;
				#endif

				#if defined( _MATERIAL_AFFECTS_EMISSION )
					surfaceDescription.Emission = float3(0, 0, 0);
				#endif

				GetSurfaceData(packedInput, surfaceDescription, surfaceData);

				half3 normalToPack = surfaceData.normalWS.xyz;
				#ifdef DECAL_RECONSTRUCT_NORMAL
					surfaceData.normalWS.xyz = normalize(lerp(normalWS.xyz, surfaceData.normalWS.xyz, surfaceData.normalWS.w));
				#endif

					InputData inputData;
					InitializeInputData(packedInput, positionWS, surfaceData.normalWS.xyz, viewDirectionWS, inputData);

					SurfaceData surface = (SurfaceData)0;
					GetSurface(surfaceData, surface);

					BRDFData brdfData;
					InitializeBRDFData(surface.albedo, surface.metallic, 0, surface.smoothness, surface.alpha, brdfData);

				#ifdef _MATERIAL_AFFECTS_ALBEDO
					Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
					MixRealtimeAndBakedGI(mainLight, surfaceData.normalWS.xyz, inputData.bakedGI, inputData.shadowMask);
					half3 color = GlobalIllumination(brdfData, inputData.bakedGI, surface.occlusion, surfaceData.normalWS.xyz, inputData.viewDirectionWS);
				#else
					half3 color = 0;
				#endif

				#pragma warning (disable : 3578) // The output value isn't completely initialized.
				half3 packedNormalWS = PackNormal(normalToPack);
				fragmentOutput.GBuffer0 = half4(surfaceData.baseColor.rgb, surfaceData.baseColor.a);
				fragmentOutput.GBuffer1 = 0;
				fragmentOutput.GBuffer2 = half4(packedNormalWS, surfaceData.normalWS.a);
				fragmentOutput.GBuffer3 = half4(surfaceData.emissive + color, surfaceData.baseColor.a);
				#if OUTPUT_SHADOWMASK
					fragmentOutput.GBuffer4 = inputData.shadowMask;
				#endif
				#pragma warning (default : 3578) // Restore output value isn't completely initialized.

				

			}

            ENDHLSL
        }

		
        Pass
        {
            
			Name "ScenePickingPass"
            Tags { "LightMode"="Picking" }

            Cull Back

			HLSLPROGRAM

			#define _MATERIAL_AFFECTS_ALBEDO 1
			#define _MATERIAL_AFFECTS_NORMAL_BLEND 1
			#define  _MATERIAL_AFFECTS_MAOS 1
			#define _MATERIAL_AFFECTS_NORMAL 1
			#define ASE_VERSION 19901
			#define ASE_SRP_VERSION 140012
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma multi_compile_instancing
			#pragma editor_sync_compilation
			#pragma vertex Vert
			#pragma fragment Frag

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"

            #define HAVE_MESH_MODIFICATION

            #define SHADERPASS SHADERPASS_DEPTHONLY
			#define SCENEPICKINGPASS 1

			#if _RENDER_PASS_ENABLED
			#define GBUFFER3 0
			#define GBUFFER4 1
			FRAMEBUFFER_INPUT_HALF(GBUFFER3);
			FRAMEBUFFER_INPUT_HALF(GBUFFER4);
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
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DecalInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderVariablesDecal.hlsl"

			

			struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

            CBUFFER_START(UnityPerMaterial)
			float4 _RainDrop_ST;
			float3 _Color;
			float _CATEGORYSPACE_RAINDROPS;
			half _MetallicStrength;
			float _RainDropNormalScale;
			float _DecalEdgeMask;
			float _EdgeMaskSharpness;
			float _SPACE_OPACITY;
			float _CATEGORY_OPACITY;
			half _DecalOpacityGlobal;
			float _ENABLERAINDROPS;
			float _GlobalRainIntensity;
			float _RainDropStaticScale;
			float _RainDropSpeed;
			float _CATEGORY_RAINDROPS;
			half _OcclusionStrengthAO;
			half _SmoothnessStrength;
			float _DrawOrder;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;
			#if defined(DECAL_ANGLE_FADE)
			float _DecalAngleFadeSupported;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
				float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
            #endif

			

			
            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR)
            #define DECAL_PROJECTOR
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_MESH) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_MESH
            #endif

            #if (SHADERPASS == SHADERPASS_DBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DBUFFER_MESH)
            #define DECAL_DBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_SCREEN_SPACE_MESH)
            #define DECAL_SCREEN_SPACE
            #endif

            #if (SHADERPASS == SHADERPASS_DECAL_GBUFFER_PROJECTOR) || (SHADERPASS == SHADERPASS_DECAL_GBUFFER_MESH)
            #define DECAL_GBUFFER
            #endif

            #if (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_PROJECTOR) || (SHADERPASS == SHADERPASS_FORWARD_EMISSIVE_MESH)
            #define DECAL_FORWARD_EMISSIVE
            #endif

            #if ((!defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_ALBEDO)) || (defined(_MATERIAL_AFFECTS_NORMAL) && defined(_MATERIAL_AFFECTS_NORMAL_BLEND))) && (defined(DECAL_SCREEN_SPACE) || defined(DECAL_GBUFFER))
            #define DECAL_RECONSTRUCT_NORMAL
            #elif defined(DECAL_ANGLE_FADE)
            #define DECAL_LOAD_NORMAL
            #endif

            #ifdef _DECAL_LAYERS
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareRenderingLayerTexture.hlsl"
            #endif

            #if defined(DECAL_LOAD_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
            #endif

            #if defined(DECAL_PROJECTOR) || defined(DECAL_RECONSTRUCT_NORMAL)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #endif

            #ifdef DECAL_MESH
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DecalMeshBiasTypeEnum.cs.hlsl"
            #endif

            #ifdef DECAL_RECONSTRUCT_NORMAL
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/NormalReconstruction.hlsl"
            #endif

			PackedVaryings Vert(Attributes inputMesh  )
			{
				PackedVaryings packedOutput;
				ZERO_INITIALIZE(PackedVaryings, packedOutput);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, packedOutput);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(packedOutput);

				inputMesh.tangentOS = float4( 1, 0, 0, -1 );
				inputMesh.normalOS = float3( 0, 1, 0 );

				

				float3 positionWS = TransformObjectToWorld(inputMesh.positionOS);
				packedOutput.positionCS = TransformWorldToHClip(positionWS);

				return packedOutput;
			}

			void Frag(PackedVaryings packedInput,
				out float4 outColor : SV_Target0
				
			)
			{
				

				float3 BaseColor = _Color;

				outColor = _SelectionID;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;157;-512,-32;Inherit;False;LS Weather Decal Rain Drops;0;;58931;441b8eb6aac40b7478f406dc09f36b97;0;0;8;FLOAT3;3847;FLOAT;3877;FLOAT3;41;FLOAT;3878;FLOAT;3850;FLOAT;3849;FLOAT;3848;FLOAT;3879
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;103;0,0;Float;False;False;-1;2;DE_ShaderGUIDecal;0;14;New Amplify Shader;c2a467ab6d5391a4ea692226d82ffefd;True;DBufferProjector;0;0;DBufferProjector;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;3;True;12;all;0;False;True;2;5;False;;10;False;;1;0;False;;10;False;;False;False;True;2;5;False;;10;False;;1;0;False;;10;False;;False;False;True;2;5;False;;10;False;;1;0;False;;10;False;;False;False;False;False;False;False;True;1;False;;False;False;False;True;True;True;True;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;True;2;False;;True;2;False;;False;True;1;LightMode=DBufferProjector;False;True;9;d3d11;metal;vulkan;xboxone;xboxseries;playstation;ps4;ps5;switch;0;Hidden/DE/Utility/Fallback;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;104;0,0;Float;False;False;-1;2;DE_ShaderGUIDecal;0;14;New Amplify Shader;c2a467ab6d5391a4ea692226d82ffefd;True;DecalProjectorForwardEmissive;0;1;DecalProjectorForwardEmissive;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;3;True;12;all;0;False;True;8;5;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;2;False;;False;True;1;LightMode=DecalProjectorForwardEmissive;False;False;0;Hidden/DE/Utility/Fallback;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;106;0,0;Float;False;False;-1;2;DE_ShaderGUIDecal;0;14;New Amplify Shader;c2a467ab6d5391a4ea692226d82ffefd;True;DecalGBufferProjector;0;3;DecalGBufferProjector;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;3;True;12;all;0;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;True;1;False;;False;False;False;True;False;False;False;False;0;False;;False;True;True;True;True;False;0;False;;False;True;True;True;True;False;0;False;;False;False;False;True;2;False;;True;2;False;;False;True;1;LightMode=DecalGBufferProjector;False;False;0;Hidden/DE/Utility/Fallback;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;107;0,0;Float;False;False;-1;2;DE_ShaderGUIDecal;0;14;New Amplify Shader;c2a467ab6d5391a4ea692226d82ffefd;True;DBufferMesh;0;4;DBufferMesh;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;3;True;12;all;0;False;True;2;5;False;;10;False;;1;0;False;;10;False;;False;False;True;2;5;False;;10;False;;1;0;False;;10;False;;False;False;True;2;5;False;;10;False;;1;0;False;;10;False;;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;True;2;False;;True;3;False;;False;True;1;LightMode=DBufferMesh;False;False;0;Hidden/DE/Utility/Fallback;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;108;0,0;Float;False;False;-1;2;DE_ShaderGUIDecal;0;14;New Amplify Shader;c2a467ab6d5391a4ea692226d82ffefd;True;DecalMeshForwardEmissive;0;5;DecalMeshForwardEmissive;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;3;True;12;all;0;False;True;8;5;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;3;False;;False;True;1;LightMode=DecalMeshForwardEmissive;False;False;0;Hidden/DE/Utility/Fallback;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;109;0,0;Float;False;False;-1;2;DE_ShaderGUIDecal;0;14;New Amplify Shader;c2a467ab6d5391a4ea692226d82ffefd;True;DecalScreenSpaceMesh;0;6;DecalScreenSpaceMesh;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;3;True;12;all;0;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;3;False;;False;True;1;LightMode=DecalScreenSpaceMesh;False;False;0;Hidden/DE/Utility/Fallback;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;110;0,0;Float;False;False;-1;2;DE_ShaderGUIDecal;0;14;New Amplify Shader;c2a467ab6d5391a4ea692226d82ffefd;True;DecalGBufferMesh;0;7;DecalGBufferMesh;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;3;True;12;all;0;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;True;False;False;False;False;0;False;;False;True;True;True;True;False;0;False;;False;True;True;True;True;False;0;False;;False;False;False;True;2;False;;False;False;True;1;LightMode=DecalGBufferMesh;False;False;0;Hidden/DE/Utility/Fallback;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;111;0,0;Float;False;False;-1;2;DE_ShaderGUIDecal;0;14;New Amplify Shader;c2a467ab6d5391a4ea692226d82ffefd;True;ScenePickingPass;0;8;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;Hidden/DE/Utility/Fallback;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;105;-160,-32;Float;False;True;-1;2;LS_ShaderGUI;0;14;LS/Weather/Decal Rain Drops;c2a467ab6d5391a4ea692226d82ffefd;True;DecalScreenSpaceProjector;0;2;DecalScreenSpaceProjector;9;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;PreviewType=Plane;DisableBatching=LODFading=DisableBatching;ShaderGraphShader=true;ShaderGraphTargetId=UniversalDecalSubTarget;True;5;True;12;all;0;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;2;False;;False;True;1;LightMode=DecalScreenSpaceProjector;False;False;0;;0;0;Standard;7;Affect BaseColor;1;0;Affect Normal;1;638771568534097083;  Blend;1;0;Affect MAOS;1;638746634630267816;Affect Emission;0;638177062851898892;Support LOD CrossFade;1;638177062874429604;Angle Fade;1;0;0;9;True;False;True;True;True;False;True;True;True;False;;True;0
WireConnection;105;0;157;3847
WireConnection;105;1;157;3877
WireConnection;105;2;157;41
WireConnection;105;3;157;3878
WireConnection;105;4;157;3850
WireConnection;105;5;157;3849
WireConnection;105;6;157;3848
WireConnection;105;7;157;3879
ASEEND*/
//CHKSM=92898327EFCFEF1B33DE3BF4097855D20C0A80D4