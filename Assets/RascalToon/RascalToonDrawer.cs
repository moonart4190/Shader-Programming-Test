#if UNITY_EDITOR
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;

namespace SnowRabbit
{
	public class RascalToonDrawer : ShaderGUI
	{
		private Material targetMat;

		private GUIStyle propertiesStyle, bigLabelStyle, smallLabelStyle, toggleButtonStyle, titleHelpBoxStyle, foldoutStyle, foldoutInsideStyle;
		private Texture2D iconTexture;
		private const int bigFontSize = 16, smallFontSize = 11;
		private string[] oldKeyWords;
		private Material originalMaterialCopy;
		private float originalShadowInten = 1f;
		private float originalShadowHardness = 1f;
		private Color originalShadowColor = Color.black;
		private MaterialEditor matEditor;
		private MaterialProperty[] matProperties;
		private static uint[] materialDrawers = new uint[] { 1, 2, 4, 8 };
		private static bool[] currEnabledDrawers;
		private static bool DefaultMaterialSettingsDrawer;
		private static bool EffectSettingsDrawer;
		private static bool OutlineSettingsDrawer;
		private static bool DitherSettingsDrawer;
		private static bool CustomFogSettingsDrawer;
		private const uint advancedConfigDrawer = 0;
		private const uint shadowSettingsDrawer = 1;
		private const uint metallicSettingsDrawer = 2;
		private const uint smoothnessSettingsDrawer = 3;

		// Copy/Paste functionality
		private static float copiedFloatValue;
		private static Vector4 copiedVectorValue;
		private static Color copiedColorValue;
		private static Texture copiedTextureValue;
		private static MaterialProperty.PropType copiedPropertyType = MaterialProperty.PropType.Float;
		private static bool hasClipboard = false;

		// Full Material Copy/Paste functionality
		[System.Serializable]
		private class MaterialPropertyData
		{
			public string name;
			public MaterialProperty.PropType type;
			public float floatValue;
			public Vector4 vectorValue;
			public Color colorValue;
			public Texture textureValue;

			public MaterialPropertyData(MaterialProperty property)
			{
				name = property.name;
				type = property.type;
				
				switch (property.type)
				{
					case MaterialProperty.PropType.Float:
					case MaterialProperty.PropType.Range:
						floatValue = property.floatValue;
						break;
					case MaterialProperty.PropType.Vector:
						vectorValue = property.vectorValue;
						break;
					case MaterialProperty.PropType.Color:
						colorValue = property.colorValue;
						break;
					case MaterialProperty.PropType.Texture:
						textureValue = property.textureValue;
						break;
				}
			}
		}

		private static List<MaterialPropertyData> copiedMaterialData;
		private static bool hasFullMaterialClipboard = false;

		// Define the property range of the effect
		private struct EffectPropertyRange
		{
			public int start;
			public int end;
			public bool noReset;

			public EffectPropertyRange(int start, int end, bool noReset = false)
			{
				this.start = start;
				this.end = end;
				this.noReset = noReset;
			}
		}
		private GameObject lastSelectedGameObject;

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			if (lastSelectedGameObject == null)
				lastSelectedGameObject = Selection.activeGameObject;

			foldoutStyle = new GUIStyle(GUI.skin.GetStyle("MiniPopup"));
			foldoutStyle.fontStyle = FontStyle.Bold;
			foldoutStyle.margin = new RectOffset(15, 15, 5, 5);
			foldoutStyle.padding = new RectOffset(7, 5, 5, 5);
			foldoutStyle.fixedHeight = 30;
			foldoutStyle.fontStyle = FontStyle.Bold;



			// public Styles
			foldoutInsideStyle = new GUIStyle(GUI.skin.GetStyle("MiniPopup"));
			foldoutInsideStyle.fontStyle = FontStyle.Bold;
			foldoutInsideStyle.margin = new RectOffset(20, 15, 2, 2);
			foldoutInsideStyle.padding = new RectOffset(7, 5, 3, 3);
			foldoutInsideStyle.fixedHeight = 25;
			foldoutInsideStyle.fontSize = 11;

			bigLabelStyle = new GUIStyle(EditorStyles.boldLabel);
			bigLabelStyle.fontSize = bigFontSize;
			matEditor = materialEditor;
			matProperties = properties;
			targetMat = materialEditor.target as Material;
			oldKeyWords = targetMat.shaderKeywords;
			propertiesStyle = new GUIStyle(EditorStyles.helpBox);
			propertiesStyle.margin = new RectOffset(0, 0, 0, 0);
			smallLabelStyle = new GUIStyle(EditorStyles.boldLabel);
			smallLabelStyle.fontSize = smallFontSize;
			toggleButtonStyle = new GUIStyle(GUI.skin.button) { alignment = TextAnchor.MiddleCenter, richText = true };
			// currEnabledDrawers가 null인 경우에만 초기화
			if (currEnabledDrawers == null)
			{
				currEnabledDrawers = new bool[materialDrawers.Length];
			}
			titleHelpBoxStyle = new GUIStyle(EditorStyles.helpBox)
			{
				padding = new RectOffset(15, 15, 5, 5),
				margin = new RectOffset(25, 25, 10, 10),
				fixedHeight = 160,
				stretchWidth = true
			};
			GUIStyle buttonStyle = new GUIStyle(GUI.skin.button)
			{
				fixedHeight = 22,
				padding = new RectOffset(5, 15, 3, 3),
				margin = new RectOffset(2, 2, 0, 5),
				normal = new GUIStyleState
				{
					textColor = new Color(0f, 1f, 0.769f),
				},
				hover = new GUIStyleState
				{
					textColor = new Color(0f, 1f, 1f),
				},
				fontStyle = FontStyle.Bold,
				alignment = TextAnchor.MiddleLeft,
				fontSize = 11,
				stretchWidth = true
			};

