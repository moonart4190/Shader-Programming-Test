# Overwrite Import (에셋 덮어쓰기)

Unity 프로젝트 창에 동일 이름(같은 폴더)의 파일을 드래그&드롭하면 기본 동작은 `Name (1).ext` 같은 복제본을 만듭니다. 이 유틸은 해당 복제본이 생길 때 자동으로 기존 파일을 덮어쓰기해서 GUID(.meta)와 Importer 설정을 유지합니다.

## 사용법
- 기본값: 활성화됨
- 메뉴: Tools > Overwrite Import > Enable/Disable/Toggle
  - Skip When Identical: Enable/Disable (기본 활성화)
- 동작 방식:
  1) Unity가 새 파일을 `Name (1).ext` 또는 `Name 1.ext` 로 임포트했다고 감지하면,
  2) 새 파일의 내용을 기존 `Name.ext` 에 그대로 복사(메타 유지)하고,
  3) 복제본(`Name (1).ext`)을 삭제한 뒤, 기존 에셋을 강제 Reimport 합니다.

### Ctrl+D Duplicate 예외 처리
프로젝트 창에서 Ctrl+D 로 복제 시 Unity가 내부적으로 동일 파일을 생성하는 경우가 있습니다.
"Skip When Identical" 옵션이 켜져 있으면, 새로 임포트된 파일과 기존 파일의 바이트가 완전히 같을 때는
덮어쓰기를 수행하지 않고 복제본을 유지합니다.

## 주의사항
- `.meta` 파일은 건드리지 않습니다.
- 읽기 전용 파일은 해제 시도 후 덮어씁니다. 권한 문제로 실패할 수 있습니다.
- 동일 이름 판별은 일반적인 Unity 자동 네이밍 패턴 "(1)" 또는 공백+번호만 처리합니다.
- 폴더 드래그, 다수 파일 대량 임포트 시에도 항목별로 처리됩니다.
- 버전 관리 사용 시, 변경된 파일 체크아웃이 필요할 수 있습니다.

## 제거
`Assets/Plugins/Editor Overwrite/Editor/EditorOverwrite.cs` 를 삭제하면 기능이 비활성화됩니다.
