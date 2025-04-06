# 🔍 Sentinova

> **AI-Powered Multichannel Sentiment Monitoring & Real-Time Issue Detection for Events**

Sentinova is an intelligent event-monitoring system that leverages **AI, audio-visual data, and real-time sentiment analysis** to ensure safety, detect technical glitches, and monitor audience experience during events. Whether you're hosting a concert, conference, or large gathering — Sentinova keeps a smart eye and ear on everything that matters.

---

## 📱 Preview

<img src="https://github.com/yourusername/sentinova/assets/preview1.gif" width="300" /> &nbsp;&nbsp;&nbsp; <img src="https://github.com/yourusername/sentinova/assets/preview2.gif" width="300" />
| Audio Monitoring | Overcrowding Detection |
|------------------|------------------------|
|![WhatsApp Image 2025-04-06 at 12 55 38_1a3e264b](https://github.com/user-attachments/assets/ddc155c6-f2dc-46ac-8b14-19e52618b38d)|![WhatsApp Image 2025-04-06 at 12 55 39_9bb59782](https://github.com/user-attachments/assets/39f25b85-2db6-41af-aa7c-5bf097075b3d)|

![WhatsApp Image 2025-04-06 at 12 55 40_eec55513](https://github.com/user-attachments/assets/0ec1c902-fae5-4ff4-b786-9901f69af65b)
![WhatsApp Image 2025-04-06 at 12 55 41_06879ac5](https://github.com/user-attachments/assets/d0e36593-b0a3-4a93-9898-827ada351660)
![WhatsApp Image 2025-04-06 at 12 55 55_ac62153c](https://github.com/user-attachments/assets/346c4e33-9793-4efb-a078-5800e123eaeb)
![WhatsApp Image 2025-04-06 at 13 02 30_3dbcee93](https://github.com/user-attachments/assets/4771f9e1-b044-4616-8148-b732f1f83d12)
![WhatsApp Image 2025-04-06 at 13 02 31_c41ea533](https://github.com/user-attachments/assets/1e0cc175-8ed6-494a-9652-42968d3a0b60)
![WhatsApp Image 2025-04-06 at 13 02 31_226046a3](https://github.com/user-attachments/assets/65f0afb0-3081-40a6-aa78-8f7e5bafd9b2)


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
| ![WhatsApp Image 2025-04-06 at 13 09 23_33907455](https://github.com/user-attachments/assets/d8db12d9-95ad-40f8-b04b-d49227ffd27b) | ![WhatsApp Image 2025-04-06 at 13 11 00_f7adefec](https://github.com/user-attachments/assets/b5ad35f1-bc83-4725-9b92-c8df66881558) |



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
