// Shader 시작. 셰이더의 폴더와 이름을 여기서 결정합니다.
Shader "basic02"
{


    Properties
    {
        // Properties Block : 셰이더에서 사용할 변수를 선언하고 이를 material inspector에 노출시킵니다
        _TintColor ("Tint Color", Color) = (1, 1, 1, 1)
        _BaseMap ("Base Map", 2D) = "white" {}
        _2ndMap ("2nd Map", 2D) = "white" {}
    }

    SubShader
    {

        Tags 
        { 
            //Render type과 Render Queue를 여기서 결정합니다. 
            "RenderPipeline" = "UniversalPipeline" 
            "RenderType" = "Opaque" 
            "Queue" = "Geometry" 
        }
        Pass
        {
            Name "Universal Forward"
            Tags { "LightMode" = "UniversalForward" }

            HLSLPROGRAM

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag

            //cg shader는 .cginc를 hlsl shader는 .hlsl을 include하게 됩니다.
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            
            //vertex buffer에서 읽어올 정보를 선언합니다.
            struct VertexInput
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            //보간기를 통해 버텍스 셰이더에서 픽셀 셰이더로 전달할 정보를 선언합니다.
            struct VertexOutput
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            half4 _TintColor;

            //sampler2D _BaseMap;
            float4 _BaseMap_ST;
            float4 _2ndMap_ST;
            TEXTURE2D(_BaseMap);
            TEXTURE2D(_2ndMap);
            SAMPLER(sampler_BaseMap);

            //버텍스 셰이더
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.vertex = TransformObjectToHClip(v.vertex.xyz);
                o.uv = v.uv; // 원본 uv만 전달
                return o;
            }

            //픽셀 셰이더
            half4 frag(VertexOutput i) : SV_Target
            {
                float2 uv1 = i.uv * _BaseMap_ST.xy + _BaseMap_ST.zw;
                float2 uv2 = i.uv * _2ndMap_ST.xy + _2ndMap_ST.zw;
                half4 col01 = _BaseMap.Sample(sampler_BaseMap, uv1);
                half4 col02 = _2ndMap.Sample(sampler_BaseMap, uv2); // 같은 샘플러 사용

                half4 color = col01 * col02 * _TintColor;
                return color;
            }

            ENDHLSL
        }
    }
}
