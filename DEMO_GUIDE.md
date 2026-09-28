# Demo Guide

## Fastest option for a college monitor

Use the Windows build. Flutter is not required on the demonstration PC.

1. In GitHub, open **Actions**.
2. Open **Demo Builds**.
3. Click **Run workflow** if a fresh build is needed.
4. Download the `Team17-Windows` artifact.
5. Extract the ZIP completely.
6. Run `team17_flutter_project.exe`.

Do not run only the EXE by itself. Keep the EXE, `flutter_windows.dll`, and the `data/` folder together.

## Android phone

Download the `Team17-Android-APK` artifact, extract `app-debug.apk`, and install it on the Android phone.

## Browser / web hosting

Download `Team17-Web-Bundle` for a production web build. It is intended to be served by a web server or hosting service rather than opened directly with `file://`.

For local browser development when Flutter is installed:

```powershell
powershell -ExecutionPolicy Bypass -File .\tool\bootstrap_web.ps1
flutter pub get
flutter run -d chrome
```

## Demo login

- Student ID / Email: `DEMO`
- Password: `TEAM17`

## Layout behavior

- under 600 px: phone layout
- 600–999 px: tablet layout
- 1000 px and above: full desktop two-column layout

The desktop layout uses the monitor as a desktop application rather than drawing a small vertical mobile screen in the middle.
