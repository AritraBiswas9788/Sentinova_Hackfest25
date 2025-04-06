# 🔍 Sentinova

> **AI-Powered Multichannel Sentiment Monitoring & Real-Time Issue Detection for Events**

Sentinova is an intelligent event-monitoring system that leverages **AI, audio-visual data, and real-time sentiment analysis** to ensure safety, detect technical glitches, and monitor audience experience during events. Whether you're hosting a concert, conference, or large gathering — Sentinova keeps a smart eye and ear on everything that matters.

---

## 📱 Preview

<img src="https://github.com/yourusername/sentinova/assets/preview1.gif" width="300" /> &nbsp;&nbsp;&nbsp; <img src="https://github.com/yourusername/sentinova/assets/preview2.gif" width="300" />

---

## 🚀 Features

✅ **Real-Time Audio Glitch Detection**  
✅ **Live Waveform Visualization**  
✅ **Sentiment Analysis on Social Media Posts**  
✅ **Crowd Overcrowding Detection using Camera**  
✅ **Configurable Detection Thresholds via UI**  
✅ **Responsive, Stylish UI with Live Stats & Logs**  
✅ **Modular Code Structure with GetX**  

---

## 🛠️ Tech Stack

| Feature              | Technology Used                       |
|---------------------|----------------------------------------|
| Mobile Framework     | Flutter + Dart                         |
| Audio Processing     | `flutter_audio_capture`, FFT & RMS     |
| Camera/Object Detection | PyTorch Mobile, Flutter Camera       |
| State Management     | GetX                                   |
| UI Design            | Material + Custom Gradient Theme       |
| Social Media Parsing | URL Launchers / API Integration (Planned) |

---

## 📸 Screenshots

| Audio Monitoring | Overcrowding Detection |
|------------------|------------------------|
| ![audio](assets/audio.gif) | ![vision](assets/crowd.gif) |

---

## ⚙️ How It Works

### 🎤 Audio Module

- Captures live microphone data
- Computes **RMS** & **FFT Energy** to detect noise bursts, glitches, feedback, etc.
- Visualizes real-time waveform and stats
- Logs glitch events dynamically

### 📷 Vision Module

- Uses **PyTorch Mobile** to detect number of people via object detection
- Triggers overcrowding alert based on adjustable threshold

### 🧠 Sentiment Module

- Parses tweets/posts using Twitter API
- Classifies tone (positive, neutral, negative)
- Flags bursts of negativity during event in real-time

---

## 🧪 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/sentinova.git
cd sentinova