			// 기본적으로 모든 탭이 닫혀있음 (저장하지 않음)
			// currEnabledDrawers는 이미 false로 초기화되어 있으므로 추가 초기화 불필요

			iconTexture = (Texture2D)Resources.Load("Editor Textures/Logo");

			EditorGUILayout.Separator();
			DrawLine(Color.grey, 1, 3);

			// RascalToon Main Title
			EditorGUILayout.BeginHorizontal(titleHelpBoxStyle);
			{
				EditorGUILayout.BeginVertical();
				{
					// Title Section
					EditorGUILayout.BeginHorizontal();
					{
						GUIContent titleContent = new GUIContent("  RascalToon Basic", iconTexture);
						GUILayout.Label(titleContent, new GUIStyle(EditorStyles.boldLabel)
						{
							fontSize = 18,
							alignment = TextAnchor.MiddleLeft,
							imagePosition = ImagePosition.ImageLeft,
							richText = true,
							fixedHeight = 35,
							wordWrap = false,
							normal = new GUIStyleState { textColor = new Color(0f, 1f, 0.769f) },
							hover = new GUIStyleState { textColor = new Color(0f, 1f, 1f) },
							margin = new RectOffset(0, 0, 10, 10),
							padding = new RectOffset(0, 0, 0, 10),
							fixedWidth = 280
						});

						// Add version information
						GUIStyle versionStyle = new GUIStyle(EditorStyles.label)
						{
							fontSize = 12,
							alignment = TextAnchor.MiddleRight,
							normal = new GUIStyleState { textColor = new Color(0.7f, 0.7f, 0.7f) },
							padding = new RectOffset(0, 5, 10, 0)
						};

						GUILayout.FlexibleSpace(); // Reserve space between title and version
						GUILayout.Label(RascalToonShaderData.versionString, versionStyle);
					}
					EditorGUILayout.EndHorizontal();

					EditorGUILayout.BeginVertical(new GUIStyle(EditorStyles.helpBox)
					{
						padding = new RectOffset(10, 10, 10, 10),
						margin = new RectOffset(0, 0, 5, 5),
						stretchWidth = true
					});
					{
						GUIContent documentationContent = new GUIContent(" 문서 보기", EditorGUIUtility.IconContent("_Help").image);
						if (GUILayout.Button(documentationContent, buttonStyle))
						{
							OpenDocumentation();
						}
						GUIContent addComponentContent = new GUIContent(" RascalToon 컴포넌트 추가", EditorGUIUtility.IconContent("_Popup").image);
						if (GUILayout.Button(addComponentContent, buttonStyle))
						{
							AddRascalToonComponent();
						}

						EditorGUILayout.Space(5);

						// Full Material Copy/Paste buttons
						EditorGUILayout.BeginHorizontal();
						{
							GUIContent copyAllContent = new GUIContent(" 쉐이더 값 전체 복사", EditorGUIUtility.IconContent("TreeEditor.Duplicate").image);
							if (GUILayout.Button(copyAllContent, buttonStyle))
							{
								CopyFullMaterial();
							}

							GUIStyle pasteButtonStyle = new GUIStyle(buttonStyle);
							if (!hasFullMaterialClipboard)
							{
								pasteButtonStyle.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
							}

							EditorGUI.BeginDisabledGroup(!hasFullMaterialClipboard);
							GUIContent pasteAllContent = new GUIContent(" 쉐이더 값 전체 붙여넣기", EditorGUIUtility.IconContent("Clipboard").image);
							if (GUILayout.Button(pasteAllContent, pasteButtonStyle))
							{
								PasteFullMaterial();
								Save();
							}
							EditorGUI.EndDisabledGroup();
						}
						EditorGUILayout.EndHorizontal();
					}
					EditorGUILayout.EndVertical();
				}
				EditorGUILayout.EndVertical();
			}
			EditorGUILayout.EndHorizontal();

