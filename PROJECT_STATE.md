# Project State

## Product
Team 17 Campus Club App.

## Current milestone
Reusable adaptive login foundation before the real Campus Club home screen.

## Implemented
- system light/dark theme
- local JSON demo authentication
- validation and safe malformed-data handling
- SHOW/HIDE password
- Verified success transition
- temporary authenticated destination
- phone layout
- tablet layout
- desktop two-column layout
- safe Android, Windows, and Web bootstrap scripts
- reusable GitHub Actions Demo Builds workflow

## Protected behavior
- existing Flutter source must never be overwritten by platform bootstrap
- missing/malformed local login data must fail safely
- wrong login must not navigate
- valid login must show Verified before navigation
- short phone layouts must remain scrollable without overflow
- desktop widths must use the two-column desktop presentation instead of a phone frame

## Verification — PASS

Verified with Flutter stable 3.47.5.

Evidence:
- full Flutter suite: 16 tests PASS
- phone short-height layout: PASS
- tablet adaptive layout: PASS
- desktop two-column layout: PASS
- flutter analyze: PASS, no issues found
- Web release build: PASS
- Windows release build: PASS
- Android debug APK build: PASS
- all three demo artifacts uploaded successfully

## Distribution

GitHub Actions workflow:
`.github/workflows/demo-builds.yml`

It can be started manually from the GitHub Actions page and produces:
- `Team17-Windows`
- `Team17-Android-APK`
- `Team17-Web-Bundle`

Artifacts are retained for 30 days.

## Root cause closed

The earlier failed CI path ran `flutter create .` inside the working repository and could regenerate source files. All current platform bootstraps generate into temporary directories and copy only the requested platform scaffold.

## Next milestone
Design and implement the Campus Club home screen, then the Clubs/Events JSON flow.
