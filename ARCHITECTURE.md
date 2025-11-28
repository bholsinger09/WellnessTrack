# Wellness Tracker - Architecture Diagram

## System Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         Mobile Clients                          │
│  ┌──────────┐      ┌──────────┐      ┌──────────────────┐     │
│  │   iOS    │      │ Android  │      │    Windows       │     │
│  │ (iPhone) │      │ (Phone)  │      │   (Desktop)      │     │
│  └──────────┘      └──────────┘      └──────────────────┘     │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             │ Flutter Framework
                             │
┌────────────────────────────▼────────────────────────────────────┐
│                    Application Layer                            │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐   │
│  │              Presentation Layer                         │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────────────┐    │   │
│  │  │ Screens  │  │ Widgets  │  │   Providers      │    │   │
│  │  │  (UI)    │  │ (Reuse)  │  │ (State Mgmt)     │    │   │
│  │  └──────────┘  └──────────┘  └──────────────────┘    │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐   │
│  │               Domain Layer                              │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────────────┐    │   │
│  │  │ Models   │  │ Entities │  │  Business Logic  │    │   │
│  │  │          │  │          │  │                  │    │   │
│  │  └──────────┘  └──────────┘  └──────────────────┘    │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐   │
│  │                Data Layer                               │   │
│  │  ┌──────────────┐  ┌────────────────────────────┐     │   │
│  │  │ Repositories │  │   Data Sources             │     │   │
│  │  │              │  │ (Firebase, Local Storage)  │     │   │
│  │  └──────────────┘  └────────────────────────────┘     │   │
│  └────────────────────────────────────────────────────────┘   │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               │ Network Layer
                               │
┌──────────────────────────────▼──────────────────────────────────┐
│                     Firebase Backend                            │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Firebase     │  │  Firestore   │  │  Realtime    │         │
│  │     Auth     │  │   Database   │  │   Database   │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │   Cloud      │  │   Storage    │  │  Functions   │         │
│  │  Messaging   │  │              │  │   (AI API)   │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
└──────────────────────────────────────────────────────────────────┘
                               │
                               │ AI Services
                               │
┌──────────────────────────────▼──────────────────────────────────┐
│                      Google Gemini AI                           │
│               (AI Journaling Insights)                          │
└──────────────────────────────────────────────────────────────────┘
```

## Feature Module Architecture

```
Feature Module (e.g., Mood Tracking)
│
├── presentation/
│   ├── screens/
│   │   └── mood_check_in_screen.dart        ← UI Layer
│   ├── widgets/
│   │   └── mood_selector_widget.dart        ← Reusable UI
│   └── providers/
│       └── mood_provider.dart                ← State Management
│
├── domain/
│   ├── models/
│   │   └── mood_log.dart                     ← Data Models
│   └── usecases/
│       └── log_mood_usecase.dart             ← Business Logic
│
└── data/
    ├── repositories/
    │   └── mood_repository.dart              ← Data Access
    └── datasources/
        └── mood_remote_datasource.dart       ← Firebase API
```

## Data Flow

```
┌─────────────┐
│    User     │
│  Interaction│
└──────┬──────┘
       │
       ▼
┌─────────────────┐
│   UI Screen     │ ──────┐
│  (Presentation) │       │
└─────────────────┘       │
                          │  User Action
                          │
┌─────────────────┐       │
│   Provider      │◄──────┘
│ (State Manager) │
└────────┬────────┘
         │
         │ Call Repository
         ▼
┌─────────────────┐
│   Repository    │
│  (Data Layer)   │
└────────┬────────┘
         │
         │ API Call
         ▼
┌─────────────────┐
│   Firebase      │
│    Backend      │
└────────┬────────┘
         │
         │ Response
         ▼
┌─────────────────┐
│   Repository    │
│ (Process Data)  │
└────────┬────────┘
         │
         │ Update State
         ▼