			DefaultMaterialSettingsDrawer = EditorGUILayout.BeginFoldoutHeaderGroup(DefaultMaterialSettingsDrawer, new GUIContent("  기본 머티리얼 설정", (Texture)Resources.Load("Editor Textures/DefaultSettings")), foldoutStyle);
			EditorGUILayout.EndFoldoutHeaderGroup();
			if (DefaultMaterialSettingsDrawer)
			{
				// Draw default material properties
				EditorGUILayout.Space(); EditorGUILayout.Space();
				EditorGUILayout.LabelField("BaseColor", EditorStyles.boldLabel);

				// Draw main texture and base color
				MaterialProperty mainTex = FindProperty("_MainTex", properties);
				if (mainTex != null)
					DrawPropertyWithReset(mainTex, "Base Map", "물체의 기본 색상 텍스쳐");

				MaterialProperty baseColor = FindProperty("_BaseColor", properties);
				if (baseColor != null) DrawPropertyWithReset(baseColor, "Base Color", "베이스 컬러(알베도) 값");

				EditorGUILayout.Space(); EditorGUILayout.Space();
				EditorGUILayout.LabelField("Normal", EditorStyles.boldLabel);

				MaterialProperty bumpMap = FindProperty("_BumpMap", properties);
				if (bumpMap != null) DrawPropertyWithReset(bumpMap, "Normal Map", "노말맵 텍스쳐");

				MaterialProperty bumpScale = FindProperty("_BumpScale", properties);
				if (bumpScale != null) DrawPropertyWithReset(bumpScale, "Normal Scale", "노말맵의 적용 강도를 조절합니다.");

				EditorGUILayout.Space(); EditorGUILayout.Space();
				EditorGUILayout.LabelField("Shadows", EditorStyles.boldLabel);

				MaterialProperty shadowInten = FindProperty("_ShadowInten", properties);
				if (shadowInten != null)
					DrawPropertyWithReset(shadowInten, "Shadow Intensity", "그림자의 영역을 조정합니다.");

				MaterialProperty shadowHardness = FindProperty("_ShadowHardness", properties);
				if (shadowHardness != null) DrawPropertyWithReset(shadowHardness, "Shadow Hardness", "그림자의 날카로움을 조정합니다.");

				MaterialProperty shadowColor = FindProperty("_ShadowColor", properties);
				if (shadowColor != null) DrawPropertyWithReset(shadowColor, "Shadow Color", "그림자의 색상을 조정합니다.");

				EditorGUILayout.Space(); EditorGUILayout.Space();
				EditorGUILayout.LabelField("Global Illumination(Baked Lightmap Only)", EditorStyles.boldLabel);

				MaterialProperty giStrength = FindProperty("_GlobalIlluminationStrength", properties);
				if (giStrength != null) DrawPropertyWithReset(giStrength, "Global Illumination Strength", "Global Illumination(전역 조명)의 강도를 조정합니다");

				MaterialProperty mlAffect = FindProperty("_MainLightColorAffect", properties);
				if (mlAffect != null) DrawPropertyWithReset(mlAffect, "Main Light Color Affect", "주광원의 색상에 영향을 받는 정도를 조정합니다. 0이면 백색광을 사용하고, 1이면 주광원의 색상을 그대로 사용합니다.");

				EditorGUILayout.Space();
				EditorGUILayout.LabelField("Ambient Occlusion (Baked Lightmap Only)", EditorStyles.boldLabel);

				MaterialProperty occlusionRange = FindProperty("_OcclusionRange", properties);
				if (occlusionRange != null) DrawPropertyWithReset(occlusionRange, "AO Range", "Ambient Occlusion(주변 차폐)의 범위를 조정합니다.");

				MaterialProperty occlusionAffect = FindProperty("_OcclusionAffect", properties);
				if (occlusionAffect != null) DrawPropertyWithReset(occlusionAffect, "AO Opacity", "Ambient Occlusion(주변 차폐)의 투명도를 조정합니다. \n 0이 불투명, 1이 완전 투명입니다.");
			}

			// Effect Settings (그림자, 스펙큘러, 매끄러움을 포함하는 큰 폴드)
			EffectSettingsDrawer = EditorGUILayout.BeginFoldoutHeaderGroup(EffectSettingsDrawer, new GUIContent("  효과 설정", (Texture)Resources.Load("Editor Textures/Color")), foldoutStyle);
			EditorGUILayout.EndFoldoutHeaderGroup();
			
