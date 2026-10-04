# 🚌 BRTS Surat

A Flutter-based mobile application designed to make travelling through Surat BRTS easier by providing route planning, bus information, fare details, route maps, notifications, and ticket information in one place.

---

## 📱 About the Project

**BRTS Surat** is a mobile application developed to provide a simple and convenient way for passengers to access important Surat BRTS information.

The application brings commonly required BRTS services together in a single mobile interface, allowing users to plan their journey, explore bus routes, check fares, view the route map, and access ticket and notification information.

The frontend is developed using **Flutter and Dart**, while the backend is built using **Node.js and Express.js**. **MongoDB Atlas** is used for storing bus, route, and stop data, and the backend is deployed using **Render**.

---

## ✨ Features

### 🗺️ Plan Your Trip

- Select the source and destination BRTS stops
- Search for available routes
- View route information
- Fetch route and stop data through the backend API

### 🚌 Bus Details

- Select/search for a bus number
- View the route associated with the bus
- View the stops covered by the bus
- Display complete bus journey information

### 🎫 My Tickets

- View available ticket information
- Display multiple tickets
- Expand ticket cards to view passenger details
- View passenger name and age information

### 🔔 Notifications

- Dedicated notifications screen
- Display important BRTS-related information and updates

### 💰 Fare Chart

The application provides distance-wise ticket fares and pass charges.

#### Distance-wise Ticket Fare

| Distance | Fare |
|----------|------|
| 0–2 km | ₹5 |
| 2–4 km | ₹10 |
| 4–6 km | ₹15 |
| 6–10 km | ₹20 |
| Over 10 km | ₹25 |

#### Pass Charges

| Duration | Student / Women | General |
|----------|-----------------|---------|
| 1 Month | ₹100 | ₹700 |
| 3 Months | ₹300 | ₹1,900 |
| 6 Months | ₹500 | ₹3,600 |
| 1 Year | ₹1,000 | ₹7,000 |

### 🗺️ Route Map

- Dedicated BRTS route map
- Zoom support
- Pan support
- High-quality route map display

### 🎨 User Interface

- Clean and simple mobile interface
- Easy navigation
- Dedicated screens for major features
- Custom BRTS application icon

---

## 🛠️ Tech Stack

### Frontend

- **Flutter**
- **Dart**
- **Material Design**

### Backend

- **Node.js**
- **Express.js**
- **REST API**

### Database

- **MongoDB Atlas**

### Deployment

- **Render**

### Development Tools

- **Visual Studio Code**
- **Git**
- **GitHub**
- **Xcode**
- **Flutter CLI**

---

# User Application Flow
    User
      │
      ▼
    Flutter Mobile Application
      │
      │ API Request
      ▼
    Node.js + Express Backend
      │
      │ Query
      ▼
    MongoDB Atlas
      │
      │ Data
      ▼
    Backend API
      │
      ▼
    Flutter Application
      │
      ▼
    Information displayed to User

--- 

# Backend APIs

    GET /api/stops
    GET /api/routes
    GET /api/buses
    GET /api/bus-details?bus_no=<bus_number>
    GET /api/route-stops
    GET /api/find-route?from=<stop_id>&to=<stop_id>

---

# Backend Repository

## BRTS Backend
  https://github.com/Misthaa0813/brts_backend

# 📂 Project Structure

```text
brts_surat/
│
├── android/
├── ios/
│
├── assets/
│   └── images/
│       ├── logo_image.jpg
│       └── route_image.jpg
│
├── lib/
│   ├── main.dart
│   │
│   ├── models/
│   │   ├── bus.dart
│   │   ├── bus_details.dart
│   │   ├── route.dart
│   │   └── stop.dart
│   │
│   ├── screens/
│   │   ├── bus_details_screen.dart
│   │   ├── fare_chart_screen.dart
│   │   ├── my_tickets_screen.dart
│   │   ├── notifications_screen.dart
│   │   ├── plan_trip_screen.dart
│   │   └── route_map_screen.dart
│   │
│   └── services/
│       ├── bus_service.dart
│       ├── route_service.dart
│       └── stop_service.dart
│
├── test/
│   └── widget_test.dart
│
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
├── .gitignore
└── README.md
---  

## 🏗️ Project Architecture

                    ┌──────────────────────┐
                    │      BRTS Surat      │
                    │   Flutter Mobile App │
                    └──────────┬───────────┘
                               │
                               │ HTTP Requests
                               ▼
                    ┌──────────────────────┐
                    │   Node.js + Express  │
                    │      REST API        │
                    └──────────┬───────────┘
                               │
                               │ Database Queries
                               ▼
                    ┌──────────────────────┐
                    │    MongoDB Atlas     │
                    │ Bus / Route / Stop   │
                    │       Data           │
                    └──────────────────────┘

---

```

# 🎯 Future Improvements

## The following features can be considered for future versions of BRTS Surat:

📍 Live bus tracking
🚌 Real-time bus arrival information
🗺️ Interactive route navigation
🎫 Online ticket booking
💳 Digital payment integration
⭐ Favourite routes and stops
🔔 Push notifications
🌙 Dark mode
👤 User authentication
📊 Travel history and analytics

---

# 👩‍💻 Developer
Sharmistha Hazra

B.E. Computer Engineering
Gujarat Technological University

##Technologies

Flutter • Dart • Node.js • Express.js • MongoDB • REST API • Git • GitHub




