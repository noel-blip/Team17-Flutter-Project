# Flutter Login Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the locked A + tiny B Flutter login experience with system light/dark themes, local JSON authentication, validation, success feedback, and a project-neutral placeholder home screen.

**Architecture:** Keep the app small and project-neutral. `AppTheme` owns light/dark tokens, `AuthService` owns credential parsing/loading/authentication, `LoginScreen` owns UI state and validation, and `PlaceholderHomeScreen` is the temporary post-login destination. The repository starts without a Flutter platform scaffold, so CI will install Flutter and create an Android scaffold in the build workspace before analyze/test/build; the product source remains independent of this college PC.

**Tech Stack:** Flutter/Dart, Material 3, local JSON assets, Flutter widget/unit tests, GitHub Actions.

**Spec:** `docs/superpowers/specs/2026-09-28-login-screen-design.md`

## Global Constraints
- Use `ThemeMode.system`.
- Light background: `#F6F6F2`; light primary text: `#111111`.
- Dark background: approximately `#101010`; dark primary text: warm off-white.
- Muted-red accent around `#D63A2F`, used only for ACCESS, focus, and validation/error states.
- No gradients, glassmorphism, hero art, decorative blobs, nested card stacks, or looping decorative motion.
- Password is obscured by default and toggled with text `SHOW` / `HIDE`.
- Continue button press scale target: approximately `0.985`.
- Authentication source: `assets/credentials.json`.
- Success state: `Verified ✓` briefly, then navigate.
- Invalid/missing JSON must fail safely instead of crashing.
- Layout must remain usable when the keyboard is open on normal Android phone sizes.

## Review Focus
- Missing or malformed `assets/credentials.json` must leave the app usable and show safe login feedback rather than crash.
- Empty username and empty password must surface the exact approved validation copy at the correct field.
- Wrong credentials must never navigate and must show `Credentials don't match`.
- System light/dark theme changes must preserve readable contrast and the same visual identity.
- Small-height screens / open keyboard must scroll rather than overflow.

---

### Task 1: Flutter package foundation and theme shell

**Files:**
- Create: `pubspec.yaml`
- Create: `analysis_options.yaml`
- Create: `.gitignore`
- Create: `lib/main.dart`
- Create: `lib/theme/app_theme.dart`
- Test: `test/theme/app_theme_test.dart`

**Interfaces:**
- Produces: `AppTheme.light`, `AppTheme.dark`, and `MyApp({required AuthService authService})`.
- Consumes: `AuthService` from Task 2.

- [ ] **Step 1: Write the failing theme test**

Assert that:
- light scaffold background is `Color(0xFFF6F6F2)`,
- dark scaffold background is near `Color(0xFF101010)`,
- light/dark schemes expose the muted-red accent,
- `MyApp` uses `ThemeMode.system`.

- [ ] **Step 2: Run tests and confirm failure**

Run: `flutter test test/theme/app_theme_test.dart`  
Expected: FAIL because the theme/app files do not exist.

- [ ] **Step 3: Implement the minimal package and theme shell**

Create a minimal Flutter package in `pubspec.yaml`, register `assets/credentials.json`, and implement `AppTheme` plus `MyApp` with Material 3 and system theme mode.

- [ ] **Step 4: Run the theme test**

Run: `flutter test test/theme/app_theme_test.dart`  
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add pubspec.yaml analysis_options.yaml .gitignore lib/main.dart lib/theme/app_theme.dart test/theme/app_theme_test.dart
git commit -m "feat: add flutter app shell and system themes"
```

### Task 2: Local JSON authentication service

**Files:**
- Create: `assets/credentials.json`
- Create: `lib/auth/auth_service.dart`
- Test: `test/auth/auth_service_test.dart`

**Interfaces:**
- Produces:
  - `Credential(username, password)`
  - `AuthService.fromJson(String json)`
  - `AuthService.loadFromAsset(String assetPath)`
  - `bool authenticate(String username, String password)`
  - safe load-error state for invalid/missing asset data.
- Consumes: Flutter `rootBundle` only in the production asset-loading path.

- [ ] **Step 1: Write failing unit tests**

Tests must pin:
- valid JSON parses one or more users,
- `24NE1A42E7` + `123456` authenticates,
- wrong password returns false,
- unknown user returns false,
- malformed JSON produces a safe unavailable/error state rather than throwing through the app.

- [ ] **Step 2: Run tests and confirm failure**

Run: `flutter test test/auth/auth_service_test.dart`  
Expected: FAIL because `AuthService` does not exist.

- [ ] **Step 3: Implement `AuthService`**

Keep parsing independent from `rootBundle` so unit tests use raw JSON strings; use `loadFromAsset` only as the production adapter.

- [ ] **Step 4: Run auth tests**

Run: `flutter test test/auth/auth_service_test.dart`  
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add assets/credentials.json lib/auth/auth_service.dart test/auth/auth_service_test.dart
git commit -m "feat: add local json authentication"
```