			if (EffectSettingsDrawer)
			{
				// Shadow Settings
				// MaterialProperty shadowInten = FindProperty("_ShadowInten", properties);
				// bool isShadowEnabled = shadowInten != null && shadowInten.floatValue > 0f;
				
				// Shadow On/Off Toggle Button
				// EditorGUILayout.BeginHorizontal();
				// {
				// 	bool newShadowState = DrawEffectToggleButton("_ShadowInten", isShadowEnabled);
				// 	if (newShadowState != isShadowEnabled)
				// 	{
				// 		if (newShadowState)
				// 		{
				// 			// ON으로 바뀔 때 원래 값으로 복원
				// 			if (shadowInten != null) shadowInten.floatValue = originalShadowInten;
				// 			MaterialProperty shadowHardness = FindProperty("_ShadowHardness", properties);
				// 			if (shadowHardness != null) shadowHardness.floatValue = originalShadowHardness;
				// 			MaterialProperty shadowColor = FindProperty("_ShadowColor", properties);
				// 			if (shadowColor != null) shadowColor.colorValue = originalShadowColor;
				// 		}
				// 		else
				// 		{
				// 			// OFF로 바뀔 때 현재 값들을 저장하고 0으로 설정
				// 			if (shadowInten != null)
				// 			{
				// 				originalShadowInten = shadowInten.floatValue;
				// 				shadowInten.floatValue = 0f;
				// 			}
				// 			MaterialProperty shadowHardness = FindProperty("_ShadowHardness", properties);
				// 			if (shadowHardness != null)
				// 			{
				// 				originalShadowHardness = shadowHardness.floatValue;
				// 				shadowHardness.floatValue = 0f;
				// 			}
				// 			MaterialProperty shadowColor = FindProperty("_ShadowColor", properties);
				// 			if (shadowColor != null)
				// 			{
				// 				originalShadowColor = shadowColor.colorValue;
				// 				shadowColor.colorValue = Color.clear;
				// 			}
				// 		}
				// 		Save();
				// 	}
					
				// 	currEnabledDrawers[shadowSettingsDrawer] =
				// 	EditorGUILayout.BeginFoldoutHeaderGroup(currEnabledDrawers[shadowSettingsDrawer], new GUIContent("  그림자 설정", (Texture)Resources.Load("Editor Textures/Underlay")), foldoutStyle);
				// }
				// EditorGUILayout.EndHorizontal();
				// EditorGUILayout.EndFoldoutHeaderGroup();
				
				// if (currEnabledDrawers[shadowSettingsDrawer])
				// {
				// 	EditorGUILayout.Space();
				// 	EditorGUILayout.LabelField("Shadow Properties", EditorStyles.boldLabel);
				// 	EditorGUILayout.Space();

				// 	if (shadowInten != null) DrawPropertyWithReset(shadowInten, "Shadow Intensity");

				// 	// Only show other shadow properties if shadow is enabled
				// 	if (isShadowEnabled)
				// 	{
				// 		MaterialProperty shadowHardness = FindProperty("_ShadowHardness", properties);
				// 		if (shadowHardness != null) DrawPropertyWithReset(shadowHardness, "Shadow Hardness");

				// 		MaterialProperty shadowColor = FindProperty("_ShadowColor", properties);
				// 		if (shadowColor != null) DrawPropertyWithReset(shadowColor, "Shadow Color");
				// 	}
				// 	else
				// 	{
				// 		// Show message when shadow is disabled but folder is open
				// 		EditorGUILayout.HelpBox("그림자를 활성화하려면 위의 'Shadow Intensity'를 조정하거나 ON 버튼을 클릭하세요.", MessageType.Info);
				// 	}
				// }

				// Metallic Settings
				MaterialProperty metallicOn = FindProperty("_MetallicOn", properties);
				bool isMetallicEnabled = metallicOn != null && metallicOn.floatValue > 0.5f;

				// Metallic On/Off Toggle Button
				EditorGUILayout.BeginHorizontal();
				{
					DrawEffectToggleButton("_MetallicOn", isMetallicEnabled);
					currEnabledDrawers[metallicSettingsDrawer] =
					EditorGUILayout.BeginFoldoutHeaderGroup(currEnabledDrawers[metallicSettingsDrawer], new GUIContent("  메탈릭/스펙큘러 설정", (Texture)Resources.Load("Editor Textures/Alpha")), foldoutStyle);
				}
				EditorGUILayout.EndHorizontal();
				EditorGUILayout.EndFoldoutHeaderGroup();

				if (currEnabledDrawers[metallicSettingsDrawer])
				{
					EditorGUILayout.Space();
					EditorGUILayout.LabelField("Metallic & Smoothness", EditorStyles.boldLabel);

					if (metallicOn != null) DrawPropertyWithReset(metallicOn, "Metallic On", "메탈릭을 활성화합니다.");

					if (isMetallicEnabled)
					{
						MaterialProperty metallicGlossMap = FindProperty("_MetallicGlossMap", properties);
						if (metallicGlossMap != null) DrawPropertyWithReset(metallicGlossMap, "Metallic Map(Smoothness alpha)", "메탈릭 텍스쳐");

						MaterialProperty metallic = FindProperty("_Metallic", properties);
						if (metallic != null) DrawPropertyWithReset(metallic, "Metallic", "메탈릭 텍스쳐가 있어야 작동합니다.\n메탈릭 정도를 조정합니다. 0은 비금속, 1은 금속입니다.");

						MaterialProperty smoothness = FindProperty("_Smoothness", properties);
						if (smoothness != null) DrawPropertyWithReset(smoothness, "Smoothness", "Smoothness(매끄러움) 정도를 조정합니다. World Reflection 혹은 Reflection Probe에 영향을 받습니다.");

						EditorGUILayout.Space(); EditorGUILayout.Space();
						EditorGUILayout.LabelField("Indirect Specular", EditorStyles.boldLabel);

						MaterialProperty specularIntensity = FindProperty("_SpecularIntensity", properties);
						if (specularIntensity != null) DrawPropertyWithReset(specularIntensity, "Specular Intensity", "광원 반사의 강도를 조정합니다");

						MaterialProperty specularRange = FindProperty("_SpecularRange", properties);
						if (specularRange != null) DrawPropertyWithReset(specularRange, "Specular Range", "광원 반사의 범위를 조정합니다");

						MaterialProperty specularHardness = FindProperty("_SpecularHardness", properties);
						if (specularHardness != null) DrawPropertyWithReset(specularHardness, "Specular Hardness", "광원 반사의 날카로움 정도를 조정합니다");

					}
				}

				// Outline Settings
				EditorGUILayout.BeginHorizontal();
				MaterialProperty outlineToggle = FindProperty("_Outline", properties);
				bool isOutlineOn = outlineToggle != null && outlineToggle.floatValue > 0.5f;
				if (outlineToggle != null)
				{
					GUIStyle outlineButtonStyle = new GUIStyle(GUI.skin.button);
					outlineButtonStyle.fixedWidth = 60;
					outlineButtonStyle.margin = new RectOffset(0, 20, 5, 0);
					outlineButtonStyle.normal.textColor = isOutlineOn ? Color.green : Color.white;
					outlineButtonStyle.fontStyle = FontStyle.Bold;
					if (GUILayout.Button(isOutlineOn ? "ON" : "OFF", outlineButtonStyle))
					{
						outlineToggle.floatValue = isOutlineOn ? 0f : 1f;
						Save();
					}
				}
				OutlineSettingsDrawer = EditorGUILayout.BeginFoldoutHeaderGroup(OutlineSettingsDrawer, new GUIContent("  아웃라인 설정", (Texture)Resources.Load("Editor Textures/Underlay")), foldoutInsideStyle);
				EditorGUILayout.EndHorizontal();
				EditorGUILayout.EndFoldoutHeaderGroup();
				if (OutlineSettingsDrawer)
				{
					EditorGUILayout.Space();
					EditorGUILayout.LabelField("Outline Properties", EditorStyles.boldLabel);
					EditorGUILayout.Space();
					EditorGUILayout.HelpBox("이 쉐이더는 아웃라인 기능을 꺼도 항상 아웃라인이 숨겨져 그려집니다. \n(항상 2배 이상의 버텍스 카운트가 메모리에 올라갑니다.) \n아웃라인을 쓰지 않으려면 아웃라인 효과가 없는 라스칼툰 쉐이더를 사용하시기를 추천합니다. On/Off 버튼은 실험적인 기능입니다.", MessageType.Info);

					if (outlineToggle != null) DrawPropertyWithReset(outlineToggle, "Outline", "아웃라인 효과를 활성화합니다. 이 쉐이더는 항상 아웃라인을 그립니다. 아웃라인 효과를 비활성화하려면 아웃라인이 포함되지 않은 쉐이더 사용을 추천합니다.");

					EditorGUI.BeginDisabledGroup(!isOutlineOn); // _Outline이 켜져 있을 때만 아래 항목 활성화

					MaterialProperty outlineWidth = FindProperty("_OutlineWidth", properties);
					if (outlineWidth != null) DrawPropertyWithReset(outlineWidth, "Outline Width", "아웃라인의 두께를 조정합니다.");

					MaterialProperty distanceCutoff = FindProperty("_DistanceCutoff", properties);
					if (distanceCutoff != null) DrawPropertyWithReset(distanceCutoff, "Distance Cutoff", "아웃라인의 거리에 따른 보정을 제어합니다. \n\n 멀리 있는 물체의 아웃라인의 두께를 조정합니다. \n 값이 작을수록 멀리 있는 물체는 더 얇은 아웃라인을 그립니다.");

					MaterialProperty outlineMapToggle = FindProperty("_OutlineMap", properties);
					if (outlineMapToggle != null) DrawPropertyWithReset(outlineMapToggle, "Use Outline Map", "아웃라인의 두께를 텍스쳐로 세부조정합니다.");

					if (outlineMapToggle != null && outlineMapToggle.floatValue > 0.5f)
					{
						MaterialProperty outlineThickness = FindProperty("_OutlineThickness", properties);
						if (outlineThickness != null) DrawPropertyWithReset(outlineThickness, "Outline Thickness Map", "아웃라인의 두께 텍스쳐");
					}

					EditorGUI.EndDisabledGroup();
				}

				// Dither Settings
				EditorGUILayout.BeginHorizontal();
				MaterialProperty ditherOn = FindProperty("_DitherOn", properties);
				bool isDitherEnabled = ditherOn != null && ditherOn.floatValue > 0.5f;
				if (ditherOn != null)
				{
					// ON/OFF 버튼 (스펙큘러 방식과 동일)
					GUIStyle ditherButtonStyle = new GUIStyle(GUI.skin.button);
					ditherButtonStyle.fixedWidth = 60;
					ditherButtonStyle.margin = new RectOffset(0, 20, 5, 0);
					ditherButtonStyle.normal.textColor = isDitherEnabled ? Color.green : Color.white;
					ditherButtonStyle.fontStyle = FontStyle.Bold;
					if (GUILayout.Button(isDitherEnabled ? "ON" : "OFF", ditherButtonStyle))
					{
						ditherOn.floatValue = isDitherEnabled ? 0f : 1f;
						Save();
					}
				}
				DitherSettingsDrawer = EditorGUILayout.BeginFoldoutHeaderGroup(DitherSettingsDrawer, new GUIContent("  디더링", (Texture)Resources.Load("Editor Textures/Alpha")), foldoutInsideStyle);
				EditorGUILayout.EndHorizontal();
				EditorGUILayout.EndFoldoutHeaderGroup();
				if (DitherSettingsDrawer)
				{
					EditorGUILayout.Space();
					EditorGUILayout.LabelField("Dither Properties", EditorStyles.boldLabel);
					EditorGUILayout.Space();

					if (ditherOn != null) DrawPropertyWithReset(ditherOn, "Dither On", "디더링을 활성화합니다.");

					isDitherEnabled = ditherOn != null && ditherOn.floatValue > 0.5f;
					if (isDitherEnabled)
					{
						MaterialProperty ditherDistance = FindProperty("_DitherDistance", properties);
						if (ditherDistance != null)
						{
							EditorGUILayout.BeginHorizontal();
							var label = new GUIContent("Dither Distance", "디더링 거리를 조정합니다. 메쉬의 피봇 기준으로부터 거리를 측정하여 동작합니다. 완전히 다가갔을 때 투명해지지 않는다면 최저값을 조금 올리는 것을 추천합니다.(X=min, Y=max)");
							EditorGUILayout.LabelField(label, GUILayout.Width(EditorGUIUtility.labelWidth - 5));

							Vector4 val = ditherDistance.vectorValue;
							float min = val.x;
							float max = val.y;

							EditorGUI.BeginChangeCheck();

							min = EditorGUILayout.FloatField(min, GUILayout.Width(40));
							EditorGUILayout.MinMaxSlider(ref min, ref max, 0f, 100f);
							max = EditorGUILayout.FloatField(max, GUILayout.Width(40));

							if (EditorGUI.EndChangeCheck())
							{
								if (min > max) min = max;
								if (min < 0f) min = 0f;
								if (max > 100f) max = 100f;
								ditherDistance.vectorValue = new Vector4(min, max, 0f, 0f);
							}

							// Copy button
							GUIContent copyButtonLabel = new GUIContent("C", "프로퍼티 값 복사");
							if (GUILayout.Button(copyButtonLabel, GUILayout.Width(20))) CopyProperty(ditherDistance);

							// Paste button
							GUIContent pasteButtonLabel = new GUIContent("P", "프로퍼티 값 붙여넣기");
							bool canPaste = hasClipboard && copiedPropertyType == ditherDistance.type;
							EditorGUI.BeginDisabledGroup(!canPaste);
							if (GUILayout.Button(pasteButtonLabel, GUILayout.Width(20))) 
							{
								PasteProperty(ditherDistance);
								Save();
							}
							EditorGUI.EndDisabledGroup();

							// Reset button
							GUIContent resetButtonLabel = new GUIContent("R", "기본값으로 초기화");
							if (GUILayout.Button(resetButtonLabel, GUILayout.Width(20)))
							{
								ResetProperty(ditherDistance);
							}
							EditorGUILayout.EndHorizontal();
						}

						MaterialProperty ditherSize = FindProperty("_DitherSize", properties);
						if (ditherSize != null) DrawPropertyWithReset(ditherSize, "Dither Size", "디더링의 크기를 조정합니다.");
					}
					else
					{
						EditorGUILayout.HelpBox("디더링을 활성화하려면 'Dither On/Off'를 체크하세요.", MessageType.Info);
					}
				}

				// Custom Fog Settings (standard toggle _CustomFogOn)
				MaterialProperty customFogOnProp = FindProperty("_CustomFogOn", properties, false);
				MaterialProperty fogColorProp = FindProperty("_FogColor", properties, false);
				MaterialProperty fogDensityProp = FindProperty("_FogDensity", properties, false);

				if (customFogOnProp != null || fogColorProp != null || fogDensityProp != null)
				{
					EditorGUILayout.BeginHorizontal();
					bool isCustomFogOn = customFogOnProp != null && customFogOnProp.floatValue > 0.5f;
					if (customFogOnProp != null)
					{
						DrawEffectToggleButton("_CustomFogOn", isCustomFogOn);
					}
					CustomFogSettingsDrawer = EditorGUILayout.BeginFoldoutHeaderGroup(CustomFogSettingsDrawer, new GUIContent("  커스텀 포그", (Texture)Resources.Load("Editor Textures/Color")), foldoutInsideStyle);
					EditorGUILayout.EndHorizontal();
					EditorGUILayout.EndFoldoutHeaderGroup();

					if (CustomFogSettingsDrawer)
					{
						EditorGUILayout.Space();
						EditorGUILayout.LabelField("Custom Fog", EditorStyles.boldLabel);

						EditorGUI.BeginDisabledGroup(!(customFogOnProp != null && customFogOnProp.floatValue > 0.5f));
						if (fogColorProp != null) DrawPropertyWithReset(fogColorProp, "Fog Color", "커스텀 포그 색상");
						if (fogDensityProp != null) DrawPropertyWithReset(fogDensityProp, "Fog Density", "커스텀 포그 밀도");
						EditorGUI.EndDisabledGroup();
					}
				}
			}

