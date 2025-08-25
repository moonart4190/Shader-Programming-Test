using UnityEngine;
using System;

#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.SceneManagement;
using System.IO;
#endif

namespace SnowRabbit
{
    [ExecuteInEditMode]
    [DisallowMultipleComponent]
    [AddComponentMenu("RascalToon/RascalToon Material Controller")]
    public class RascalToon : MonoBehaviour
    {
        public enum ShaderTypes
        {
            RascalCartoon = 0,
            Invalid = 1
        }
        public ShaderTypes currentShaderType = ShaderTypes.Invalid;

        [Header("Material Settings")]
        [SerializeField] private Material targetMaterial;
        [SerializeField] private Renderer targetRenderer;
        
        private bool matAssigned = false;

        // SH_RascalCartoon.shader 프로퍼티들
        [Header("Base Settings")]
        [Range(0, 0.7f)] public float shadowIntensity = 0.5507249f;
        [Range(0, 0.3f)] public float shadowHardness = 0.03913044f;
        [ColorUsage(true, true)] public Color shadowColor = new Color(0.6006289f, 0.9378152f, 1f, 0f);
        public Color baseColor = Color.white;
        
        [Header("Specular Settings")]
        public bool specularOn = false;
        [Range(0, 1f)] public float specularIntensity = 1f;
        [Range(0, 1f)] public float specularRange = 0.5507249f;
        [Range(0, 1f)] public float specularHardness = 0.03913044f;
        public Color specularColor = new Color(0.2f, 0.2f, 0.2f, 0.5019608f);
        public bool useSpecularColor = false;
        
        [Header("Smoothness Settings")]
        public bool useSmoothnessMap = false;
        [Range(0, 5f)] public float smoothness = 0.6430982f;
        
        [Header("Normal Settings")]
        [Range(0, 2f)] public float bumpScale = 1f;

#if UNITY_EDITOR
        private static float timeLastReload = -1f;
        
        private void Start()
        {
            if (timeLastReload < 0) timeLastReload = Time.time;
            FindTargetRenderer();
        }

        private void Update()
        {
            if (matAssigned || Application.isPlaying || !gameObject.activeSelf) return;
            FindTargetRenderer();
        }
#endif

        private void FindTargetRenderer()
        {
            if (targetRenderer == null)
            {
                targetRenderer = GetComponent<Renderer>();
                if (targetRenderer != null)
                {
                    targetMaterial = targetRenderer.sharedMaterial;
                    matAssigned = true;
                }
            }
        }

        private string GetStringFromShaderType()
        {
            currentShaderType = ShaderTypes.RascalCartoon;
            return "SH_RascalCartoon";
        }

        public void CleanMaterial()
        {
            if (targetMaterial != null)
            {
                // 기존 머티리얼의 셰이더만 Lit으로 변경
                targetMaterial.shader = Shader.Find("Universal Render Pipeline/Lit");
                matAssigned = false;
            }
            SetSceneDirty();
        }

        public void ApplyRascalToonShader()
        {
            if (targetMaterial == null)
            {
                FindTargetRenderer();
                if (targetMaterial == null)
                {
                    Debug.LogError("적용할 머티리얼이 없습니다.");
                    return;
                }
            }
            
            // SH_RascalCartoon 셰이더 찾기
            Shader rascalShader = Shader.Find("SH_RascalCartoon");
            if (rascalShader != null)
            {
                targetMaterial.shader = rascalShader;
                currentShaderType = ShaderTypes.RascalCartoon;
                SetSceneDirty();
            }
            else
            {
                Debug.LogError("SH_RascalCartoon 셰이더를 찾을 수 없습니다.");
            }
        }

        public bool SaveMaterial(bool clear = false)
        {
#if UNITY_EDITOR
            if (targetMaterial == null)
            {
                EditorUtility.DisplayDialog("No Material", "저장할 머티리얼이 없습니다. 머티리얼을 먼저 할당해주세요.", "확인");
                return false;
            }

            string gameObjectName = RascalToonShaderData.CheckFileName(gameObject.name);
            string materialPath = Path.Combine(RascalToonShaderData.GetMaterialSavePath(), gameObjectName);
            
            if (!ValidateSavePath(materialPath)) return false;
            
            string fullPath = GetUniqueFilePath(materialPath);
            if (string.IsNullOrEmpty(fullPath)) return false;
            
            DoSaving(fullPath, clear);
            SetSceneDirty();
            return true;
#else
            return false;
#endif
        }

        private bool ValidateSavePath(string path)
        {
#if UNITY_EDITOR
            string directory = Path.GetDirectoryName(path);
            if (Directory.Exists(directory)) return true;
            
            // 폴더가 존재하지 않으면 자동으로 생성
            try
            {
                Directory.CreateDirectory(directory);
                AssetDatabase.Refresh(); // Unity 에디터에 새 폴더 반영
                Debug.Log($"저장 폴더가 생성되었습니다: {directory}");
                return true;
            }
            catch (Exception e)
            {
                EditorUtility.DisplayDialog("폴더 생성 실패",
                    $"저장 폴더를 생성할 수 없습니다: {e.Message}", "확인");
                return false;
            }
#else
            return false;
#endif
        }

        private string GetUniqueFilePath(string basePath)
        {
#if UNITY_EDITOR
            string path = basePath + ".mat";
            int counter = 1;
            
            while (File.Exists(path))
            {
                path = $"{basePath}_{counter}.mat";
                counter++;
                
                if (counter > 999) // Safety measure
                {
                    Debug.LogError("Failed to generate unique file name");
                    return null;
                }
            }
            return path;
#else
            return "";       
#endif
        }

