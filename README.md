# Team 17 Flutter Project

Campus Club App Flutter coursework project.

## Current milestone

The reusable login foundation is implemented:

- system-following light and dark themes
- local JSON login validation
- empty-field and invalid-login feedback
- password SHOW / HIDE
- brief `Verified ✓` success state
- safe handling of missing or malformed login data
- temporary authenticated destination
- unit and widget tests

### Demo access

- Student ID / Email: `DEMO`
- Password: `TEAM17`

The committed demo values are synthetic project data.

## Safe local setup

Do **not** run `flutter create .` directly inside this repository. A previous CI attempt proved that it can overwrite existing Flutter source.

On Windows, use the safe bootstrap script instead:

```powershell
powershell -ExecutionPolicy Bypass -File .\tool\bootstrap_android.ps1
flutter pub get
flutter test
flutter run
```

The bootstrap script creates a temporary Flutter project and copies only its generated `android/` directory into this repository.

## Project structure

```text
assets/demo_users.json
lib/main.dart
lib/auth/auth_service.dart
lib/auth/login_screen.dart
lib/home/placeholder_home_screen.dart
lib/theme/app_theme.dart
test/auth/auth_service_test.dart
test/auth/login_screen_test.dart
test/theme/app_theme_test.dart
```

## Next milestone

Replace the temporary authenticated destination with the Campus Club home experience, then add the Clubs/Events JSON flow.
