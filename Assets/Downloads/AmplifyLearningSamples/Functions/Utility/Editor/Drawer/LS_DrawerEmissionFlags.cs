
using UnityEngine;
using UnityEditor;
using System;

namespace LearningSamples.Drawers
{

public class LS_DrawerEmissionFlags : MaterialPropertyDrawer
    {
        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            var material = editor.target as Material;

            float flag = prop.floatValue;

            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Space(0);
                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth ));
                flag = EditorGUILayout.Popup((int)flag, new string[] { "None", "Any", "Baked", "Realtime" });
                EditorGUILayout.EndHorizontal();
            }
            else
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Space(-2);
                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth));
                flag = EditorGUILayout.Popup((int)flag, new string[] { "None", "Any", "Baked", "Realtime" });
                EditorGUILayout.EndHorizontal();
            }

            if (flag == 0)
            {
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.None;
            }
            else if (flag == 1)
            {
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.AnyEmissive;
            }
            else if (flag == 2)
            {
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.BakedEmissive;
            }
            else if (flag == 3)
            {
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.RealtimeEmissive;
            }

            prop.floatValue = flag;
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }

}