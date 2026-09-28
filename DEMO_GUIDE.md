# Demo Guide

The login screen is adaptive. It does not render a phone-shaped rectangle on a desktop monitor.

## Android phone
Use the packaged APK when available. No Flutter installation is required on the phone.

Demo login:
- Student ID / Email: DEMO
- Password: TEAM17

## Windows college PC
Use the packaged Windows ZIP when available:
1. Extract the ZIP.
2. Open the extracted folder.
3. Run the Team 17 executable.
4. The login page opens directly.

Flutter does not need to be installed on the demonstration PC.

## Browser during development
If Flutter is installed:

```powershell
powershell -ExecutionPolicy Bypass -File .\tool\bootstrap_web.ps1
flutter pub get
flutter run -d chrome
```

## Layout behavior
- Phone: single-column login.
- Tablet: centered, wider login form.
- Desktop/large monitor: full two-column Campus Club presentation with the login form on the right.

The desktop layout intentionally uses the monitor instead of displaying a narrow mobile mockup in the center.
