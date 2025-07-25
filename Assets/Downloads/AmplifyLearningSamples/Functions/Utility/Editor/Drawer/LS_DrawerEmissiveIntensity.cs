﻿
using UnityEngine;
using UnityEditor;
using System;

namespace LearningSamples.Drawers
{

public class LS_DrawerEmissiveIntensity : MaterialPropertyDrawer
    {
        public string reference = "";
        public float top = 0;
        public float down = 0;

        public LS_DrawerEmissiveIntensity()
        {
            this.top = 0;
            this.down = 0;
        }

        public LS_DrawerEmissiveIntensity(string reference)
        {
            this.reference = reference;
            this.top = 0;
            this.down = 0;
        }

        public LS_DrawerEmissiveIntensity(float top, float down)
        {
            this.top = top;
            this.down = down;
        }

        public LS_DrawerEmissiveIntensity(string reference, float top, float down)
        {
            this.reference = reference;
            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            var stylePopup = new GUIStyle(EditorStyles.popup)
            {
                fontSize = 9,
                alignment = TextAnchor.MiddleCenter,
            };

            var internalReference = MaterialEditor.GetMaterialProperty(editor.targets, reference);

            Vector4 propVector = prop.vectorValue;

            GUILayout.Space(top);

            EditorGUI.BeginChangeCheck();

            EditorGUI.showMixedValue = prop.hasMixedValue;

            // Add this to get the material
            var material = editor.target as Material;

            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
            {
                GUILayout.BeginHorizontal();

                GUILayout.Space(1);

                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth ));

                if (propVector.w == 0)
                {
                    propVector.y = EditorGUILayout.FloatField(propVector.y);
                }
                else if (propVector.w == 1)
                {
                    propVector.z = EditorGUILayout.FloatField(propVector.z);
                }

                GUILayout.Space(-25);

                propVector.w = (float)EditorGUILayout.Popup((int)propVector.w, new string[] { "Nits", "EV100" }, stylePopup, GUILayout.Width(65));

                GUILayout.EndHorizontal();
            }
            else
            {
                GUILayout.BeginHorizontal();
                GUILayout.Space(-1);
                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth));

                if (propVector.w == 0)
                {
                    propVector.y = EditorGUILayout.FloatField(propVector.y);
                }
                else if (propVector.w == 1)
                {
                    propVector.z = EditorGUILayout.FloatField(propVector.z);
                }

                GUILayout.Space(2);

                propVector.w = (float)EditorGUILayout.Popup((int)propVector.w, new string[] { "Nits", "EV100" }, stylePopup, GUILayout.Width(50));

                GUILayout.EndHorizontal();
            }

            EditorGUI.showMixedValue = false;

            if (EditorGUI.EndChangeCheck())
            {
                if (propVector.w == 0)
                {
                    propVector.x = propVector.y;
                }
                else if (propVector.w == 1)
                {
                    propVector.x = ConvertEvToLuminance(propVector.z);
                }

                if (internalReference.displayName != null)
                {
                    internalReference.floatValue = propVector.x;
                }

                prop.vectorValue = propVector;
            }

            GUILayout.Space(down);
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }

        //public float ConvertLuminanceToEv(float luminance)
        //{
        //    return (float)Math.Log((luminance * 100f) / 12.5f, 2);
        //}

        public float ConvertEvToLuminance(float ev)
        {
            return (12.5f / 100.0f) * Mathf.Pow(2f, ev);
        }
    }
}