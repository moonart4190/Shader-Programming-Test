using UnityEngine;
using System.Linq;

#if UNITY_EDITOR
using UnityEditor;
using System.IO;
using UnityEditor.SceneManagement;
#endif

namespace SnowRabbit
{
    public class RascalToonShaderData
    {
        public const string versionString = "v1.0";
        private static string basePath = "Assets/NormalResource/Shaders/Generated";
        private static readonly string materialsSavesRelativePath = "/Materials";
        
#if UNITY_EDITOR
        public static void GetBasePath()
        {
            // 원하는 경로로 고정 설정
            basePath = "Assets/NormalResource/Shaders/Generated";
        }

        public static string GetMaterialSavePath()
        {
            if (!PlayerPrefs.HasKey("RascalToonMaterials"))
            {
                GetBasePath();
                return basePath + materialsSavesRelativePath;
            }
            return PlayerPrefs.GetString("RascalToonMaterials");
        }

        public static Shader FindShader(string shaderName)
        {
            string[] guids = AssetDatabase.FindAssets($"{shaderName} t:shader");
            foreach (string guid in guids)
            {
                string path = AssetDatabase.GUIDToAssetPath(guid);
                Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(path);
                if (shader != null)
                {
                    string fullShaderName = shader.name;
                    string actualShaderName = fullShaderName.Substring(fullShaderName.LastIndexOf('/') + 1);
                    if (actualShaderName.Equals(shaderName)) return shader;
                }
            }
            return null;
        }

        public static string CheckFileName(string fileName)
        {
            char[] invalidChars = Path.GetInvalidFileNameChars();

            char[] additionalInvalidChars = new char[]
            {
                '<', '>', '|', '\"', '*', ':', '\\', '/'
            };

            string sanitized = fileName;

            foreach (char invalidChar in invalidChars.Concat(additionalInvalidChars))
            {
                sanitized = sanitized.Replace(invalidChar, '_');
            }

            while (sanitized.Contains("__"))
            {
                sanitized = sanitized.Replace("__", "_");
            }

            sanitized = sanitized.Trim().Trim('.', '_');

            if (string.IsNullOrWhiteSpace(sanitized))
            {
                sanitized = "Material_Asset";
            }

            return sanitized;
        }
#else
        // Runtime에서 사용할 수 있는 기본 메서드들
        public static string GetMaterialSavePath()
        {
            return "Assets/Materials/Generated";
        }

        public static string CheckFileName(string fileName)
        {
            // 간단한 파일명 정리 (Runtime에서는 제한적)
            string sanitized = fileName.Replace(" ", "_");
            sanitized = sanitized.Replace("/", "_");
            sanitized = sanitized.Replace("\\", "_");
            
            if (string.IsNullOrWhiteSpace(sanitized))
            {
                sanitized = "Material_Asset";
            }

            return sanitized;
        }
#endif
    }
} 