        private void DoSaving(string fileName, bool clear = false)
        {
#if UNITY_EDITOR
            if (targetMaterial == null) return;
            
            try
            {
                // Clone material
                Material newMaterial = new Material(targetMaterial);
                newMaterial.name = targetMaterial.name + "_Copy";
                
                // If clear is true, reset all properties to default values
                if (clear)
                {
                    ClearAllProperties(newMaterial);
                }
                
                // Save material asset
                AssetDatabase.CreateAsset(newMaterial, fileName);
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
                
                Debug.Log($"{fileName} has been saved!");
                EditorGUIUtility.PingObject(AssetDatabase.LoadAssetAtPath(fileName, typeof(Material)));
            }
            catch (Exception e)
            {
                Debug.LogError($"Failed to save material: {e.Message}");
                Debug.LogException(e);
            }
#endif
        }

        public void SetSceneDirty()
        {
#if UNITY_EDITOR
            if (!Application.isPlaying) EditorSceneManager.MarkAllScenesDirty();

#if UNITY_2021_2_OR_NEWER
            var prefabStage = UnityEditor.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage();
#else
            var prefabStage = UnityEditor.Experimental.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage();
#endif
            if (prefabStage != null) EditorSceneManager.MarkSceneDirty(prefabStage.scene);
#endif
        }

        public bool ClearAllProperties(Material material = null)
        {
#if UNITY_EDITOR
            Material targetMat = material ?? targetMaterial;
            if (targetMat == null)
            {
                FindTargetRenderer();
                targetMat = targetMaterial;
                if (targetMat == null)
                {
                    Debug.LogError("No material found to clear properties");
                    return false;
                }
            }

            // Reset all SH_RascalCartoon.shader properties to default values
            targetMat.SetFloat("_ShadowInten", 0.5507249f);
            targetMat.SetFloat("_ShadowHardness", 0.03913044f);
            targetMat.SetColor("_ShadowColor", new Color(0.6006289f, 0.9378152f, 1f, 0f));
            targetMat.SetColor("_BaseColor", Color.white);
            
            targetMat.SetFloat("_SpecularOn", 0f);
            targetMat.SetFloat("_SpecularIntensity", 1f);
            targetMat.SetFloat("_SpecularRange", 0.5507249f);
            targetMat.SetFloat("_SpecularHardness", 0.03913044f);
            targetMat.SetColor("_SpecColor", new Color(0.2f, 0.2f, 0.2f, 0.5019608f));
            targetMat.SetFloat("_SpecularColorBool", 0f);
            
            targetMat.SetFloat("_UseSmoothnessMap", 0f);
            targetMat.SetFloat("_Smoothness", 0.6430982f);
            
            targetMat.SetFloat("_BumpScale", 1f);
#endif
            return true;
        }

        // 프로퍼티 업데이트 메서드들
        public void UpdateShadowProperties()
        {
            if (targetMaterial == null) return;
            
            targetMaterial.SetFloat("_ShadowInten", shadowIntensity);
            targetMaterial.SetFloat("_ShadowHardness", shadowHardness);
            targetMaterial.SetColor("_ShadowColor", shadowColor);
        }

        public void UpdateBaseProperties()
        {
            if (targetMaterial == null) return;
            
            targetMaterial.SetColor("_BaseColor", baseColor);
        }

        public void UpdateSpecularProperties()
        {
            if (targetMaterial == null) return;
            
            targetMaterial.SetFloat("_SpecularOn", specularOn ? 1f : 0f);
            targetMaterial.SetFloat("_SpecularIntensity", specularIntensity);
            targetMaterial.SetFloat("_SpecularRange", specularRange);
            targetMaterial.SetFloat("_SpecularHardness", specularHardness);
            targetMaterial.SetColor("_SpecColor", specularColor);
            targetMaterial.SetFloat("_SpecularColorBool", useSpecularColor ? 1f : 0f);
        }

        public void UpdateSmoothnessProperties()
        {
            if (targetMaterial == null) return;
            
            targetMaterial.SetFloat("_UseSmoothnessMap", useSmoothnessMap ? 1f : 0f);
            targetMaterial.SetFloat("_Smoothness", smoothness);
        }

        public void UpdateNormalProperties()
        {
            if (targetMaterial == null) return;
            
            targetMaterial.SetFloat("_BumpScale", bumpScale);
        }

        public void UpdateAllProperties()
        {
            UpdateShadowProperties();
            UpdateBaseProperties();
            UpdateSpecularProperties();
            UpdateSmoothnessProperties();
            UpdateNormalProperties();
        }

        // 머티리얼 할당 메서드
        public void AssignMaterial(Material material)
        {
            targetMaterial = material;
            if (targetRenderer != null)
            {
                targetRenderer.sharedMaterial = material;
            }
            matAssigned = true;
        }

        // 머티리얼 찾기 메서드
        public void FindMaterial()
        {
            if (targetRenderer == null)
            {
                targetRenderer = GetComponent<Renderer>();
            }
            
            if (targetRenderer != null)
            {
                targetMaterial = targetRenderer.sharedMaterial;
                matAssigned = true;
                
                // 머티리얼 파일을 프로젝트 폴더에서 하이라이트
                if (targetMaterial != null)
                {
#if UNITY_EDITOR
                    EditorGUIUtility.PingObject(targetMaterial);
#endif
                }
            }
            else
            {
                Debug.LogError("No Renderer component found on this GameObject.");
            }
        }

        // 프로퍼티 변경 시 자동 업데이트
        private void OnValidate()
        {
            if (Application.isPlaying) return;
            
            if (targetMaterial != null)
            {
                UpdateAllProperties();
            }
        }
    }
}
