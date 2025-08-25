#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

namespace SnowRabbit.Editor
{
    [CustomEditor(typeof(RascalToon)), CanEditMultipleObjects]
    public class RascalToonEditor : UnityEditor.Editor
    {
        private bool showUrpWarning = false;
        private double warningTime = 0f;

        public override void OnInspectorGUI()
        {
            RascalToon myScript = (RascalToon)target;
            
            // Style Settings
            GUIStyle titleStyle = new GUIStyle(EditorStyles.boldLabel)
            {
                fontSize = 18,
                alignment = TextAnchor.MiddleLeft,
                imagePosition = ImagePosition.ImageLeft,
                richText = true,
                fixedHeight = 30,
                wordWrap = false,
                normal = new GUIStyleState { textColor = new Color(0f, 1f, 0.769f) },
                hover = new GUIStyleState { textColor = new Color(0f, 1f, 1f) },
                margin = new RectOffset(0, 0, 10, 10),
                padding = new RectOffset(0, 0, 0, 10),
                fixedWidth = 290
            };

            GUIStyle buttonStyle = new GUIStyle(GUI.skin.button)
            {
                fixedHeight = 22,
                padding = new RectOffset(5, 15, 3, 3),
                margin = new RectOffset(2, 2, 0, 5),
                normal = new GUIStyleState { textColor = new Color(0f, 1f, 0.769f) },
                hover = new GUIStyleState { textColor = new Color(0f, 1f, 1f) },
                fontStyle = FontStyle.Bold,
                alignment = TextAnchor.MiddleLeft,
                fontSize = 11,
                stretchWidth = true
            };

            // Title Box Start
            EditorGUILayout.BeginVertical(new GUIStyle(EditorStyles.helpBox)
            {
                padding = new RectOffset(15, 15, 5, 15),
                margin = new RectOffset(25, 25, 10, 10)
            });

            // Logo and Title
            EditorGUILayout.BeginHorizontal();
            {
                Texture2D iconTexture = (Texture2D)Resources.Load("Editor Textures/Logo");
                GUIContent titleContent = new GUIContent("  RascalToon 머티리얼 컨트롤러", iconTexture);
                GUILayout.Label(titleContent, titleStyle);
                
                // Version Information
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

            // Button Section
            EditorGUILayout.BeginVertical(new GUIStyle(EditorStyles.helpBox)
            {
                padding = new RectOffset(10, 10, 10, 10),
                margin = new RectOffset(0, 0, 5, 5)
            });
            {
                if (GUILayout.Button(new GUIContent(" RascalToon 셰이더 적용", EditorGUIUtility.IconContent("d_SceneViewFx").image), buttonStyle))
                {
                    for (int i = 0; i < targets.Length; i++)
                    {
                        ((RascalToon)targets[i]).ApplyRascalToonShader();
                    }
                    ShowNotification("RascalToon 셰이더가 적용되었습니다");
                }

                if (GUILayout.Button(new GUIContent(" 머티리얼 찾기", EditorGUIUtility.IconContent("Search Icon").image), buttonStyle))
                {
                    for (int i = 0; i < targets.Length; i++)
                    {
                        ((RascalToon)targets[i]).FindMaterial();
                    }
                    ShowNotification("머티리얼을 찾았습니다");
                }

                if (GUILayout.Button(new GUIContent(" 모든 프로퍼티 업데이트", EditorGUIUtility.IconContent("d_Refresh").image), buttonStyle))
                {
                    for (int i = 0; i < targets.Length; i++)
                    {
                        ((RascalToon)targets[i]).UpdateAllProperties();
                    }
                    ShowNotification("모든 프로퍼티가 업데이트되었습니다");
                }

                if (GUILayout.Button(new GUIContent(" 모든 프로퍼티 초기화", EditorGUIUtility.IconContent("d_Refresh").image), buttonStyle))
                {
                    bool successOperation = true;
                    for (int i = 0; i < targets.Length; i++)
                    {
                        successOperation &= ((RascalToon)targets[i]).ClearAllProperties();
                    }
                    if(successOperation) ShowNotification("모든 프로퍼티가 초기화되었습니다");
                }

                if (GUILayout.Button(new GUIContent(" 머티리얼 저장 (프로퍼티 초기화)", EditorGUIUtility.IconContent("SaveAs").image), buttonStyle))
                {
                    bool successOperation = true;
                    for (int i = 0; i < targets.Length; i++)
                    {
                        successOperation &= ((RascalToon)targets[i]).SaveMaterial(true);
                    }
                    if(successOperation) ShowNotification("머티리얼이 저장되었습니다 (프로퍼티 초기화됨)");
                }

                if (GUILayout.Button(new GUIContent(" 머티리얼 저장 (프로퍼티 유지)", EditorGUIUtility.IconContent("SaveAs").image), buttonStyle))
                {
                    bool successOperation = true;
                    for(int i = 0; i < targets.Length; i++)
                    {
                        successOperation &= ((RascalToon) targets[i]).SaveMaterial();
                    }
                    if(successOperation) ShowNotification("머티리얼이 저장되었습니다");
                }
            }
            EditorGUILayout.EndVertical();

            // URP Warning Message
            bool isUrp = false;
            Shader temp = RascalToonShaderData.FindShader("SH_RascalCartoon");
            if (temp != null) isUrp = true;

            if (warningTime < EditorApplication.timeSinceStartup) showUrpWarning = false;
            if (isUrp) showUrpWarning = false;
            if (showUrpWarning)
            {
                EditorGUILayout.HelpBox(
                    "SH_RascalCartoon 셰이더를 찾을 수 없습니다. 셰이더가 올바르게 임포트되었는지 확인해주세요.",
                    MessageType.Error,
                    true);
            }

            EditorGUILayout.EndVertical();
            DrawLine(Color.grey, 1, 3);

            EditorGUILayout.Space();

            // Component Removal Section
            EditorGUILayout.BeginVertical(new GUIStyle(EditorStyles.helpBox)
            {
                padding = new RectOffset(10, 10, 10, 10),
                margin = new RectOffset(25, 25, 5, 5)
            });
            {
                if (GUILayout.Button(new GUIContent(" 컴포넌트 제거", EditorGUIUtility.IconContent("d_TreeEditor.Trash").image), buttonStyle))
                {
                    for(int i = targets.Length - 1; i >= 0; i--)
                    {
                        DestroyImmediate(targets[i] as RascalToon);
                        ((RascalToon)targets[i]).SetSceneDirty();
                    }
                    ShowNotification("컴포넌트가 제거되었습니다");
                }

                if (GUILayout.Button(new GUIContent(" 컴포넌트 제거 및 머티리얼 정리", EditorGUIUtility.IconContent("d_TreeEditor.Trash").image), buttonStyle))
                {
                    for(int i = targets.Length - 1; i >= 0; i--)
                    {
                        var rascalToon = targets[i] as RascalToon;
                        rascalToon.CleanMaterial();
                        DestroyImmediate(rascalToon);
                        rascalToon.SetSceneDirty();
                    }
                    ShowNotification("컴포넌트와 머티리얼이 정리되었습니다");
                }
            }
            EditorGUILayout.EndVertical();
        }

        private void SetCurrentShaderType(RascalToon myScript)
        {
            string shaderName = "";
            Renderer renderer = myScript.GetComponent<Renderer>();
            if (renderer != null && renderer.sharedMaterial != null)
            {
                shaderName = renderer.sharedMaterial.shader.name;
            }
            
            if (shaderName.Contains("SH_RascalCartoon"))
            {
                myScript.currentShaderType = RascalToon.ShaderTypes.RascalCartoon;
            }
            else
            {
                myScript.currentShaderType = RascalToon.ShaderTypes.Invalid;
            }
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

        private void ShowNotification(string message)
        {
            EditorWindow.GetWindow<SceneView>().ShowNotification(new GUIContent(message));
        }
    }
}
#endif