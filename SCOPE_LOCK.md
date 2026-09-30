# Scope Lock

## Status
LOCKED — Login milestone complete.

The Team 17 Campus Club Flutter project is intentionally frozen at the verified login milestone until the faculty provides a new concrete project requirement or the team explicitly decides to reopen development.

## Current authentication model
This milestone uses local synthetic demo credentials stored in project data.

- Student ID / Email: `DEMO`
- Password: `TEAM17`
- no production user database
- no password-reset service
- no Google/OAuth provider
- no email/SMS identity recovery flow

## Deliberate exclusions
The login screen intentionally does not include:

- Forgot password
- Sign in with Google
- Sign in with other social providers
- account registration

Those controls would require additional authentication infrastructure and configuration to perform real work. Adding non-functional buttons only to imitate a production login screen is outside the locked milestone.

## Preserved deliverables
The locked project keeps all verified distribution paths operational:

- live GitHub Pages web app
- Windows release build
- Android APK
- Web backup ZIP with local launcher
- automated verification/build workflows
- existing tests and analyzer checks

## Reopen condition
Development should resume only when there is a specific new requirement to implement, such as a real home page, clubs/events flow, production authentication, or another faculty-approved feature.

Until then, no feature work is planned.
