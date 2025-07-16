
using UnityEngine;
using UnityEditor;
using System;

namespace LearningSamples.Drawers
{

public class LS_DrawerCategorySpace : MaterialPropertyDrawer
    {
        public float space;
        public string conditions = "";

        public LS_DrawerCategorySpace(float space)
        {
            this.space = space;
        }

        public LS_DrawerCategorySpace(float space, string conditions)
        {
            this.space = space;
            this.conditions = conditions;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor materialEditor)
        {
            if (conditions == "")
            {
                GUILayout.Space(space);
            }
            else
            {
                Material material = materialEditor.target as Material;

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
                    GUILayout.Space(space);
                }
            }

        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }

}