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

## Verification
A temporary GitHub Actions harness is being used to run Flutter tests, analyzer, and a debug APK build against this exact implementation. The safe Android bootstrap creates a temporary Flutter project and copies only android/.

## Known constraint
The connected GitHub writer would not create a new .github/workflows file directly on main. The intended workflow is preserved at tool/flutter-ci.yml.example.

## Next milestone
Design and implement the Campus Club home screen, then the Clubs/Events JSON flow.
