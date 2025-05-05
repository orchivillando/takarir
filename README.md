# Takarir

[![License](https://img.shields.io/github/license/orchivillando/takarir)](LICENSE)
[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![macOS](https://img.shields.io/badge/Platform-macOS-lightgrey)](https://www.apple.com/macos/)
[![Made with SwiftUI](https://img.shields.io/badge/UI-SwiftUI-blue)](https://developer.apple.com/xcode/swiftui/)

**Takarir** is a lightweight and user-friendly macOS application that allows you to easily generate subtitles from video files using advanced speech recognition technology.

🎬 Simply drag and drop your video, select your preferred language, and Takarir will automatically create accurate subtitles for you.

---

## ✨ Features

- 🎤 Offline speech-to-text using Whisper
- 📼 Drag and drop video files
- 📜 Auto-generate `.srt` subtitle files
- 🌐 Multi-language transcription
- 💻 Works 100% locally, no internet upload required
- 🔧 Customizable Python and script path in settings

---

## 🛠️ Requirements

- macOS 12.0 or newer
- FFmpeg installed (`brew install ffmpeg`)
- Python 3.10+ with Whisper and dependencies installed

---

## 🚀 Usage

1. **Download** the latest `.dmg` from the [Releases](https://github.com/orchivillando/takarir/releases) page.
2. **Drag and drop** your video file.
3. Click **"Create Subtitles"**.
4. Get your `.srt` file in the same directory as your video.

---

## 📦 Installation (Development)

```bash
git clone https://github.com/orchivillando/takarir.git
cd takarir
open Takarir.xcodeproj