			// 탭 상태 저장하지 않음
		}


		private void OpenDocumentation()
		{
			Application.OpenURL("https://coral-adapter-b51.notion.site/2343a4122bf1809da319efae051a9729?pvs=74");
		}

		private void ResetProperty(MaterialProperty targetProperty)
		{
			if (originalMaterialCopy == null) originalMaterialCopy = new Material(targetMat.shader);
			if (targetProperty.type == MaterialProperty.PropType.Float || targetProperty.type == MaterialProperty.PropType.Range)
			{
				targetProperty.floatValue = originalMaterialCopy.GetFloat(targetProperty.name);
			}
			else if (targetProperty.type == MaterialProperty.PropType.Vector)
			{
				targetProperty.vectorValue = originalMaterialCopy.GetVector(targetProperty.name);
			}
			else if (targetProperty.type == MaterialProperty.PropType.Color)
			{
				targetProperty.colorValue = originalMaterialCopy.GetColor(targetProperty.name);
			}
			else if (targetProperty.type == MaterialProperty.PropType.Texture)
			{
				targetProperty.textureValue = originalMaterialCopy.GetTexture(targetProperty.name);
			}
		}

		private void CopyProperty(MaterialProperty property)
		{
			copiedPropertyType = property.type;
			hasClipboard = true;

			switch (property.type)
			{
				case MaterialProperty.PropType.Float:
				case MaterialProperty.PropType.Range:
					copiedFloatValue = property.floatValue;
					break;
				case MaterialProperty.PropType.Vector:
					copiedVectorValue = property.vectorValue;
					break;
				case MaterialProperty.PropType.Color:
					copiedColorValue = property.colorValue;
					break;
				case MaterialProperty.PropType.Texture:
					copiedTextureValue = property.textureValue;
					break;
			}
		}

