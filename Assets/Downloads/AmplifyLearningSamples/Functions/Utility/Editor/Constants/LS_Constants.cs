
using UnityEngine;
using UnityEditor;
using System;

namespace LearningSamples.Drawers
{
public static class LS_CONSTANTS
    {
        public static Color CategoryColor
        {
            get
            {
                if (EditorGUIUtility.isProSkin)
                {
                    return LS_CONSTANTS.ColorDarkGray;
                }
                else
                {
                    return LS_CONSTANTS.ColorLightGray;
                }
            }
        }

        public static Color LineColor
        {
            get
            {
                if (EditorGUIUtility.isProSkin)
                {
                    return new Color(0.15f, 0.15f, 0.15f, 1.0f);
                }
                else
                {
                    return new Color(0.65f, 0.65f, 0.65f, 1.0f);
                }
            }
        }

        public static Color ColorDarkGray
        {
            get
            {
                return new Color(0.2f, 0.2f, 0.2f, 1.0f);
            }
        }

        public static Color ColorLightGray
        {
            get
            {
                return new Color(0.82f, 0.82f, 0.82f, 1.0f);
            }
        }

        public static GUIStyle TitleStyle
        {
            get
            {
                GUIStyle guiStyle = new GUIStyle("label")
                {
                    richText = true,
                    alignment = TextAnchor.MiddleCenter
                };

                return guiStyle;
            }
        }

        public static GUIStyle HeaderStyle
        {
            get
            {
                GUIStyle guiStyle = new GUIStyle("label")
                {
                    richText = true,
                    fontStyle = FontStyle.Bold,
                    alignment = TextAnchor.MiddleLeft
                };

                return guiStyle;
            }
        }
    }

    public static class LS_Drawers
    {
        public static bool DrawInspectorCategory(string bannerText, bool enabled, bool colapsable, float top, float down, Material material)
        {
            //if (colapsable)
            //{
            //    if (enabled)
            //    {
            //        GUILayout.Space(top);
            //    }
            //    else
            //    {
            //        GUILayout.Space(0);
            //    }
            //}
            //else
            //{
            //    GUILayout.Space(top);
            //}

            var fullRect = GUILayoutUtility.GetRect(0, 0, 18, 0);
            var fillRect = new Rect(0, fullRect.y, fullRect.xMax + 10, 18);
            var lineRect = new Rect(0, fullRect.y - 1, fullRect.xMax + 10, 1);
            var titleRect = new Rect(fullRect.position.x - 1, fullRect.position.y, fullRect.width, 18);
            var arrowRect = new Rect(fullRect.position.x - 15, fullRect.position.y, fullRect.width, 18);

            if (colapsable)
            {
                if (GUI.Button(arrowRect, "", GUIStyle.none))
                {
                    enabled = !enabled;
                }
            }
            else
            {
                enabled = true;
            }

            EditorGUI.DrawRect(fillRect, LS_CONSTANTS.CategoryColor);
            EditorGUI.DrawRect(lineRect, LS_CONSTANTS.LineColor);

            GUI.color = new Color(1, 1, 1, 0.9f);

            GUI.Label(titleRect, bannerText, LS_CONSTANTS.HeaderStyle);

            if (material.GetTag("RenderPipeline", false) != "HDRenderPipeline")
            {
                GUI.color = new Color(1, 1, 1, 0.39f);

                if (colapsable)
                {
                    if (enabled)
                    {
                        GUI.Label(arrowRect, "<size=10>▼</size>", LS_CONSTANTS.HeaderStyle);
                        //GUILayout.Space(down);
                    }
                    else
                    {
                        GUI.Label(arrowRect, "<size=10>►</size>", LS_CONSTANTS.HeaderStyle);
                        //GUILayout.Space(0);
                    }
                }
                else
                {
                    //GUILayout.Space(down);
                }
            }

            GUI.color = Color.white;

            GUILayout.Space(5);

            return enabled;
        }
    }

}