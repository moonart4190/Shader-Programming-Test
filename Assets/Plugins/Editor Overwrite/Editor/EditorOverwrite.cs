// Editor overwrite-on-import utility
// Replaces Unity's default behavior of creating numbered duplicates when dragging a file
// with the same name into the Project window. When enabled, it copies the new file's
// contents over the existing asset file, preserving the .meta (GUID and importer settings),
// deletes the numbered duplicate, and forces a reimport of the original.

using System;
using System.IO;
using System.Text.RegularExpressions;
using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;

namespace Moonart.EditorUtilities
{
    [InitializeOnLoad]
    public static class EditorOverwriteSettings
    {
        private const string PrefKeyEnabled = "EditorOverwrite.Enabled";
        private const string PrefKeySkipWhenIdentical = "EditorOverwrite.SkipWhenIdentical";

        static EditorOverwriteSettings()
        {
            // Default to enabled on first run
            if (!EditorPrefs.HasKey(PrefKeyEnabled))
                EditorPrefs.SetBool(PrefKeyEnabled, true);
            if (!EditorPrefs.HasKey(PrefKeySkipWhenIdentical))
                EditorPrefs.SetBool(PrefKeySkipWhenIdentical, true);
        }

        public static bool Enabled
        {
            get => EditorPrefs.GetBool(PrefKeyEnabled, true);
            set => EditorPrefs.SetBool(PrefKeyEnabled, value);
        }

        public static bool SkipWhenIdentical
        {
            get => EditorPrefs.GetBool(PrefKeySkipWhenIdentical, true);
            set => EditorPrefs.SetBool(PrefKeySkipWhenIdentical, value);
        }

        [MenuItem("Tools/Overwrite Import/Enable", priority = 150)]
        private static void Enable() => Enabled = true;

        [MenuItem("Tools/Overwrite Import/Enable", validate = true)]
        private static bool ValidateEnable() => !Enabled;

        [MenuItem("Tools/Overwrite Import/Disable", priority = 151)]
        private static void Disable() => Enabled = false;

        [MenuItem("Tools/Overwrite Import/Disable", validate = true)]
        private static bool ValidateDisable() => Enabled;

        [MenuItem("Tools/Overwrite Import/Toggle", priority = 152)]
        private static void Toggle() => Enabled = !Enabled;

        [MenuItem("Tools/Overwrite Import/Skip When Identical/Enable", priority = 153)]
        private static void EnableSkipIdentical() => SkipWhenIdentical = true;

        [MenuItem("Tools/Overwrite Import/Skip When Identical/Enable", validate = true)]
        private static bool ValidateEnableSkipIdentical() => !SkipWhenIdentical;

        [MenuItem("Tools/Overwrite Import/Skip When Identical/Disable", priority = 154)]
        private static void DisableSkipIdentical() => SkipWhenIdentical = false;

        [MenuItem("Tools/Overwrite Import/Skip When Identical/Disable", validate = true)]
        private static bool ValidateDisableSkipIdentical() => SkipWhenIdentical;
    }

    // Runs after assets are imported. Detects Unity's auto-renamed duplicates and
    // replaces the original file contents with the new file, keeping the meta.
    public class OverwriteOnImportPostprocessor : AssetPostprocessor
    {
        // Match common Unity duplicate patterns before extension:
        //  - "Name 1"
        //  - "Name (1)"
        private static readonly Regex DuplicateSuffixRegex = new Regex(
            @"^(?<base>.+?)\s*(\((?<n>\d+)\)|\s(?<n2>\d+))$",
            RegexOptions.Compiled);

        private static string ProjectRootPath => Path.GetDirectoryName(Application.dataPath) ?? string.Empty;

        private static string AssetPathToAbsolute(string assetPath)
        {
            // assetPath starts with "Assets/..."
            string relative = assetPath.Replace('/', Path.DirectorySeparatorChar);
            return Path.Combine(ProjectRootPath, relative);
        }

        private static bool TryGetExistingPathForDuplicate(string importedAssetPath, out string existingAssetPath)
        {
            existingAssetPath = string.Empty;

            if (string.IsNullOrEmpty(importedAssetPath) || !importedAssetPath.StartsWith("Assets/", StringComparison.Ordinal))
                return false;

            string dir = Path.GetDirectoryName(importedAssetPath)?.Replace('\\', '/') ?? "Assets";
            string fileName = Path.GetFileNameWithoutExtension(importedAssetPath);
            string ext = Path.GetExtension(importedAssetPath);

            var m = DuplicateSuffixRegex.Match(fileName);
            if (!m.Success)
                return false;

            string baseName = m.Groups["base"].Value.TrimEnd();
            string candidate = (dir.Length > 0 ? dir + "/" : string.Empty) + baseName + ext;

            // Only consider if the original asset exists and it's not a .meta
            if (!string.Equals(Path.GetExtension(candidate), ".meta", StringComparison.OrdinalIgnoreCase))
            {
                string guid = AssetDatabase.AssetPathToGUID(candidate);
                if (!string.IsNullOrEmpty(guid))
                {
                    existingAssetPath = candidate;
                    return true;
                }
            }

            return false;
        }