┌─────────────────┐
│   Provider      │
│ (Notify UI)     │
└────────┬────────┘
         │
         │ Rebuild Widget
         ▼
┌─────────────────┐
│   UI Screen     │
│ (Show Result)   │
└─────────────────┘
```

## Authentication Flow

```
┌──────────────┐
│  User Opens  │
│     App      │
└──────┬───────┘
       │
       ▼
┌──────────────┐     No      ┌──────────────┐
│ Check Auth   │─────────────▶│ Login Screen │
│    State     │              └──────┬───────┘
└──────┬───────┘                     │
       │ Yes                          │ Sign In
       │                              ▼
       │                    ┌──────────────────┐
       │                    │ Firebase Auth    │
       │                    │ Authenticate     │
       │                    └──────┬───────────┘
       │                           │
       │                           │ Success
       │◄──────────────────────────┘
       │
       ▼
┌──────────────┐
│ Home Screen  │
│  (Dashboard) │
└──────────────┘
```

## Feature Access Flow

```
Home Screen
    │
    ├──▶ Mood Check-In
    │       └──▶ Select Mood
    │            └──▶ Add Notes (Optional)
    │                 └──▶ Save to Firestore
    │
    ├──▶ Sleep & Study Tracker
    │       ├──▶ View Charts
    │       └──▶ Log New Entry
    │            └──▶ Save to Firestore
    │
    ├──▶ Meditation Timer
    │       └──▶ Select Duration
    │            └──▶ Start Timer
    │                 └──▶ Save Session
    │
    ├──▶ Peer Support Chat
    │       └──▶ Join Room (Anonymous)
    │            └──▶ Send Messages
    │                 └──▶ Realtime Database
    │
    └──▶ AI Journal
            └──▶ Write Entry
                 ├──▶ Get AI Insights
                 │    └──▶ Cloud Function
                 │         └──▶ Gemini API
                 └──▶ Save Entry
                      └──▶ Firestore
```

## State Management Pattern

```
┌─────────────────────────────────────────────────────────┐
│                    Widget Tree                          │
│                                                          │
│  ┌────────────────────────────────────────────┐        │
│  │         MaterialApp                         │        │
│  │  ┌───────────────────────────────────────┐ │        │
│  │  │     MultiProvider                     │ │        │
│  │  │  ┌─────────────────────────────────┐ │ │        │
│  │  │  │   AuthProvider                  │ │ │        │
│  │  │  │   MoodProvider                  │ │ │        │
│  │  │  │   JournalProvider               │ │ │        │
│  │  │  └─────────────────────────────────┘ │ │        │
│  │  │                                       │ │        │
│  │  │  ┌─────────────────────────────────┐ │ │        │
│  │  │  │   Consumer<AuthProvider>        │ │ │        │
│  │  │  │     └──▶ LoginScreen            │ │ │        │
│  │  │  │           or                    │ │ │        │
│  │  │  │          HomeScreen             │ │ │        │
│  │  │  └─────────────────────────────────┘ │ │        │
│  │  └───────────────────────────────────────┘ │        │
│  └────────────────────────────────────────────┘        │
└─────────────────────────────────────────────────────────┘
```

## Database Schema (Firestore)

```
Firestore Collections:
│
├── users/
│   └── {userId}
│       ├── id: string
│       ├── email: string
│       ├── displayName: string
│       ├── createdAt: timestamp
│       └── isAnonymous: boolean
│
├── mood_logs/
│   └── {logId}
│       ├── id: string
│       ├── userId: string
│       ├── mood: string (enum)
│       ├── notes: string
│       └── timestamp: timestamp
│
├── sleep_logs/
│   └── {logId}
│       ├── id: string
│       ├── userId: string
│       ├── date: timestamp
│       ├── hoursSlept: number
│       ├── sleepQuality: number
│       └── notes: string
│
├── study_logs/
│   └── {logId}
│       ├── id: string
│       ├── userId: string
│       ├── date: timestamp
│       ├── hoursStudied: number
│       ├── subject: string
│       ├── productivity: number
│       └── notes: string
│
├── meditation_sessions/
│   └── {sessionId}
│       ├── id: string
│       ├── userId: string
│       ├── startTime: timestamp
│       ├── endTime: timestamp
│       ├── durationMinutes: number
│       ├── meditationType: string
│       └── notes: string
│
├── journal_entries/
│   └── {entryId}
│       ├── id: string
│       ├── userId: string
│       ├── content: string
│       ├── createdAt: timestamp
│       ├── updatedAt: timestamp
│       ├── aiResponse: string
│       └── tags: array<string>
│
└── chat_rooms/
    └── {roomId}
        ├── id: string
        ├── name: string
        ├── description: string
        ├── createdAt: timestamp
        └── participantIds: array<string>
