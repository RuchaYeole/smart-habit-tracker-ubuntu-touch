# Smart Habit Tracker (Ubuntu Touch + QML)

A modern Ubuntu Touch productivity application built using QML, Ubuntu Components, SQLite, and Clickable for OSSCI Module 6.

---

# Features

## Core Features
- Add habits
- Delete habits
- Mark habits as completed
- Habit streak system
- SQLite local persistence
- Multi-page Ubuntu Touch navigation
- Real-time UI updates

## Productivity Features
- Focus score system
- Productivity analytics
- Progress dashboard
- Pomodoro timer
- Weekly progress tracking

## UI Features
- Modern QML UI
- Gradient-based interface
- Mobile-friendly layouts
- Professional habit cards
- Ubuntu Touch compatible design

---

# Tech Stack

| Technology | Purpose |
|---|---|
| QML | Frontend UI |
| Ubuntu.Components 1.3 | Ubuntu Touch UI Framework |
| SQLite | Local database |
| QtQuick.LocalStorage | Database access |
| Clickable | Ubuntu Touch build system |
| Ubuntu Touch | Mobile Linux platform |

---

# Project Structure

```text
smart-habit-tracker/
│
├── qml/
│   ├── Main.qml
│   ├── pages/
│   ├── components/
│   └── database/
│
├── clickable.yaml
├── manifest.json
├── CMakeLists.txt
├── smart-habit.desktop
└── smart-habit.apparmor