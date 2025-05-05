# Takarir v1.0

<img src="https://private-user-images.githubusercontent.com/141236550/440423210-dea21954-6852-45a7-8d06-9fd537aed122.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDY0NTgzMjMsIm5iZiI6MTc0NjQ1ODAyMywicGF0aCI6Ii8xNDEyMzY1NTAvNDQwNDIzMjEwLWRlYTIxOTU0LTY4NTItNDVhNy04ZDA2LTlmZDUzN2FlZDEyMi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNTA1JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDUwNVQxNTEzNDNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT02MjExYTE2MTEwOWM4MjRhZTIzYTQ1ZWJhNTg1MTIzYTBlMGVjNjFjMGU1MjUzZTI3ZmJkYjA2OWY0ZjRiMjU0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.8T1e29v45bCvmJ287ugUJzqtK6ebLoxnPPuSFQkQTGA" alt="Logo" width="200"/>

![Logo](images/logo.png)


[![License](https://img.shields.io/github/license/orchivillando/takarir)](LICENSE)
[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![macOS](https://img.shields.io/badge/Platform-macOS-lightgrey)](https://www.apple.com/macos/)
[![Made with SwiftUI](https://img.shields.io/badge/UI-SwiftUI-blue)](https://developer.apple.com/xcode/swiftui/)

**Takarir** is a lightweight and user-friendly macOS application that allows you to easily generate subtitles from video files using advanced speech recognition technology.

🎬 Simply drag and drop your video, select your preferred language, and Takarir will automatically create accurate subtitles for you — all running fully offline on your Mac.

---

## ✨ Features

- 🎤 Offline speech-to-text using [OpenAI Whisper](https://github.com/openai/whisper)
- 📼 Drag and drop video files
- 📜 Auto-generate `.srt` subtitle files
- 🌐 Multi-language transcription
- 💻 Works 100% locally, no internet upload required
- 🔧 Customizable Python and script path in settings

---

## 🔧 Powered by

This app is a native macOS frontend for the open-source terminal tool  
[`create_subtitles`](https://github.com/ErenEmreK/create_subtitles) by **Eren Emre K**,  
which handles the actual subtitle generation using FFmpeg and Whisper.

All subtitle generation logic is based on that tool, adapted to work through a GUI.

---

## 🛠️ Requirements

- macOS 12.0 or newer
- FFmpeg installed (`brew install ffmpeg`)
- Python 3.10+ with [Whisper](https://github.com/openai/whisper) installed

---

## 🚀 Usage

1. **Download** the latest `.dmg` from the [Releases](https://github.com/orchivillando/takarir/releases) page.
2. **Drag and drop** your video file.
3. Click **"Create Subtitles"**.
4. Get your `.srt` file in the same directory as your video.

---

## ⚙️ Settings

In the **Settings tab**, you can configure:
- Python executable path (e.g. `/Users/you/.pyenv/versions/3.10.13/bin/python`)
- Path to `create_subtitles.py` script

---

## 📦 Installation (Development)

```bash
git clone https://github.com/orchivillando/takarir.git
cd takarir
open Takarir.xcodeproj