### Task 3: Final locked login UI and interaction states

**Files:**
- Create: `lib/auth/login_screen.dart`
- Test: `test/auth/login_screen_test.dart`

**Interfaces:**
- Consumes: `AuthService`, `AppTheme`.
- Produces: `LoginScreen({required AuthService authService})`.

- [ ] **Step 1: Write failing widget tests**

Pin the approved UI and behavior:
- `ACCESS`, `Sign in`, support copy, Student ID / Email, Password, `SHOW`, Continue, and Demo access are present,
- password starts obscured,
- SHOW changes to HIDE and reveals text,
- empty username shows `Enter your student ID or email`,
- empty password shows `Enter your password`,
- wrong credentials show `Credentials don't match`,
- keyboard/small-height pump does not throw overflow exceptions.

- [ ] **Step 2: Run widget tests and confirm failure**

Run: `flutter test test/auth/login_screen_test.dart`  
Expected: FAIL because `LoginScreen` does not exist.

- [ ] **Step 3: Implement the approved screen**

Use:
- `SafeArea` + scrollable content,
- text/underline fields rather than large cards,
- muted-red focused underline and validation states,
- SHOW/HIDE text control,
- moderately rounded primary button,
- `AnimatedScale` or equivalent for the ~0.985 press state,
- restrained state transitions only.

- [ ] **Step 4: Run login widget tests**

Run: `flutter test test/auth/login_screen_test.dart`  
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/auth/login_screen.dart test/auth/login_screen_test.dart
git commit -m "feat: build final responsive login screen"
```

### Task 4: Verified-success flow and placeholder home

**Files:**
- Create: `lib/home/placeholder_home_screen.dart`
- Modify: `lib/auth/login_screen.dart`
- Modify: `test/auth/login_screen_test.dart`

**Interfaces:**
- Consumes: `AuthService.authenticate`.
- Produces: navigation from successful login to `PlaceholderHomeScreen`.

- [ ] **Step 1: Add failing success-flow widget tests**

Verify:
- valid credentials change button copy to `Verified ✓`,
- navigation occurs after the short success delay,
- destination confirms authentication success,
- invalid credentials never navigate.

- [ ] **Step 2: Run the focused tests**

Run: `flutter test test/auth/login_screen_test.dart`  
Expected: FAIL on the success-navigation assertions.

- [ ] **Step 3: Implement success flow**

On valid authentication:
1. dismiss keyboard,
2. show `Verified ✓`,
3. wait a short restrained interval,
4. navigate with replacement to `PlaceholderHomeScreen`.

- [ ] **Step 4: Run all tests**

Run: `flutter test`  
Expected: all tests PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/home/placeholder_home_screen.dart lib/auth/login_screen.dart test/auth/login_screen_test.dart
git commit -m "feat: add verified login navigation"
```

### Task 5: CI verification and Android-build bootstrap

**Files:**
- Create: `.github/workflows/flutter-ci.yml`
- Modify: `README.md`

**Interfaces:**
- Consumes: repository source from Tasks 1-4.
- Produces: automated analyze/test/APK-build verification on GitHub without requiring Flutter on the college PC.

- [ ] **Step 1: Add CI workflow**

Workflow on pushes/PRs to `main`:
1. checkout,
2. set up Java,
3. install stable Flutter,
4. create a temporary Android scaffold with package/org `com.team17` / `team17_flutter_project`,
5. copy the generated `android/` directory into the CI workspace only when the repo lacks one,
6. run `flutter pub get`,
7. run `flutter analyze`,
8. run `flutter test`,
9. run `flutter build apk --debug`.

- [ ] **Step 2: Update README**

Document:
- current login milestone,
- demo credential,
- how to clone,
- on a machine with Flutter: if `android/` is not yet committed, run `flutter create . --platforms=android --org com.team17 --project-name team17_flutter_project` once before local Android run,
- then `flutter pub get` and `flutter run`.

- [ ] **Step 3: Push and verify GitHub Actions**

Expected:
- analyze PASS,
- tests PASS,
- debug APK build PASS.

- [ ] **Step 4: If CI exposes a real failure, fix only the failing layer and rerun**

Do not change the locked design to silence tooling.

- [ ] **Step 5: Final verification commit if needed**

Commit only corrections proven necessary by CI.
