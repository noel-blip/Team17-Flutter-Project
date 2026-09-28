# Team17 Flutter Project

Project-neutral Flutter foundation for **Team 17**.

## Current milestone

The first required milestone is complete:

- restrained **A + tiny B** login UI
- automatic **system Light / Dark mode**
- local JSON credential authentication
- Student ID / Email + Password validation
- password **SHOW / HIDE**
- subtle button press motion
- `Verified ✓` success state
- temporary project-neutral home screen
- widget/unit tests
- GitHub Actions verification
- debug Android APK build verified in CI

The screen is intentionally project-neutral because the final college project can still change.

## Demo login

- **Student ID:** `24NE1A42E7`
- **Password:** `123456`

Credentials currently live in:

`assets/credentials.json`

> This local JSON authentication is appropriate for the college/demo requirement. It is **not** secure production authentication for real user passwords.

## Design direction

The login uses:

- Apple-like restraint and spacing
- a small Nothing-inspired `ACCESS` detail
- warm off-white light mode
- near-black dark mode
- one muted-red accent
- no gradients, glassmorphism, decorative blobs, or card stacks
- motion only for interaction/state

## Run on a laptop

Install Flutter first, then:

```bash
git clone https://github.com/noel-blip/Team17-Flutter-Project.git
cd Team17-Flutter-Project
git checkout feature/login-screen
```

This repository currently keeps the product source independent of generated platform folders. Create the Android platform once:

```bash
flutter create . --platforms=android --org com.team17 --project-name team17_flutter_project
flutter pub get
flutter run
```

After the branch is merged, the `git checkout feature/login-screen` line will no longer be necessary.

## Verification

CI runs:

```text
Auth service tests
Theme tests
Login screen tests
Full Flutter test suite
flutter analyze
flutter build apk --debug
```

The login implementation has passed all of these checks on GitHub Actions.

## Important source files

```text
assets/credentials.json
lib/main.dart
lib/auth/auth_service.dart
lib/auth/login_screen.dart
lib/home/placeholder_home_screen.dart
lib/theme/app_theme.dart
test/auth/auth_service_test.dart
test/auth/login_screen_test.dart
test/theme/app_theme_test.dart
```

Approved design/specification documents are stored under:

`docs/superpowers/`
