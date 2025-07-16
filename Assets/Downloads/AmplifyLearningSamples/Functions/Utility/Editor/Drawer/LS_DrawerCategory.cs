
using UnityEngine;
using UnityEditor;
using System;

namespace LearningSamples.Drawers
{

public class LS_DrawerCategory : MaterialPropertyDrawer
    {
        public string category;
        public float top;
        public float down;
        public string colapsable;
        public string conditions = "";

        public LS_DrawerCategory(string category)
        {
            this.category = category;
            this.colapsable = "false";
            this.top = 10;
            this.down = 10;
        }

        public LS_DrawerCategory(string category, string colapsable)
        {
            this.category = category;
            this.colapsable = colapsable;
            this.top = 10;
            this.down = 10;
        }

        public LS_DrawerCategory(string category, float top, float down)
        {
            this.category = category;
            this.colapsable = "false";
            this.top = top;
            this.down = down;
        }

        public LS_DrawerCategory(string category, string colapsable, float top, float down)
        {
            this.category = category;
            this.colapsable = colapsable;
            this.top = top;
            this.down = down;
        }

        public LS_DrawerCategory(string category, string colapsable, string conditions, float top, float down)
        {
            this.category = category;
            this.colapsable = colapsable;
            this.conditions = conditions;
            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor materialEditor)
        {
            GUI.enabled = true;
            EditorGUI.indentLevel = 0;

            Material material = materialEditor.target as Material;

            if (conditions == "")
            {
                DrawInspector(prop, material);
            }
            else
            {
                bool showInspector = false;

                string[] split = conditions.Split(char.Parse(" "));

                for (int i = 0; i < split.Length; i++)
                {
                    if (material.HasProperty(split[i]))
                    {
                        showInspector = true;
                        break;
                    }
                }

                if (showInspector)
                {
                    DrawInspector(prop, material);
                }
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }

        void DrawInspector(MaterialProperty prop, Material material)
        {
            bool isColapsable = false;

            if (colapsable == "true")
            {
                isColapsable = true;
            }

            bool isEnabled = true;

            if (prop.floatValue < 0.5f)
            {
                isEnabled = false;
            }

            isEnabled = LS_Drawers.DrawInspectorCategory(category, isEnabled, isColapsable, top, down, material);

            if (isEnabled)
            {
                prop.floatValue = 1;
            }
            else
            {
                prop.floatValue = 0;
            }
        }
    }
}