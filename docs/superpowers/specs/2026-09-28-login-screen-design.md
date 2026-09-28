# Flutter Login Screen Design Spec

## Goal
Build a project-neutral Flutter login screen that follows the device theme automatically, uses the locked **A + tiny B** visual language, validates credentials from a local JSON asset, and remains reusable if the final project changes.

## Scope
Only: login UI, light/dark theming, local JSON credential loading, validation/feedback, and navigation to a temporary placeholder home screen.

Not included: Firebase, online accounts, registration, password reset, Google sign-in, backend services, or final project-specific home UI.

## Visual Direction
**90% Apple-style restraint**
- warm off-white light background
- near-black dark background
- strong typography and generous spacing
- no giant logo, hero art, gradients, glassmorphism, decorative blobs, or nested card stacks

**10% Nothing-inspired detail**
- small uppercase `ACCESS` label above the title
- one muted-red accent
- accent only for `ACCESS`, focused underline, and validation/error states

## Theme
Use `ThemeMode.system`.

### Light
- Background: `#F6F6F2`
- Main text: `#111111`
- Primary button: near-black
- Button text: off-white
- Accent: approximately `#D63A2F`

### Dark
- Background: approximately `#101010`
- Main text: warm off-white
- Primary button: warm off-white
- Button text: near-black
- Same muted-red accent family, adjusted only if contrast requires it

Dark mode must feel like the same app with the lights turned off.

## Layout
1. `ACCESS`
2. `Sign in`
3. `Use your student ID or email to continue.`
4. Student ID / Email
5. Password with `SHOW` / `HIDE`
6. Continue
7. Small `Demo access` text

## Inputs
- quiet underline by default
- focused underline transitions to accent red
- empty-field validation appears below the relevant field
- password is obscured by default
- `SHOW` / `HIDE` toggles visibility

## Continue Button
- near-black in light mode
- off-white in dark mode
- moderately rounded, not pill-shaped
- subtle press compression around `0.985x`
- no glow or gradient

## Authentication
Credentials live in `assets/credentials.json`.

```json
[
  {
    "username": "24NE1A42E7",
    "password": "123456"
  }
]
```

The app loads the JSON, parses credentials, validates entered values, rejects empty fields and mismatches, and navigates on a successful match.

## Feedback
- Empty username: `Enter your student ID or email`
- Empty password: `Enter your password`
- Wrong credentials: `Credentials don't match`
- Success: button briefly becomes `Verified ✓`, then navigate to placeholder home

## Motion
Allowed only when it communicates interaction/state:
- focus underline
- tiny button press
- restrained validation transition
- short success transition

No looping decorative motion, animated gradients, glowing borders, or unnecessary bouncing.

## Temporary Home
A minimal project-neutral placeholder confirming authentication succeeded.

## Reliability
- keyboard must not cause overflow
- screen must fit normal Android phone sizes
- password hidden by default
- readable contrast in both themes
- invalid/missing JSON fails safely instead of crashing

## Acceptance Criteria
1. App opens to login
2. Light theme works
3. Dark theme works
4. Validation works
5. SHOW/HIDE works
6. JSON credentials load
7. Wrong credentials stay on login with feedback
8. Valid credentials show `Verified ✓`
9. Valid credentials navigate to placeholder home
10. No visible overflow on the tested device/emulator
