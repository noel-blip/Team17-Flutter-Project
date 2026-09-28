# Changelog

## 2026-09-28 — Fresh login rebuild

### Changed
- removed the stalled planning/spec-only repository state
- rebuilt the Flutter login milestone from clean source
- added system light/dark themes
- added local JSON demo authentication
- added validation, SHOW/HIDE, Verified success flow, and temporary authenticated screen
- added auth, theme, and login widget tests
- added a safe Windows Android bootstrap that never runs flutter create inside the repository
- preserved the safe CI definition as tool/flutter-ci.yml.example

### Root cause corrected
The earlier CI bootstrap ran flutter create . inside the repository. Flutter regenerated project files and overwrote source such as lib/main.dart, causing tests to compile against the generated counter app instead of the intended login app.

### Verification
The corrected temporary CI harness runs focused tests, the full test suite, flutter analyze, and a debug APK build without overwriting project source.