		private void PasteProperty(MaterialProperty property)
		{
			if (!hasClipboard)
			{
				Debug.LogWarning("복사된 프로퍼티가 없습니다.");
				return;
			}

			if (copiedPropertyType != property.type)
			{
				Debug.LogWarning($"프로퍼티 타입이 일치하지 않습니다. 복사된 타입: {copiedPropertyType}, 현재 타입: {property.type}");
				return;
			}

			switch (property.type)
			{
				case MaterialProperty.PropType.Float:
				case MaterialProperty.PropType.Range:
					property.floatValue = copiedFloatValue;
					break;
				case MaterialProperty.PropType.Vector:
					property.vectorValue = copiedVectorValue;
					break;
				case MaterialProperty.PropType.Color:
					property.colorValue = copiedColorValue;
					break;
				case MaterialProperty.PropType.Texture:
					property.textureValue = copiedTextureValue;
					break;
			}
		}

		private void CopyFullMaterial()
		{
			if (matProperties == null || matProperties.Length == 0)
			{
				Debug.LogWarning("복사할 머티리얼 프로퍼티가 없습니다.");
				return;
			}

			copiedMaterialData = new List<MaterialPropertyData>();
			
			foreach (var property in matProperties)
			{
				// 숨겨진 프로퍼티만 제외
				if (property.flags.HasFlag(MaterialProperty.PropFlags.HideInInspector))
					continue;

				copiedMaterialData.Add(new MaterialPropertyData(property));
			}

			hasFullMaterialClipboard = true;
			Debug.Log($"총 {copiedMaterialData.Count}개의 프로퍼티가 복사되었습니다.");
		}

