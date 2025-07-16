
using UnityEngine;
using UnityEditor;
using System;

namespace LearningSamples.Drawers
{

public class LS_DrawerToggleLeft : MaterialPropertyDrawer
    {

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            position.width -= 24;
            bool value = prop.floatValue != 0.0f;
            EditorGUI.BeginChangeCheck();
            EditorGUI.showMixedValue = prop.hasMixedValue;
            if (EditorGUIUtility.isProSkin)
            {
                value = EditorGUI.ToggleLeft(position, label, value);
            }
            else
            {
                GUIStyle LeftToggle = new GUIStyle();
                LeftToggle.normal.textColor = Color.white;
                LeftToggle.contentOffset = new Vector2(2f, 0f);
                value = EditorGUI.ToggleLeft(position, label, value, LeftToggle);
            }
            EditorGUI.showMixedValue = false;

            if (EditorGUI.EndChangeCheck())
            {
                prop.floatValue = value ? 1.0f : 0.0f;
            }
        }
    }
}