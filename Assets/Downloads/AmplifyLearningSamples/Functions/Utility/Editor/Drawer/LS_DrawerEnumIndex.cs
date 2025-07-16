
using UnityEngine;
using UnityEditor;
using System;

namespace LearningSamples.Drawers
{

    public class LS_DrawerEnumIndex : MaterialPropertyDrawer
    {
        public string options = "";

        public float top = 0;
        public float down = 0;

        public LS_DrawerEnumIndex(string options)
        {
            this.options = options;

            this.top = 0;
            this.down = 0;
        }

        public LS_DrawerEnumIndex (string options, float top, float down)
        {
            this.options = options;

            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor materialEditor)
        {
            GUIStyle styleLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
                wordWrap = true
            };

            string[] enums = options.Split(char.Parse("_"));

            GUILayout.Space(top);

            int index = (int)prop.floatValue;

            index = EditorGUILayout.Popup(prop.displayName, index, enums);

            // Debug Value
            //EditorGUILayout.LabelField(index.ToString());

            prop.floatValue = index;

            GUI.enabled = true;

            GUILayout.Space(down);
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
}