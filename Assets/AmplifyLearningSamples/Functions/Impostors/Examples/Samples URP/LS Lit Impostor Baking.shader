// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/LS/Lit Impostor Baking"
{
	Properties
    {
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[LS_DrawerCategory(SURFACE SETTINGS,true,_Cull,0,0)] _CATEGORY_SURFACESETTINGS( "CATEGORY_SURFACE SETTINGS", Float ) = 1
		[HideInInspector][Enum(Front,2,Back,1,Both,0)] _Cull( "Render Face", Int ) = 2
		[LS_DrawerCategorySpace(10)] _SPACE_SURFACESETTINGS( "SPACE_SURFACE SETTINGS", Float ) = 0
		[LS_DrawerCategory(ALPHA,true,_Cutoff,0,0)] _CATEGORY_ALPHA( "CATEGORY_ALPHA", Float ) = 1
		[LS_DrawerToggleLeft] _AlphaClip( "Alpha Cutoff Enable", Float ) = 1
		_Cutoff( "Alpha Cutoff", Range( 0, 1 ) ) = 0.5
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
		[LS_DrawerCategory(EMISSION,true,_EmissionColor,0,0)] _CATEGORY_EMISSION( "CATEGORY_EMISSION", Float ) = 1
		[LS_DrawerToggleLeft] _EnableEmission( "ENABLE EMISSION", Float ) = 0
		[HDR] _EmissionColor( "Emissive Color", Color ) = ( 0, 0, 0, 0 )
		[LS_DrawerTextureSingleLine] _EmissionMap( "Emissive Color Map", 2D ) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3)] _UVEmissive( "UV Set", Float ) = 0
		[LS_DrawerTextureScaleOffset] _EmissionMap_ST( "Emissive UVs", Vector ) = ( 1, 1, 0, 0 )
		[LS_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 0
		_EmissiveIntensity( "Emissive Intensity", Float ) = 1
		[LS_DrawerCategorySpace(10)] _CATEGORYSPACE_EMISSION( "CATEGORYSPACE_EMISSION", Float ) = 0

    }

    SubShader
    {
		LOD 0

		

        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Cull [_Cull]
		HLSLINCLUDE
		#pragma target 4.5
		ENDHLSL

		
        Pass
        {
            Tags { "LightMode"="UniversalForward" }
            Name "Base"

            Blend One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

            HLSLPROGRAM
            #define ASE_VERSION 19901
            #define ASE_SRP_VERSION 140012
            #define ASE_USING_SAMPLING_MACROS 1

            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            

            // -------------------------------------
            // Lightweight Pipeline keywords
            #pragma shader_feature _SAMPLE_GI

            // -------------------------------------
            // Unity defined keywords
            #pragma multi_compile_fog

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #pragma vertex vert
            #pragma fragment frag

            #define ASE_NEEDS_TEXTURE_COORDINATES0
            #define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
            #define ASE_NEEDS_TEXTURE_COORDINATES1
            #define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
            #define ASE_NEEDS_TEXTURE_COORDINATES2
            #define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
            #define ASE_NEEDS_TEXTURE_COORDINATES3
            #define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
            #define ASE_NEEDS_VERT_NORMAL


            // Lighting include is needed because of GI
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			TEXTURE2D(_BaseMap);
			SAMPLER(sampler_BaseMap);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			TEXTURE2D(_SpecGlossMap);
			TEXTURE2D(_OcclusionMap);
			TEXTURE2D(_EmissionMap);
			SAMPLER(sampler_EmissionMap);
			float3 _AI_BoundsMin;
			float3 _AI_BoundsSize;
			CBUFFER_START( UnityPerMaterial )
			float4 _SpecColor;
			float4 _BaseMap_ST;
			float4 _BaseColor;
			float4 _EmissionMap_ST;
			float4 _EmissionColor;
			float _CATEGORY_SURFACESETTINGS;
			float _OcclusionStrength;
			float _UVEmissive;
			half _EmissiveIntensity;
			half _EmissionFlags;
			float _EnableEmission;
			float _CATEGORY_EMISSION;
			float _CATEGORYSPACE_EMISSION;
			float _AlphaClip;
			half _Cutoff;
			float _Glossiness;
			float _GlossMapScale;
			float _CATEGORY_SPECULAR;
			float _CATEGORY_ALPHA;
			float _Smoothnesstexturechannel;
			half _DoubleSidedNormalMode;
			float _BumpScale;
			float _CATEGORYSPACE_SURFACEINPUTS;
			float _CATEGORY_SURFACEINPUTS;
			float _CATEGORYSPACE_COLOR;
			float _CATEGORY_COLOR;
			half _Brightness;
			float _UVBase;
			float _SPACE_SURFACESETTINGS;
			int _Cull;
			float _CATEGORYSPACE_SPECULAR;
			float _CATEGORYSPACE_ALPHA;
			CBUFFER_END


            struct GraphVertexInput
            {
                float4 vertex : POSITION;
				float4 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_tangent : TANGENT;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct GraphVertexOutput
            {
                float4 position : POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

			float2 float2switchUVMode566_g59349( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			
			float2 float2switchUVMode592_g59349( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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
			

            GraphVertexOutput vert (GraphVertexInput v)
            {
                GraphVertexOutput o = (GraphVertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float3 ase_tangentWS = TransformObjectToWorldDir( v.ase_tangent.xyz );
				o.ase_texcoord2.xyz = ase_tangentWS;
				float3 ase_normalWS = TransformObjectToWorldNormal( v.ase_normal.xyz );
				o.ase_texcoord3.xyz = ase_normalWS;
				float ase_tangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				o.ase_texcoord4.xyz = ase_bitangentWS;
				float4 ase_positionCS = TransformObjectToHClip( ( v.vertex ).xyz );
				float4 screenPos = ComputeScreenPos( ase_positionCS );
				o.ase_texcoord5 = screenPos;
				
				float3 ase_positionWS = TransformObjectToWorld( ( v.vertex ).xyz );
				o.ase_texcoord6.xyz = ase_positionWS;
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				o.ase_texcoord.zw = v.ase_texcoord1.xy;
				o.ase_texcoord1.xy = v.ase_texcoord2.xy;
				o.ase_texcoord1.zw = v.ase_texcoord3.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord6.w = 0;
				v.vertex.xyz +=  float3( 0, 0, 0 ) ;
                o.position = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }

			void frag( GraphVertexOutput IN , bool ase_vface : SV_IsFrontFace,
				out half4 outGBuffer0 : SV_Target0,
				out half4 outGBuffer1 : SV_Target1,
				out half4 outGBuffer2 : SV_Target2,
				out half4 outGBuffer3 : SV_Target3,
				out half4 outGBuffer4 : SV_Target4,
				out half4 outGBuffer5 : SV_Target5,
				out half4 outGBuffer6 : SV_Target6,
				out half4 outGBuffer7 : SV_Target7,
				out float outDepth : SV_Depth
			)
            {
				UNITY_SETUP_INSTANCE_ID( IN );
				float m_switch566_g59349 = _UVBase;
				float2 m_UV0566_g59349 = IN.ase_texcoord.xy;
				float2 m_UV1566_g59349 = IN.ase_texcoord.zw;
				float2 m_UV2566_g59349 = IN.ase_texcoord1.xy;
				float2 m_UV3566_g59349 = IN.ase_texcoord1.zw;
				float2 localfloat2switchUVMode566_g59349 = float2switchUVMode566_g59349( m_switch566_g59349 , m_UV0566_g59349 , m_UV1566_g59349 , m_UV2566_g59349 , m_UV3566_g59349 );
				float2 appendResult772_g59349 = (float2(_BaseMap_ST.x , _BaseMap_ST.y));
				float2 appendResult773_g59349 = (float2(_BaseMap_ST.z , _BaseMap_ST.w));
				float2 UV_BaseMap2637_g59349 = ( ( localfloat2switchUVMode566_g59349 * appendResult772_g59349 ) + appendResult773_g59349 );
				float4 temp_output_2_0_g61666 = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, UV_BaseMap2637_g59349 );
				float3 temp_output_2444_0_g59349 = ( (temp_output_2_0_g61666).rgb * (_BaseColor).rgb * ( _Brightness + ( ( _CATEGORY_COLOR + _CATEGORYSPACE_COLOR + _CATEGORY_SURFACEINPUTS + _CATEGORYSPACE_SURFACEINPUTS ) * 0.0 ) ) );
				float4 appendResult48_g61671 = (float4(temp_output_2444_0_g59349 , 1.0));
				
				float3 unpack268_g59349 = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV_BaseMap2637_g59349 ), _BumpScale );
				unpack268_g59349.z = lerp( 1, unpack268_g59349.z, saturate(_BumpScale) );
				float m_switch3120_g59349 = _DoubleSidedNormalMode;
				float3 m_Flip3120_g59349 = float3( -1, -1, -1 );
				float3 m_Mirror3120_g59349 = float3( 1, 1, -1 );
				float3 m_None3120_g59349 = float3( 1, 1, 1 );
				float3 local_NormalModefloat3switch3120_g59349 = _NormalModefloat3switch( m_switch3120_g59349 , m_Flip3120_g59349 , m_Mirror3120_g59349 , m_None3120_g59349 );
				float3 switchResult3114_g59349 = (((ase_vface>0)?(unpack268_g59349):(( unpack268_g59349 * local_NormalModefloat3switch3120_g59349 ))));
				float3 ase_tangentWS = IN.ase_texcoord2.xyz;
				float3 ase_normalWS = IN.ase_texcoord3.xyz;
				float3 ase_bitangentWS = IN.ase_texcoord4.xyz;
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 tanNormal119_g61671 = switchResult3114_g59349;
				float3 worldNormal119_g61671 = float3( dot( tanToWorld0, tanNormal119_g61671 ), dot( tanToWorld1, tanNormal119_g61671 ), dot( tanToWorld2, tanNormal119_g61671 ) );
				float4 screenPos = IN.ase_texcoord5;
				float ase_depthRaw = screenPos.z / screenPos.w;
				float4 appendResult110_g61671 = (float4((worldNormal119_g61671*0.5 + 0.5) , ase_depthRaw));
				
				float4 temp_output_2_0_g59351 = SAMPLE_TEXTURE2D( _SpecGlossMap, sampler_BaseMap, UV_BaseMap2637_g59349 );
				float Alpha_SpecGlossMap707_g59349 = (temp_output_2_0_g59351).a;
				float temp_output_3172_0_g59349 = ( (temp_output_2_0_g61666).a * 1.0 );
				float Alpha_BaseColor2431_g59349 = temp_output_3172_0_g59349;
				float temp_output_3636_0_g59349 = ( _Smoothnesstexturechannel + ( ( _CATEGORY_SPECULAR + _CATEGORYSPACE_SPECULAR ) * 0.0 ) );
				float lerpResult3621_g59349 = lerp( Alpha_SpecGlossMap707_g59349 , Alpha_BaseColor2431_g59349 , temp_output_3636_0_g59349);
				float lerpResult3619_g59349 = lerp( _GlossMapScale , _Glossiness , temp_output_3636_0_g59349);
				float4 appendResult44_g61671 = (float4(( (_SpecColor).rgb * (temp_output_2_0_g59351).rgb ) , ( lerpResult3621_g59349 * lerpResult3619_g59349 )));
				
				float4 tex2DNode610_g59349 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_BaseMap, UV_BaseMap2637_g59349 );
				float3 temp_cast_2 = (saturate( ( tex2DNode610_g59349.r * ( 1.0 - _OcclusionStrength ) ) )).xxx;
				float4 appendResult132_g61671 = (float4(temp_cast_2 , 1.0));
				
				half3 color3067_g59349 = IsGammaSpace() ? half3( 0.003921569, 0, 0 ) : half3( 0.000303527, 0, 0 );
				float m_switch592_g59349 = _UVEmissive;
				float2 m_UV0592_g59349 = IN.ase_texcoord.xy;
				float2 m_UV1592_g59349 = IN.ase_texcoord.zw;
				float2 m_UV2592_g59349 = IN.ase_texcoord1.xy;
				float2 m_UV3592_g59349 = IN.ase_texcoord1.zw;
				float2 localfloat2switchUVMode592_g59349 = float2switchUVMode592_g59349( m_switch592_g59349 , m_UV0592_g59349 , m_UV1592_g59349 , m_UV2592_g59349 , m_UV3592_g59349 );
				float2 appendResult593_g59349 = (float2(_EmissionMap_ST.x , _EmissionMap_ST.y));
				float2 appendResult595_g59349 = (float2(_EmissionMap_ST.z , _EmissionMap_ST.w));
				float2 UV_EmissiveMap597_g59349 = ( ( localfloat2switchUVMode592_g59349 * appendResult593_g59349 ) + appendResult595_g59349 );
				float3 lerpResult3649_g59349 = lerp( color3067_g59349 , ( (SAMPLE_TEXTURE2D( _EmissionMap, sampler_EmissionMap, UV_EmissiveMap597_g59349 )).rgb * ( (_EmissionColor).rgb * ( _EmissiveIntensity + ( _EmissionFlags * 0.0 ) ) ) ) , ( _EnableEmission + ( ( _CATEGORY_EMISSION + _CATEGORYSPACE_EMISSION ) * 0.0 ) ));
				float4 appendResult42_g61671 = (float4(lerpResult3649_g59349 , 1.0));
				
				float3 ase_positionWS = IN.ase_texcoord6.xyz;
				
				float lerpResult3842_g59349 = lerp( 1.0 , temp_output_3172_0_g59349 , _AlphaClip);
				#ifdef _ALPHATEST_ON
				float staticSwitch103_g61671 = ( lerpResult3842_g59349 - ( _Cutoff + ( ( _CATEGORY_ALPHA + _CATEGORYSPACE_ALPHA ) * 0.0 ) ) );
				#else
				float staticSwitch103_g61671 = 1.0;
				#endif
				

				outGBuffer0 = appendResult48_g61671;
				outGBuffer1 = appendResult110_g61671;
				outGBuffer2 = appendResult44_g61671;
				outGBuffer3 = appendResult132_g61671;
				outGBuffer4 = appendResult42_g61671;
				outGBuffer5 = float4( ( ( ase_positionWS - _AI_BoundsMin ) / _AI_BoundsSize ) , 0.0 );
				outGBuffer6 = 0;
				outGBuffer7 = 0;
				float alpha = staticSwitch103_g61671;
				#if _AlphaClip
					clip( alpha );
				#endif
				outDepth = IN.position.z;
            }
            ENDHLSL
        }
        
	}
	
	CustomEditor "LS_ShaderGUI"
	Fallback Off
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1198;4864,-1408;Inherit;False;LS Core Lit URP;3;;59349;53876622fa774744d8149dc81e17dda6;6,3095,1,3046,0,3050,0,3109,1,3116,1,3772,0;0;12;FLOAT3;3010;FLOAT3;3011;FLOAT3;3009;FLOAT3;3012;FLOAT3;3092;FLOAT;3015;FLOAT;3014;FLOAT;3013;FLOAT;3016;FLOAT;3032;FLOAT3;3856;FLOAT3;3857
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1201;5632,-1792;Inherit;False;356.7075;297.6782;SURFACE SETTINGS;3;1199;1152;1200;;0,0,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1189;5248,-1408;Inherit;False;LS Impostor Bake Input;-1;;61671;897b01a8e6a19314997a02ba2f4ba6cb;2,85,0,83,0;9;88;FLOAT3;0,0,0;False;92;FLOAT3;0,0,1;False;93;FLOAT3;0,0,0;False;90;FLOAT3;0,0,0;False;89;FLOAT;0;False;91;FLOAT;0;False;94;FLOAT3;0,0,0;False;95;FLOAT;0;False;96;FLOAT;0;False;7;FLOAT4;71;FLOAT4;68;FLOAT4;69;FLOAT4;70;FLOAT4;130;FLOAT3;138;FLOAT;72
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1200;5664,-1744;Inherit;False;Property;_CATEGORY_SURFACESETTINGS;CATEGORY_SURFACE SETTINGS;0;0;Create;True;0;0;0;True;1;LS_DrawerCategory(SURFACE SETTINGS,true,_Cull,0,0);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1152;5664,-1664;Inherit;False;Property;_Cull;Render Face;1;2;[HideInInspector];[Enum];Create;False;1;;0;1;Front,2,Back,1,Both,0;True;0;False;2;2;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1199;5664,-1584;Inherit;False;Property;_SPACE_SURFACESETTINGS;SPACE_SURFACE SETTINGS;2;0;Create;True;0;0;0;True;1;LS_DrawerCategorySpace(10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1161;5632,-1408;Float;False;True;-1;2;LS_ShaderGUI;0;20;Hidden/LS/Lit Impostor Baking;6ee191abcace33c46a5dd52068b074e0;True;Base;0;0;Base;10;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;0;True;_Cull;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;True;12;all;0;;0;0;Standard;1;Receive Shadows;1;0;0;1;True;False;;True;0
WireConnection;1189;88;1198;3010
WireConnection;1189;92;1198;3011
WireConnection;1189;93;1198;3009
WireConnection;1189;90;1198;3012
WireConnection;1189;91;1198;3015
WireConnection;1189;94;1198;3014
WireConnection;1189;95;1198;3013
WireConnection;1189;96;1198;3016
WireConnection;1161;0;1189;71
WireConnection;1161;1;1189;68
WireConnection;1161;2;1189;69
WireConnection;1161;3;1189;70
WireConnection;1161;4;1189;130
WireConnection;1161;5;1189;138
WireConnection;1161;8;1189;72
ASEEND*/
//CHKSM=5D43BE8D47A5675AA42E287614731E7E275DE687