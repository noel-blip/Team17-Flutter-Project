# Team 17 Flutter Project

Campus Club App Flutter coursework project.

## Current milestone

The reusable login foundation is implemented and verified across phone, tablet, desktop, and web-sized layouts.

### Login features
- system-following light and dark themes
- local JSON demo authentication
- empty-field and invalid-login feedback
- password SHOW / HIDE
- brief `Verified ✓` success state
- safe handling of missing or malformed login data
- temporary authenticated destination

### Adaptive layout
- phone: compact single-column login
- tablet: wider bounded login form
- desktop / large monitor: full two-column Campus Club presentation with the login form on the right

The desktop version is intentionally not a phone-shaped rectangle in the middle of the monitor.

### Demo access

- Student ID / Email: `DEMO`
- Password: `TEAM17`

The committed demo values are synthetic project data.

## Show the app without Flutter installed

The repository has a GitHub Actions workflow named **Demo Builds**.

From GitHub:

1. Open **Actions**.
2. Select **Demo Builds**.
3. Click **Run workflow**.
4. When it finishes, download the artifact you want:
   - `Team17-Windows` — Windows desktop build
   - `Team17-Android-APK` — Android APK
   - `Team17-Web-Bundle` — production web files

For a college Windows PC, extract `Team17-Windows` and run:

```text
team17_flutter_project.exe
```

Flutter does not need to be installed on that PC.

GitHub Actions artifacts are retained for 30 days. Run the workflow again whenever a fresh package is needed.

## Safe local development

Never run `flutter create .` directly inside this repository.

### Android

```powershell
powershell -ExecutionPolicy Bypass -File .\tool\bootstrap_android.ps1
flutter pub get
flutter run
```

### Windows desktop

```powershell
powershell -ExecutionPolicy Bypass -File .\tool\bootstrap_windows.ps1
flutter pub get
flutter run -d windows
```

### Web

```powershell
powershell -ExecutionPolicy Bypass -File .\tool\bootstrap_web.ps1
flutter pub get
flutter run -d chrome
```

Each bootstrap script creates a temporary Flutter scaffold and copies only the required platform directory into this repository.

## Verification

The adaptive login milestone passed:

- 16 Flutter tests
- desktop two-column layout test
- tablet layout test
- short-phone overflow test
- `flutter analyze` with no issues
- Android APK build
- Windows release build
- Web release build

## Next milestone

Replace the temporary authenticated destination with the Campus Club home experience, then add the Clubs/Events JSON flow.
