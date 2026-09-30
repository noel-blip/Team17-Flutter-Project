# Changelog

## 2026-09-30 — Login milestone scope locked

### Decision
- froze feature development at the completed login milestone
- kept GitHub Pages, Releases, build workflows, and verification infrastructure operational
- documented that password recovery, Google sign-in, registration, and similar production-authentication features are outside the current local demo-auth scope
- added `SCOPE_LOCK.md` with explicit reopen conditions


## 2026-09-28 — Adaptive multi-platform login demo

### Added
- phone, tablet, and desktop login breakpoints
- full two-column desktop Campus Club login experience
- desktop layout test proving the UI does not render as a phone frame
- safe Web bootstrap script
- safe Windows bootstrap script
- GitHub Actions Demo Builds workflow
- downloadable Android, Windows, and Web build artifacts

### Verified
- 16 Flutter tests passed
- flutter analyze reported no issues
- Android APK build passed
- Windows release build passed
- Web release build passed

## 2026-09-28 — Fresh login rebuild

### Changed
- removed the stalled planning/spec-only repository state
- rebuilt the Flutter login milestone from clean source
- added system light/dark themes
- added local JSON demo authentication
- added validation, SHOW/HIDE, Verified success flow, and temporary authenticated screen
- added auth, theme, and login widget tests
- added a safe Windows Android bootstrap that never runs flutter create inside the repository

### Root cause corrected
The earlier CI bootstrap ran flutter create . inside the repository. Flutter regenerated project files and overwrote source such as lib/main.dart, causing tests to compile against the generated counter app instead of the intended login app.
