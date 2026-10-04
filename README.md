# 🚌 BRTSConnect Surat

A Flutter-based mobile application designed to make Surat BRTS travel easier by providing route planning, bus information, fare details, route maps, notifications, and digital ticket information in one place.

## 📱 About the Project

**BRTSConnect Surat** is a mobile application developed to improve the public transportation experience for passengers using the Surat Bus Rapid Transit System (BRTS).

The application allows users to:

- Plan a journey between two BRTS stops
- Find available routes between source and destination
- View bus details and stops
- Check distance-wise ticket fares
- View monthly, quarterly, half-yearly, and yearly pass charges
- View the BRTS route map
- Access ticket information
- View important notifications
- Use a simple and user-friendly mobile interface

The application is built using **Flutter and Dart** with a REST API backend developed using **Node.js and Express.js**. MongoDB Atlas is used for database management, and the backend is deployed on Render.

---

## ✨ Features

### 🗺️ Plan Your Trip
- Select source and destination BRTS stops
- Search for available routes
- Display route information
- Fetch real-time data from the backend API

### 🚌 Bus Details
- Search/select a bus number
- View associated route information
- View stops covered by the bus
- Display complete bus journey details

### 🎫 My Tickets
- View available ticket information
- Display multiple tickets
- Expand ticket cards to view passenger details

### 💰 Fare Chart
Provides:

**Distance-wise Ticket Fare**

| Distance | Fare |
|----------|------|
| 0–2 km | ₹5 |
| 2–4 km | ₹10 |
| 4–6 km | ₹15 |
| 6–10 km | ₹20 |
| Over 10 km | ₹25 |

**Pass Charges**

| Duration | Student/Women | General |
|----------|---------------|---------|
| 1 Month | ₹100 | ₹700 |
| 3 Months | ₹300 | ₹1,900 |
| 6 Months | ₹500 | ₹3,600 |
| 1 Year | ₹1,000 | ₹7,000 |

### 🗺️ Route Map
- Dedicated BRTS route map screen
- Zoom and pan support
- High-quality route map display

### 🔔 Notifications
- Dedicated notification screen
- Displays important BRTS-related information and updates

### 🎨 User Interface
- Clean and simple Flutter UI
- Easy navigation
- Dedicated screens for each major feature
- Custom BRTS application icon

---

## 🛠️ Tech Stack

### Frontend
- Flutter
- Dart
- Material Design

### Backend
- Node.js
- Express.js
- REST API

### Database
- MongoDB Atlas

### Deployment
- Render

### Development Tools
- Visual Studio Code
- Git
- GitHub
- Xcode
- Flutter CLI

---

## 🏗️ Project Architecture

```text
BRTSConnect Surat
│
├── Flutter Mobile Application
│   │
│   ├── Screens
│   │   ├── Home
│   │   ├── Plan Your Trip
│   │   ├── Bus Details
│   │   ├── My Tickets
│   │   ├── Notifications
│   │   ├── Fare Chart
│   │   └── Route Map
│   │
│   ├── Models
│   │   ├── Bus
│   │   ├── Bus Details
│   │   ├── Route
│   │   └── Stop
│   │
│   └── Services
│       ├── Bus Service
│       ├── Route Service
│       └── Stop Service
│
└── Backend
    │
    ├── Node.js
    ├── Express.js
    ├── REST APIs
    └── MongoDB Atlas