		private void PasteFullMaterial()
		{
			if (!hasFullMaterialClipboard || copiedMaterialData == null || copiedMaterialData.Count == 0)
			{
				Debug.LogWarning("복사된 머티리얼 데이터가 없습니다.");
				return;
			}

			int pastedCount = 0;
			int skippedCount = 0;

			foreach (var copiedData in copiedMaterialData)
			{
				MaterialProperty targetProperty = FindProperty(copiedData.name, matProperties);
				if (targetProperty == null)
				{
					skippedCount++;
					continue;
				}

				if (targetProperty.type != copiedData.type)
				{
					skippedCount++;
					continue;
				}

				switch (copiedData.type)
				{
					case MaterialProperty.PropType.Float:
					case MaterialProperty.PropType.Range:
						targetProperty.floatValue = copiedData.floatValue;
						break;
					case MaterialProperty.PropType.Vector:
						targetProperty.vectorValue = copiedData.vectorValue;
						break;
					case MaterialProperty.PropType.Color:
						targetProperty.colorValue = copiedData.colorValue;
						break;
					case MaterialProperty.PropType.Texture:
						targetProperty.textureValue = copiedData.textureValue;
						break;
				}

				pastedCount++;
			}

			Debug.Log($"총 {pastedCount}개의 프로퍼티가 적용되었습니다. (건너뛴 항목: {skippedCount}개)");
		}

