# Firebase Setup Guide for Wellness Tracker

## Prerequisites

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Name it "wellness-tracker"
4. Enable Google Analytics (optional)
5. Create project

## Step 2: Configure Firebase for Flutter

Run the FlutterFire configuration command:

```bash
flutterfire configure
```

This will:
- Create a new Firebase project or select existing one
- Register your Flutter app with Firebase
- Generate `firebase_options.dart` file
- Configure iOS, Android, and Windows platforms

## Step 3: Enable Firebase Services

### Authentication

1. In Firebase Console, go to **Authentication**
2. Click "Get Started"
3. Enable the following sign-in methods:
   - **Email/Password**: Enable
   - **Anonymous**: Enable (for peer support chat)

### Firestore Database

1. Go to **Firestore Database**
2. Click "Create database"
3. Start in **test mode** (we'll set up rules later)
4. Choose a location close to your users
5. Create the following indexes:

```
Collection: mood_logs
Fields: userId (Ascending), timestamp (Descending)

Collection: sleep_logs
Fields: userId (Ascending), date (Descending)

Collection: study_logs
Fields: userId (Ascending), date (Descending)

Collection: meditation_sessions
Fields: userId (Ascending), startTime (Descending)

Collection: journal_entries
Fields: userId (Ascending), createdAt (Descending)
```

### Firestore Security Rules

Update your Firestore rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Mood logs
    match /mood_logs/{logId} {
      allow read, write: if request.auth != null && 
                           request.resource.data.userId == request.auth.uid;
    }
    
    // Sleep logs
    match /sleep_logs/{logId} {
      allow read, write: if request.auth != null && 
                           request.resource.data.userId == request.auth.uid;
    }
    
    // Study logs
    match /study_logs/{logId} {
      allow read, write: if request.auth != null && 
                           request.resource.data.userId == request.auth.uid;
    }
    
    // Meditation sessions
    match /meditation_sessions/{sessionId} {
      allow read, write: if request.auth != null && 
                           request.resource.data.userId == request.auth.uid;
    }
    
    // Journal entries
    match /journal_entries/{entryId} {
      allow read, write: if request.auth != null && 
                           request.resource.data.userId == request.auth.uid;
    }
    
    // Chat rooms (anonymous read for all authenticated users)
    match /chat_rooms/{roomId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
                              request.auth.uid in resource.data.participantIds;
    }
  }
}
```

### Realtime Database (for Chat)

1. Go to **Realtime Database**
2. Click "Create Database"
3. Start in **test mode**
4. Update rules:

```json
{
  "rules": {
    "chat_messages": {
      "$roomId": {
        ".read": "auth != null",
        ".write": "auth != null"
      }
    }
  }
}
```

### Cloud Storage (Optional - for profile pictures)

1. Go to **Storage**
2. Click "Get Started"
3. Start in **test mode**
4. Update rules:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Step 4: Cloud Functions (for AI Journaling)

1. Initialize Cloud Functions:
   ```bash
   firebase init functions
   ```

2. Select TypeScript

3. Install dependencies:
   ```bash
   cd functions
   npm install @google-cloud/aiplatform
   ```

4. Create AI journal function in `functions/src/index.ts`:

```typescript
import * as functions from 'firebase-functions';
import { VertexAI } from '@google-cloud/aiplatform';

export const generateJournalInsights = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'User must be authenticated'
      );
    }

    const journalContent = data.content;
    
    // Initialize Vertex AI
    const vertex = new VertexAI({
      project: process.env.GCLOUD_PROJECT,
      location: 'us-central1',
    });

    // Generate insights using Gemini
    const prompt = `You are a compassionate wellness coach. A university student has written the following journal entry. Provide supportive, brief insights (2-3 sentences): "${journalContent}"`;

    try {
      // Call Gemini API
      const response = await vertex.preview.generateContent({
        model: 'gemini-pro',
        contents: [{ role: 'user', parts: [{ text: prompt }] }],
      });

      return { insights: response.candidates[0].content.parts[0].text };
    } catch (error) {
      console.error('Error generating insights:', error);
      throw new functions.https.HttpsError(
        'internal',
        'Failed to generate insights'
      );
    }
  }
);
```

5. Deploy functions:
   ```bash
   firebase deploy --only functions
   ```

## Step 5: Platform-Specific Configuration

### iOS

1. Open `ios/Runner.xcworkspace` in Xcode
2. Add `GoogleService-Info.plist` to the project (already done by flutterfire)
3. Update `ios/Runner/Info.plist` with required permissions:

```xml
<key>NSCameraUsageDescription</key>
<string>We need access to your camera for profile pictures</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library</string>
```

### Android

1. `google-services.json` is automatically added by flutterfire
2. Verify `android/app/build.gradle` has:

```gradle
minSdkVersion 21
```

### Windows

Windows configuration is handled automatically by flutterfire.

## Step 6: Environment Variables

Create a `.env` file in the root directory:

```env
GEMINI_API_KEY=your_gemini_api_key_here
```

## Step 7: Test Firebase Connection

Run the app and test:

```bash
flutter run
```

Try signing up with a new account to verify Firebase connection.

## Troubleshooting

### iOS Build Issues
- Clean build: `flutter clean && cd ios && pod install && cd ..`
- Update CocoaPods: `sudo gem install cocoapods`

### Android Build Issues
- Update Google Services plugin in `android/build.gradle`
- Sync Gradle files

### Firebase Connection Issues
- Verify `firebase_options.dart` exists
- Check internet connection
- Verify Firebase project configuration

## Production Checklist

- [ ] Update Firestore rules from test mode to production
- [ ] Update Realtime Database rules
- [ ] Enable App Check for security
- [ ] Set up Firebase Monitoring
- [ ] Configure Firebase Crashlytics
- [ ] Set up backup schedules
- [ ] Review and optimize security rules
- [ ] Enable Firebase Performance Monitoring