```

## Testing Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Testing Pyramid                       │
│                                                          │
│                      ┌────────┐                         │
│                      │   E2E  │                         │
│                      │  Tests │                         │
│                      └────────┘                         │
│                                                          │
│                  ┌──────────────┐                       │
│                  │   Widget     │                       │
│                  │    Tests     │                       │
│                  └──────────────┘                       │
│                                                          │
│              ┌──────────────────────┐                   │
│              │    Integration       │                   │
│              │      Tests           │                   │
│              └──────────────────────┘                   │
│                                                          │
│         ┌──────────────────────────────────┐            │
│         │        Unit Tests                │            │
│         │  (Models, Repositories, Logic)   │            │
│         └──────────────────────────────────┘            │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

## CI/CD Pipeline

```
┌──────────────┐
│   Git Push   │
│  to GitHub   │
└──────┬───────┘
       │
       ▼
┌─────────────────────────────────────┐
│     GitHub Actions Triggered        │
└──────┬──────────────────────────────┘
       │
       ├──▶ Checkout Code
       │
       ├──▶ Setup Flutter Environment
       │
       ├──▶ Install Dependencies
       │         (flutter pub get)
       │
       ├──▶ Verify Code Format
       │         (flutter format --check)
       │
       ├──▶ Analyze Code
       │         (flutter analyze)
       │
       ├──▶ Run Tests
       │         (flutter test --coverage)
       │
       ├──▶ Upload Coverage Report
       │         (Codecov)
       │
       ├──▶ Build Android APK
       │         (flutter build apk)
       │
       ├──▶ Build iOS App
       │         (flutter build ios)
       │
       └──▶ Build Windows App
                 (flutter build windows)
                        │
                        ▼
                ┌────────────────┐
                │  Artifacts     │
                │  Ready for     │
                │  Deployment    │
                └────────────────┘
```

## Security Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Security Layers                       │
│                                                          │
│  ┌────────────────────────────────────────────┐        │
│  │  Firebase Authentication                   │        │
│  │  ├─ Email/Password Auth                   │        │
│  │  ├─ Anonymous Auth (for chat)             │        │
│  │  └─ Token-based Session Management        │        │
│  └────────────────────────────────────────────┘        │
│                                                          │
│  ┌────────────────────────────────────────────┐        │
│  │  Firestore Security Rules                 │        │
│  │  ├─ User can only read/write own data    │        │
│  │  ├─ Validation of data structure          │        │
│  │  └─ Anonymous users limited access        │        │
│  └────────────────────────────────────────────┘        │
│                                                          │
│  ┌────────────────────────────────────────────┐        │
│  │  App-Level Security                        │        │
│  │  ├─ Input validation                       │        │
│  │  ├─ Error handling                         │        │
│  │  ├─ Secure data storage                    │        │
│  │  └─ HTTPS communication                    │        │
│  └────────────────────────────────────────────┘        │
└─────────────────────────────────────────────────────────┘
```

---

This architecture ensures:
- ✅ Separation of concerns
- ✅ Scalability
- ✅ Maintainability
- ✅ Testability
- ✅ Security
- ✅ Performance