		private void DrawPropertyWithReset(MaterialProperty property, string label = null, string tooltip = null)
		{
			EditorGUILayout.BeginHorizontal();
			{
				GUIContent propertyLabel = new GUIContent();
				propertyLabel.text = label ?? property.displayName;
				propertyLabel.tooltip = tooltip ?? property.name + " 쉐이더 프로퍼티";

				matEditor.ShaderProperty(property, propertyLabel);

				// Copy button
				GUIContent copyButtonLabel = new GUIContent();
				copyButtonLabel.text = "C";
				copyButtonLabel.tooltip = "프로퍼티 값 복사";
				if (GUILayout.Button(copyButtonLabel, GUILayout.Width(20))) CopyProperty(property);

				// Paste button
				GUIContent pasteButtonLabel = new GUIContent();
				pasteButtonLabel.text = "P";
				pasteButtonLabel.tooltip = "프로퍼티 값 붙여넣기";
				bool canPaste = hasClipboard && copiedPropertyType == property.type;
				EditorGUI.BeginDisabledGroup(!canPaste);
				if (GUILayout.Button(pasteButtonLabel, GUILayout.Width(20))) 
				{
					PasteProperty(property);
					Save();
				}
				EditorGUI.EndDisabledGroup();

				// Reset button
				GUIContent resetButtonLabel = new GUIContent();
				resetButtonLabel.text = "R";
				resetButtonLabel.tooltip = "기본값으로 초기화";
				if (GUILayout.Button(resetButtonLabel, GUILayout.Width(20))) ResetProperty(property);
			}
			EditorGUILayout.EndHorizontal();
		}
		// 탭 상태 저장 기능 제거 - 기본적으로 모든 탭이 닫혀있음

		private void Save()
		{
			if (matEditor != null && matEditor.targets != null)
			{
				foreach (var t in matEditor.targets)
				{
					var m = t as Material;
					if (m != null) EditorUtility.SetDirty(m);
				}
			}
			else if (targetMat != null)
			{
				EditorUtility.SetDirty(targetMat);
			}
			SetSceneDirty();
		}

		private void SetSceneDirty()
		{
			if (!Application.isPlaying) EditorSceneManager.MarkAllScenesDirty();

#if UNITY_2021_2_OR_NEWER
			var prefabStage = UnityEditor.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage();
#else
			var prefabStage = UnityEditor.Experimental.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage();
#endif
			if (prefabStage != null) EditorSceneManager.MarkSceneDirty(prefabStage.scene);
		}

		private void DrawLine(Color color, int thickness = 2, int padding = 10)
		{
			Rect r = EditorGUILayout.GetControlRect(GUILayout.Height(padding + thickness));
			r.height = thickness;
			r.y += padding / 2;
			r.x -= 2;
			r.width += 6;
			EditorGUI.DrawRect(r, color);
		}

		private bool DrawEffectToggleButton(string propertyName, bool isEnabled)
		{
			GUIStyle buttonStyle = new GUIStyle(GUI.skin.button);
			buttonStyle.fixedWidth = 60;
			buttonStyle.margin = new RectOffset(0, 20, 5, 0);
			buttonStyle.normal.textColor = isEnabled ? Color.green : Color.white;
			buttonStyle.fontStyle = FontStyle.Bold;

			if (GUILayout.Button(isEnabled ? "ON" : "OFF", buttonStyle))
			{
				MaterialProperty property = FindProperty(propertyName, matProperties);
				if (property != null)
				{
					// 그림자 토글의 경우 특별한 처리가 필요하므로 호출자가 처리하도록 함
					if (propertyName == "_ShadowInten")
					{
						return !isEnabled; // 상태만 반환하고 실제 값 변경은 호출자가 처리
					}
					
					property.floatValue = isEnabled ? 0f : 1f;
					Save();
					return !isEnabled; // 토글된 상태 반환
				}
			}

			return isEnabled; // 현재 상태 반환
		}

		private void AddRascalToonComponent()
		{
			if (lastSelectedGameObject == null)
			{
				Debug.LogWarning("게임오브젝트가 선택되지 않았습니다.");
				return;
			}

			if (targetMat == null)
			{
				Debug.LogWarning("머티리얼이 할당되지 않았습니다.");
				return;
			}

			// Check if GameObject has a Renderer component
			Renderer renderer = lastSelectedGameObject.GetComponent<Renderer>();
			if (renderer == null)
			{
				Debug.LogWarning("선택된 게임오브젝트는 렌더러 컴포넌트가 있어야 합니다.");
				return;
			}

			RascalToon existingComponent = lastSelectedGameObject.GetComponent<RascalToon>();
			if (existingComponent == null)
			{
				existingComponent = lastSelectedGameObject.AddComponent<RascalToon>();
				Debug.Log("RascalToon 컴포넌트가 추가되었습니다. " + lastSelectedGameObject.name);
			}
			else
			{
				Debug.Log("RascalToon 컴포넌트가 이미 존재합니다. " + lastSelectedGameObject.name);
			}

			try
			{
				// 현재 머티리얼을 컴포넌트에 할당
				existingComponent.AssignMaterial(targetMat);
			}
			catch (System.Exception e)
			{
				Debug.LogError($"머티리얼 할당에 실패했습니다: {e.Message}");
			}
		}
	}
}
#endif