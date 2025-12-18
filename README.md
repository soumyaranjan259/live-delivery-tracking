# live_delivery_tracking

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Live Delivery Tracking Process Flow

## Tracking Screen (Main Screen)
a. App launches directly into the Live Delivery Tracking Screen
b. Displays a full-screen map centered on Necklace Road, Hyderabad
c. Shows the complete delivery route as a thick blue polyline with white border following real curved roads around Hussain Sagar Lake
d. Driver marker appears as a realistic top-view red scooter with delivery rider (rotates accurately based on heading)
e. Camera automatically follows the driver smoothly as movement progresses
f. Draggable bottom sheet (initially 35% height) shows live order details Real-Time Driver Simulation
a. On app start, tracking begins automatically (simulated WebSocket stream)
b. Driver location updates every 2 seconds using local mock data
c. Driver moves bit-by-bit along the exact predefined route (9 location points)
d. Marker rotates correctly according to heading value at each point
e. Status changes progressively based on index:

Index 0 → Picked
Index 1–4 → En Route
Index 5–7 → Arriving
Index 8 → Delivered

## Bottom Sheet Live Updates
a. Displays Order ID: ORD123456
b. Shows Driver Name: Ravi Kumar
c. Shows Vehicle: Honda Activa
d. Live Status with color coding:

Picked → Orange
En Route → Blue
Arriving → Purple
Delivered → Green
e. Shows ETA in minutes (decreases realistically)
f. Shows Distance Remaining in km (accurate calculation using Geolocator, updated live)
g. Shows Last Updated timestamp (current time at each update)Completion Flow
a. Driver reaches final destination (customer location near Necklace Road)
b. Status changes to Delivered
c. Distance remaining becomes 0.00 km
d. ETA becomes 0 minutes
e. Simulation stops automatically
f. User can restart by closing and reopening the app

## 🧠 State & Data Management
State Management: BLoC (flutter_bloc)
Data Source: Local mock JSON (assets/mock/route_hyd.json)
Simulation: Stream of LocationUpdate emitted every 2 seconds
Storage: No persistent storage needed (session-based simulation)
Map Library: flutter_map with OpenStreetMap tiles (real road view)
Architecture: Clean Architecture (MVVM pattern) with proper layer separation Deliverables Achieved

GitHub repository with clean commit history
Detailed README explaining setup and architecture
Working demo video showing full flow
Clean folder structure following Clean Architecture / MVVM principles
Fully working tracking flow with simulated real-time updates
High-quality UI/UX with realistic driver marker and smooth animations
