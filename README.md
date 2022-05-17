# SwiftLint Rule

```yml
disabled_rules:
  - trailing_whitespace
  - orphaned_doc_comment
  - nesting

opt_in_rules:
  - let_var_whitespace
  - force_unwrapping

included:
  - Danggn
excluded:
  # AppDelegate, SceneDelegate file 무시
  - Danggn/Application/AppDelegate.swift
  - Danggn/Application/SceneDelegate.swift

force_cast: error
force_unwrapping: error
```

# Commit Convention

- [Fix] : 버그, 오류 해결
- [Chore] : 코드 수정, 내부 파일 수정
- [Correct] : 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다.
- [Add] : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 View 생성
- [Feat] : 새로운 기능 구현
- [Del] : 쓸모없는 코드 삭제
- [Docs] : README나 WIKI 등의 문서 개정
- [Mod] : storyboard 파일만 수정한 경우
- [Move] : 프로젝트 내 파일이나 코드의 이동
- [Rename] : 파일 이름 변경이 있을 때 사용합니다.
- [Improve] : 향상이 있을 때 사용합니다.
- [Refactor] : 전면 수정이 있을 때 사용합니다
- [Setting] : 프로젝트 설정관련이 있을 때 사용합니다.

# 폴더링 Convention

- 약어는 삼가한다.
- ViewController의 이름은 동사 + 명사 순서로 작성한다.