        private static void EnsureWritable(string absPath)
        {
            try
            {
                var attrs = File.GetAttributes(absPath);
                if ((attrs & FileAttributes.ReadOnly) != 0)
                {
                    attrs &= ~FileAttributes.ReadOnly;
                    File.SetAttributes(absPath, attrs);
                }
            }
            catch { /* ignore */ }
        }

        private static bool SafeCopyOverwrite(string srcAbs, string dstAbs, out string error)
        {
            error = string.Empty;
            try
            {
                EnsureWritable(dstAbs);
                File.Copy(srcAbs, dstAbs, true);
                return true;
            }
            catch (Exception ex)
            {
                error = ex.Message;
                return false;
            }
        }

        private static bool IsMeta(string assetPath)
            => assetPath.EndsWith(".meta", StringComparison.OrdinalIgnoreCase);

        private const int BufferSize = 64 * 1024;
        private static bool AreFilesIdentical(string pathA, string pathB)
        {
            try
            {
                var fa = new FileInfo(pathA);
                var fb = new FileInfo(pathB);
                if (!fa.Exists || !fb.Exists) return false;
                if (fa.Length != fb.Length) return false;

                using var sa = new FileStream(pathA, FileMode.Open, FileAccess.Read, FileShare.ReadWrite, BufferSize, FileOptions.SequentialScan);
                using var sb = new FileStream(pathB, FileMode.Open, FileAccess.Read, FileShare.ReadWrite, BufferSize, FileOptions.SequentialScan);
                var ba = new byte[BufferSize];
                var bb = new byte[BufferSize];
                while (true)
                {
                    int ra = sa.Read(ba, 0, ba.Length);
                    int rb = sb.Read(bb, 0, bb.Length);
                    if (ra != rb) return false;
                    if (ra == 0) break; // EOF both
                    // compare chunk
                    for (int i = 0; i < ra; i++)
                    {
                        if (ba[i] != bb[i]) return false;
                    }
                }
                return true;
            }
            catch
            {
                return false;
            }
        }

        // Main hook
        static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets,
            string[] movedAssets, string[] movedFromAssetPaths)
        {
            if (!EditorOverwriteSettings.Enabled || importedAssets == null || importedAssets.Length == 0)
                return;

            bool anyChanges = false;

            foreach (var imported in importedAssets)
            {
                if (string.IsNullOrEmpty(imported) || IsMeta(imported))
                    continue;

                if (!TryGetExistingPathForDuplicate(imported, out var existing))
                    continue;

                // Only proceed if both files actually exist on disk
                string srcAbs = AssetPathToAbsolute(imported);
                string dstAbs = AssetPathToAbsolute(existing);
                if (!File.Exists(srcAbs) || !File.Exists(dstAbs))
                    continue;

                // If files are identical and the option is enabled, skip (preserve duplicates like Ctrl+D)
                if (EditorOverwriteSettings.SkipWhenIdentical && AreFilesIdentical(srcAbs, dstAbs))
                {
                    // No overwrite: keep Unity's duplicate (Ctrl+D scenario)
                    // Fix potential name mismatch: ensure main object name matches filename
                    try
                    {
                        string fileBase = Path.GetFileNameWithoutExtension(imported);
                        var obj = AssetDatabase.LoadMainAssetAtPath(imported);
                        if (obj != null && obj.name != fileBase)
                        {
                            obj.name = fileBase;
                            EditorUtility.SetDirty(obj);
                            // Delay save slightly to avoid mid-import conflicts
                            EditorApplication.delayCall += () =>
                            {
                                try
                                {
                                    AssetDatabase.SaveAssets();
                                    AssetDatabase.ImportAsset(imported, ImportAssetOptions.ForceUpdate);
                                }
                                catch { }
                            };
                        }
                    }
                    catch { /* best-effort */ }
                    continue;
                }

                // Copy new file contents over existing asset
                if (!SafeCopyOverwrite(srcAbs, dstAbs, out var err))
                {
                    Debug.LogWarning($"[Overwrite Import] Failed to overwrite '{existing}' with '{imported}': {err}");
                    continue;
                }

                // Delete the imported duplicate and reimport the original to refresh
                AssetDatabase.DeleteAsset(imported);
                AssetDatabase.ImportAsset(existing, ImportAssetOptions.ForceUpdate);
                anyChanges = true;

                Debug.Log($"[Overwrite Import] Replaced contents of '{existing}' using '{Path.GetFileName(imported)}' and removed duplicate. Meta and importer settings preserved.");
            }

            if (anyChanges)
            {
                AssetDatabase.SaveAssets();
            }
        }
    }
}
#endif
