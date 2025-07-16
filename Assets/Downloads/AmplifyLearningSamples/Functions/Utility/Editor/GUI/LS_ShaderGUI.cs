
using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using LearningSamples.Drawers;

public class LS_ShaderGUI : ShaderGUI
{

    bool showCategory = true;
    bool showAdvanced = false;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {

        var material0 = materialEditor.target as Material;
        //var materials = materialEditor.targets;

        //if (materials.Length > 1)
        //    multiSelection = true;

        DrawDynamicInspector(material0, materialEditor, props);

        //for each (Material material in materials)
        //{

        //} 
   
    }

    void DrawDynamicInspector(Material material, MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var customPropsList = new List<MaterialProperty>();
        //var customSpaces = new List<int>();
        //var customCategories = new List<int>();

        for (int i = 0; i < props.Length; i++)
        {
            var prop = props[i];

            #if UNITY_6000_2_OR_NEWER
            if (prop.propertyFlags == UnityEngine.Rendering.ShaderPropertyFlags.HideInInspector)
            #else
            if (prop.flags == MaterialProperty.PropFlags.HideInInspector)
            #endif
                continue;

            if (prop.name == "unity_Lightmaps")
                continue;
            if (prop.name == "unity_LightmapsInd")
                continue;
            if (prop.name == "unity_ShadowMasks")
                continue;
            if (prop.name == "_SpecularHighlights")
                continue;
            if (prop.name == "_GlossyReflections")
                continue;

            //example from LS file for making dynamic open/close
            //if _XXXXEnable = 0 the prop listed if below will be hidden
            if (material.HasProperty("_XXXXEnable"))
            {
                if (material.GetInt("_XXXXEnable") == 0)
                {
                    if (prop.name == "_XXXXOffset")
                        continue;
                    if (prop.name == "_XXXXIntensity")
                        continue;
                    if (prop.name == "_XXXXSpeed")
                        continue;
                }
            }

            #region [Smoothness BIRP Specular]
            if (material.HasProperty("_Smoothnesstexturechannel"))
            {
                if (material.GetInt("_Smoothnesstexturechannel") == 0)
                {
                    if (prop.name == "_Glossiness")
                        continue;
                }
            }
            if (material.HasProperty("_Smoothnesstexturechannel"))
            {
                if (material.GetInt("_Smoothnesstexturechannel") == 1)
                {
                    if (prop.name == "_GlossMapScale")
                        continue;
                }
            }
            #endregion [Smoothness BIRP Specular]

            #region [Smoothness BIRP Metallic]
            if (material.HasProperty("_SmoothnesstexturechannelM"))
            {
                if (material.GetInt("_SmoothnesstexturechannelM") == 0)
                {
                    if (prop.name == "_Glossiness")
                        continue;
                }
            }
            if (material.HasProperty("_SmoothnesstexturechannelM"))
            {
                if (material.GetInt("_SmoothnesstexturechannelM") == 1)
                {
                    if (prop.name == "_GlossMapScale")
                        continue;
                }
            }
            #endregion [Smoothness BIRP Metallic]

            #region [CATEGORY INDEX and SPACES]
            int categoryIndex = 1;

            //customPropsList.Add(prop);

            if (prop.name.Contains("_CATEGORY"))
            {
                categoryIndex++;

                customPropsList.Add(prop);

                if (material.GetInt(prop.name) == 0)
                {
                    showCategory = false;
                    //customCategories.Add(-categoryIndex);
                }
                else
                {
                    showCategory = true;
                    //customCategories.Add(categoryIndex);

                    categoryIndex++;
                }
            }
            else
            {
                if (showCategory)
                {
                    customPropsList.Add(prop);
                    //customCategories.Add(categoryIndex);
                }
            }

        }

        //customSpaces.Add(0);

        //for (int i = 1; i < customCategories.Count; i++)
        //{
        //    if (customCategories[i - 1] != customCategories[i])
        //    {
        //        if (customCategories[i - 1] > 0)
        //        {
        //            customSpaces.Add(10);
        //        }
        //        else
        //        {
        //            customSpaces.Add(0);
        //        }
        //    }
        //    else
        //    {
        //        customSpaces.Add(0);
        //    }
        //}

        //Draw Custom GUI
        for (int i = 0; i < customPropsList.Count; i++)
        {
            var prop = customPropsList[i];

            //GUILayout.Space(customSpaces[i]);

            materialEditor.ShaderProperty(prop, prop.displayName);

        }
        #endregion [CATEGORY INDEX and SPACES]

        #region [CATEGORY - ADVANCED SETTINGS]
        showAdvanced = LS_Drawers.DrawInspectorCategory("ADVANCED SETTINGS", showAdvanced, true, 0, 0, material);

        if (showAdvanced)
        {

            #region [HDRP Receive Decals]
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_SupportDecals"))
                {
                    if (material.HasProperty("_SupportDecals"))
                    {
                        var control = material.GetInt("_SupportDecals");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Receive Decals", toggle);

                        if (toggle)
                        {
                            material.SetInt("_SupportDecals", 1);
                            material.DisableKeyword("DECALS_OFF");
                        }
                        else
                        {
                            material.SetInt("_SupportDecals", 0);
                            material.EnableKeyword("DECALS_OFF");
                        }
                    }
                }
            #endregion [HDRP Receive Decals]

            #region [HDRP DECAL Affects Albedo]
            //#pragma shader_feature_local_fragment _MATERIAL_AFFECTS_ALBEDO
            //[ToggleUI]_AffectAlbedo("Boolean", Float) = 1
            if (material.HasProperty("_AffectAlbedo"))
            {
                if (material.HasProperty("_AffectAlbedo"))
                {
                    var control = material.GetInt("_AffectAlbedo");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Albedo", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectAlbedo", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_ALBEDO");
                    }
                    else
                    {
                        material.SetInt("_AffectAlbedo", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_ALBEDO");
                    }
                }
            }

            #endregion [HDRP DECAL Affects Albedo]

            #region [HDRP DECAL Affects Normal]
            //#pragma shader_feature_local_fragment _MATERIAL_AFFECTS_NORMAL
            //[ToggleUI]_AffectNormal("Boolean", Float) = 1
            if (material.HasProperty("_AffectNormal"))
            {
                if (material.HasProperty("_AffectNormal"))
                {
                    var control = material.GetInt("_AffectNormal");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Normal", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectNormal", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_NORMAL");
                    }
                    else
                    {
                        material.SetInt("_AffectNormal", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_NORMAL");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Normal]

            #region [HDRP DECAL Affects AO]
            //[ToggleUI]_AffectAO("Boolean", Float) = 0
            if (material.HasProperty("_AffectAO"))
            {
                if (material.HasProperty("_AffectAO"))
                {
                    var control = material.GetInt("_AffectAO");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects AO", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectAO", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_NORMAL_BLEND");
                    }
                    else
                    {
                        material.SetInt("_AffectAO", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_NORMAL_BLEND");
                    }
                }
            }
            #endregion [HDRP DECAL Affects AO]

            #region [HDRP DECAL Affects Metal]
            //[ToggleUI]_AffectMetal("Boolean", Float) = 1
            if (material.HasProperty("_AffectMetal"))
            {
                if (material.HasProperty("_AffectMetal"))
                {
                    var control = material.GetInt("_AffectMetal");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Metal", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectMetal", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_MAOS");
                    }
                    else
                    {
                        material.SetInt("_AffectMetal", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_MAOS");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Metal]

            #region [HDRP DECAL Affects Smoothness]
            //[ToggleUI]_AffectSmoothness("Boolean", Float) = 1
            if (material.HasProperty("_AffectSmoothness"))
            {
                if (material.HasProperty("_AffectSmoothness"))
                {
                    var control = material.GetInt("_AffectSmoothness");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Smoothness", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectSmoothness", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_MAOS");
                    }
                    else
                    {
                        material.SetInt("_AffectSmoothness", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_MAOS");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Smoothness]

            #region [HDRP DECAL Affects Emission]
            //[ToggleUI]_AffectEmission("Boolean", Float) = 0
            if (material.HasProperty("_AffectEmission"))
            {
                if (material.HasProperty("_AffectEmission"))
                {
                    var control = material.GetInt("_AffectEmission");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Emission", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectEmission", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_EMISSION");
                    }
                    else
                    {
                        material.SetInt("_AffectEmission", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_EMISSION");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Emission]

            #region [URP Receive Shadows]
            if (material.GetTag("RenderPipeline", false) == "UniversalPipeline")
                if (material.HasProperty("_ReceiveShadows"))
                {
                    if (material.HasProperty("_ReceiveShadows"))
                    {
                        var control = material.GetInt("_ReceiveShadows");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Receive Shadows", toggle);

                        if (toggle)
                        {
                            material.SetInt("_ReceiveShadows", 1);
                            material.DisableKeyword("_RECEIVE_SHADOWS_OFF");
                        }
                        else
                        {
                            material.SetInt("_ReceiveShadows", 0);
                            material.EnableKeyword("_RECEIVE_SHADOWS_OFF");
                        }
                    }
                }
            #endregion [URP Receive Shadows]

            #region [URP/BIRP SpecularHighlights _SpecularHighlights]
            if (material.HasProperty("_SpecularHighlights"))
            {
                if (material.HasProperty("_SpecularHighlights"))
                {
                    var control = material.GetInt("_SpecularHighlights");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Specular Highlights", toggle);

                    if (toggle)
                    {
                        material.SetInt("_SpecularHighlights", 1);
                        material.DisableKeyword("_SPECULARHIGHLIGHTS_OFF");
                    }
                    else
                    {
                        material.SetInt("_SpecularHighlights", 0);
                        material.EnableKeyword("_SPECULARHIGHLIGHTS_OFF");
                    }
                }
            }
            #endregion [URP/BIRP SpecularHighlights _SpecularHighlights]

            #region [BIRP Reflections _GlossyReflections]
            if (material.HasProperty("_GlossyReflections"))
            {
                if (material.HasProperty("_GlossyReflections"))
                {
                    var control = material.GetInt("_GlossyReflections");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Reflections", toggle);

                    if (toggle)
                    {
                        material.SetInt("_GlossyReflections", 1);
                        material.DisableKeyword("_GLOSSYREFLECTIONS_OFF");
                    }
                    else
                    {
                        material.SetInt("_GlossyReflections", 0);
                        material.EnableKeyword("_GLOSSYREFLECTIONS_OFF");
                    }
                }
            }
            #endregion [BIRP GlossyReflections / Reflections]

            #region [URP EnvironmentReflections _EnvironmentReflections]
            if (material.HasProperty("_EnvironmentReflections"))
            {
                if (material.HasProperty("_EnvironmentReflections"))
                {
                    var control = material.GetInt("_EnvironmentReflections");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Environment Reflections", toggle);

                    if (toggle)
                    {
                        material.SetInt("_EnvironmentReflections", 1);
                        material.DisableKeyword("_ENVIRONMENTREFLECTIONS_OFF");
                    }
                    else
                    {
                        material.SetInt("_EnvironmentReflections", 0);
                        material.EnableKeyword("_ENVIRONMENTREFLECTIONS_OFF");
                    }
                }
            }
            #endregion [URP EnvironmentReflections]

            #region [EnableInstancingField]
            materialEditor.EnableInstancingField();
            #endregion [EnableInstancingField]

            #region [DoubleSidedGIField]
            materialEditor.DoubleSidedGIField();
            #endregion [DoubleSidedGIField]

            #region [URP Alembic Motion Vectors]
            if (material.GetTag("RenderPipeline", false) == "UniversalPipeline")
                if (material.HasProperty("_AddPrecomputedVelocity"))
                {
                    if (material.HasProperty("_AddPrecomputedVelocity"))
                    {
                        var control = material.GetInt("_AddPrecomputedVelocity");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Alembic Motion Vectors", toggle);

                        if (toggle)
                        {
                            material.SetInt("_AddPrecomputedVelocity", 1);
                            material.DisableKeyword("ADD_PRECOMPUTED_VELOCITY");
                        }
                        else
                        {
                            material.SetInt("_AddPrecomputedVelocity", 0);
                            material.EnableKeyword("ADD_PRECOMPUTED_VELOCITY");
                        }
                    }
                }
            #endregion [URP Alembic Motion Vectorsy]

            #region [HDRP Add Precomputed Velocity]
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_AddPrecomputedVelocity"))
                {
                    if (material.HasProperty("_AddPrecomputedVelocity"))
                    {
                        var control = material.GetInt("_AddPrecomputedVelocity");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Add Precomputed Velocity", toggle);

                        if (toggle)
                        {
                            material.SetInt("_AddPrecomputedVelocity", 1);
                            material.DisableKeyword("ADD_PRECOMPUTED_VELOCITY");
                        }
                        else
                        {
                            material.SetInt("_AddPrecomputedVelocity", 0);
                            material.EnableKeyword("ADD_PRECOMPUTED_VELOCITY");
                        }
                    }
                }
            #endregion [HDRP Add Precomputed Velocity]

            #region [Decal MeshBiasType]
            if (material.HasProperty("_DecalMeshBiasType"))
            {
                var control = material.GetInt("_DecalMeshBiasType");
                var depth = material.GetFloat("_DecalMeshDepthBias");
                var view = material.GetFloat("_DecalMeshViewBias");

                control = EditorGUILayout.Popup("Mesh Bias Type", control, new string[] { "Depth Bias", "View Bias" });

                if (control == 0)
                {
                    depth = EditorGUILayout.FloatField("Depth Bias", depth);
                }
                else
                {
                    view = EditorGUILayout.FloatField("View Bias", view);
                }

                material.SetInt("_DecalMeshBiasType", control);
                material.SetFloat("_DecalMeshDepthBias", depth);
                material.SetFloat("_DecalMeshViewBias", view);
            }
            #endregion [Decal MeshBiasType]

            #region [Decal DrawOrder]
            if (material.HasProperty("_DrawOrder"))
            {
                var offset = material.GetInt("_DrawOrder");

                offset = EditorGUILayout.IntSlider("Sorting Priority", offset, -50, 50);

                material.SetInt("_DrawOrder", offset);
            }
            #endregion [Decal DrawOrder]

            #region [QueueControl]
            if (material.HasProperty("_QueueControl") && material.HasProperty("_QueueOffset"))
            {
                var control = material.GetInt("_QueueControl");
                var offset = material.GetInt("_QueueOffset");

                if (control < 0)
                {
                    control = 0;
                }

                control = EditorGUILayout.Popup("Queue Control", control, new string[] { "Auto", "User Defined" });

                if (control == 0)
                {
                    offset = EditorGUILayout.IntSlider("Sorting Priority", offset, -50, 50);

                    if (material.GetTag("RenderType", false) == "Transparent")
                    {
                        material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent + offset;
                    }
                    else
                    {
                        material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest + offset;
                    }
                }
                else
                {
                    materialEditor.RenderQueueField();
                }

                material.SetInt("_QueueControl", control);
                material.SetInt("_QueueOffset", offset);
            }
            #endregion [QueueControl]

            #region [Decal QueueControl]
            if (!material.HasProperty("_QueueControl") && material.HasProperty("_QueueOffset"))
            {
                var offset = material.GetInt("_QueueOffset");

                offset = EditorGUILayout.IntSlider("Sorting Priority", offset, -50, 50);

                if (material.GetTag("RenderType", false) == "Transparent")
                {
                    material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent + offset;
                }
                else
                {
                    material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest + offset;
                }

                material.SetInt("_QueueOffset", offset);
            }

            if (!material.HasProperty("_QueueControl") && !material.HasProperty("_QueueOffset"))
            {
                materialEditor.RenderQueueField();
            }
        }
        #endregion [Decal QueueControl]

        GUILayout.Space(10);     
    }
    #endregion [CATEGORY - ADVANCED SETTINGS]
}