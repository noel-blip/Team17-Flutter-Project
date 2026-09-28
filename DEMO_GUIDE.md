# Demo Guide

Live web app: https://noel-blip.github.io/Team17-Flutter-Project/

## Fastest option: download from GitHub Releases

No pendrive and no Flutter installation are required on the demonstration machine.

Open the repository's **Releases** page and download:

- `Team17-Campus-Club-Windows.zip` for a Windows PC
- `Team17-Campus-Club.apk` for Android
- `Team17-Campus-Club-Web.zip` for web hosting

## College Windows PC

1. Download `Team17-Campus-Club-Windows.zip` from Releases.
2. Extract the ZIP completely.
3. Run `team17_flutter_project.exe`.

Keep the EXE, `flutter_windows.dll`, and the `data/` folder together.

## Android phone

Download `Team17-Campus-Club.apk` from Releases and install it.

## Web

Primary method:

`https://noel-blip.github.io/Team17-Flutter-Project/`

No download or local server is needed for normal use.

The Web ZIP in Releases is kept as a backup/portable snapshot. After extracting it, open `RUN_LOCAL/`:

1. Double-click `START_WEB.cmd`.
2. It detects `python` or `py`.
3. It starts a local server.
4. It automatically opens `http://localhost:8000/`.
5. Keep the launcher window open; press Enter there to stop the server.

The same folder also includes `README.txt`, `LIVE_SITE.url`, and `LOCALHOST_8000.url`.

## Demo login

- Student ID / Email: `DEMO`
- Password: `TEAM17`

## Layout behavior

- under 600 px: phone layout
- 600–999 px: tablet layout
- 1000 px and above: full desktop two-column layout

All of these are builds of the same Flutter/Dart application source.