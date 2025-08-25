#ifndef POM_CORE_HEIGHTDATA_WORLDUV_INCLUDED
#define POM_CORE_HEIGHTDATA_WORLDUV_INCLUDED

// Parallax Occlusion Mapping core for World-Position UVs and vertex-color blended height textures.
// HLSL-only include. No ShaderLab blocks. Safe to #include from URP/HDRP/Builtin HLSL.
//
// Contract
// - Height source: up to 4 height textures blended by weights (e.g., vertex color RGBA)
// - UVs: world-position XZ based (caller computes and passes uv, ddx, ddy)
// - POM output: displaced UV to use for sampling albedo/normal/metallic, etc.
//
// Usage (example):
//   float2 uvWS   = input.positionWS.xz * _HeightTiling + _HeightOffset;
//   float2 ddxWS  = ddx(uvWS);
//   float2 ddyWS  = ddy(uvWS);
//   float4 wRGBA  = input.color; // vertex color weights
//   float3 viewWS = GetWorldSpaceNormalizeViewDir(input.positionWS);
//   float3 viewTS = ComputeViewDirTS(input.positionWS, NormalWS, input.tangentWS, _WorldSpaceCameraPos);
//   float2 uvPOM  = POM_WSBlend(
//        uvWS, ddxWS, ddyWS,
//        NormalWS, viewWS, viewTS,
//        (int)_POMminmaxSample.x, (int)_POMminmaxSample.y, (int)_POMSidewallSteps,
//        _POMScale, _POMRefPlane, wRGBA,
//        _Height0, _Height1, _Height2, _Height3);
//   float3 baseCol = tex2D(_BaseMap, uvPOM, ddxWS, ddyWS).rgb;
//
// Notes
// - Caller is responsible for tiling/offset and using the same uvPOM for all texture samples to keep patterns aligned.
// - Ensure ddx/ddy are derived from the same base uv used in POM for proper mip selection.

#ifndef FLT_MIN
	#define FLT_MIN 1.175494351e-38F
#endif

// Build tangent space basis and compute view direction in tangent space.
inline float3 ComputeViewDirTS(float3 positionWS, float3 normalWS, float4 tangentWS, float3 cameraWS)
{
	float3 N = normalize(normalWS);
	float3 T = normalize(tangentWS.xyz);
	float  s = (tangentWS.w > 0.0) ? 1.0 : -1.0;
	float3 B = normalize(cross(N, T)) * s;

	float3 V = cameraWS - positionWS;
	float3 Vt;
	Vt.x = dot(V, T);
	Vt.y = dot(V, B);
	Vt.z = dot(V, N);
	return normalize(Vt);
}

// Height sampling with world-UV and RGBA weights blending up to 4 height textures.
// Provide samplers explicitly to avoid duplicate global declarations in includers.
inline float HeightAtWSBlend(float2 uv, float2 dx, float2 dy, float4 weights,
							 sampler2D H0, sampler2D H1, sampler2D H2, sampler2D H3)
{
	float4 w = saturate(weights);
	// Normalize weights if desired; comment out to preserve absolute mixing.
	float sumW = max(w.x + w.y + w.z + w.w, 1e-5);
	w /= sumW;

	float h0 = tex2Dgrad(H0, uv, dx, dy).r;
	float h1 = tex2Dgrad(H1, uv, dx, dy).r;
	float h2 = tex2Dgrad(H2, uv, dx, dy).r;
	float h3 = tex2Dgrad(H3, uv, dx, dy).r;
	return dot(float4(h0, h1, h2, h3), w);
}

// Parallax Occlusion Mapping using world-UV-based blended height.
// Returns displaced UV to be used for sampling surface textures.
inline float2 POM_WSBlend(
	float2 uvWS, float2 ddxWS, float2 ddyWS,
	float3 normalWS, float3 viewWS, float3 viewDirTS,
	int minSamples, int maxSamples, int sidewallSteps,
	float parallax, float refPlane, float4 weights,
	sampler2D H0, sampler2D H1, sampler2D H2, sampler2D H3)
{
	// View-dependent step count
	float ndotv = saturate(dot(normalize(normalWS), normalize(viewWS)));
	float numSteps = floor(lerp((float)maxSamples, (float)minSamples, ndotv));
	numSteps = max(numSteps, 1.0);

	float layerH = 1.0 / numSteps;
	float vz = max(viewDirTS.z, 1e-4);
	float2 plane = parallax * (viewDirTS.xy / vz);

	// Apply reference plane offset once
	float2 baseUV = uvWS + refPlane * plane;
	float2 deltaTex = -plane * layerH;

	// Raymarch state
	float2 prevOff = 0.0;
	float  prevZ   = 1.0;
	float  prevH   = 0.0;

	float2 currOff = deltaTex;
	float  currZ   = 1.0 - layerH;
	float  currH   = 0.0;

	// Fixed-step raymarch until we cross the height field
	[loop]
	for (int i = 0; i < (int)numSteps + 1; ++i)
	{
		currH = HeightAtWSBlend(baseUV + currOff, ddxWS, ddyWS, weights, H0, H1, H2, H3);
		if (currH > currZ) break;
		prevOff = currOff; prevZ = currZ; prevH = currH;
		currOff += deltaTex; currZ -= layerH;
	}

	// Sidewall refinement (secant-like)
	float2 finalOff = prevOff;
	[unroll]
	for (int s = 0; s < sidewallSteps; ++s)
	{
		float denom = (prevH - currH + currZ - prevZ);
		float t = (denom != 0.0) ? saturate((prevH - prevZ) / denom) : 0.0;
		finalOff = lerp(prevOff, currOff, t);

		float newZ = lerp(prevZ, currZ, t);
		float newH = HeightAtWSBlend(baseUV + finalOff, ddxWS, ddyWS, weights, H0, H1, H2, H3);

		// Select interval containing the intersection
		if (newH > newZ)
		{ currOff = finalOff; currZ = newZ; currH = newH; }
		else
		{ prevOff = finalOff; prevZ = newZ; prevH = newH; }
	}

	return baseUV + finalOff;
}

// Lightweight parallax-only (no occlusion) variant using a scalar height value.
// Useful when no height textures are available or for a cheaper fallback.
inline float2 ParallaxOnly_WSScalar(float2 uvWS, float3 viewDirTS, float parallax, float refPlane, float heightScalar)
{
	float vz = max(viewDirTS.z, 1e-4);
	float2 plane = parallax * (viewDirTS.xy / vz);
	return uvWS + (refPlane + heightScalar) * plane;
}

#endif // POM_CORE_HEIGHTDATA_WORLDUV_INCLUDED

