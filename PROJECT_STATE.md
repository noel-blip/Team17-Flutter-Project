# Project State

## Product
Team 17 Campus Club App.

## Current milestone
Reusable login foundation before the real Campus Club home screen.

## Implemented
- system light/dark theme
- local JSON demo authentication
- validation and safe malformed-data handling
- SHOW/HIDE password
- Verified success transition
- temporary authenticated destination
- auth, theme, and login widget tests
- safe Windows Android bootstrap script

## Protected behavior
- existing Flutter source must never be overwritten by platform bootstrap
- missing/malformed local login data must fail safely
- wrong login must not navigate
- valid login must show Verified before navigation
- layout must remain scrollable on short phone heights

## Verification — PASS
GitHub Actions verified the clean implementation with Flutter stable 3.47.5 and Java 17.

Evidence:
- focused authentication tests: PASS
- focused theme tests: PASS
- focused login widget tests: PASS
- full suite: 14 tests PASS
- flutter analyze: PASS, no issues found
- debug Android APK build: PASS
- safe temporary Android bootstrap: PASS

The verified build produced build/app/outputs/flutter-apk/app-debug.apk.

## Root cause closed
The earlier failed CI path ran flutter create . inside the working repository and could regenerate project source. The corrected path creates a temporary Flutter project and copies only android/. The same safety rule is used by tool/bootstrap_android.ps1.

## Known infrastructure constraint
The connected GitHub writer would not create a new .github/workflows file directly on main. The verified safe workflow definition is preserved at tool/flutter-ci.yml.example.

## Next milestone
Design and implement the Campus Club home screen, then the Clubs/Events JSON flow.
