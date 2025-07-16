
using UnityEngine;
using UnityEditor;
using System;

namespace LearningSamples.Drawers
{
    public class LS_DrawerTextureScaleOffset : MaterialPropertyDrawer
    {
        override public void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            var cacheLabel = EditorGUIUtility.labelWidth;
            var cacheField = EditorGUIUtility.fieldWidth;

            Vector4 vec4value = prop.vectorValue;
            Vector2 tiling = new Vector2(vec4value.x, vec4value.y);
            Vector2 offset = new Vector2(vec4value.z, vec4value.w);

            var material = editor.target as Material;

            {
                GUILayout.Space(-4);
                EditorGUI.BeginChangeCheck();
                EditorGUILayout.BeginVertical();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Tiling", GUILayout.Width(cacheLabel));
                tiling = EditorGUILayout.Vector2Field("", tiling);
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Offset", GUILayout.Width(cacheLabel));
                offset = EditorGUILayout.Vector2Field("", offset);
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndVertical();
                GUILayout.Space(4);
            }

            if (EditorGUI.EndChangeCheck())
            {
                prop.vectorValue = new Vector4(tiling.x, tiling.y, offset.x, offset.y);
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return 0;
        }
    }
}