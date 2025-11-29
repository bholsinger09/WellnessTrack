# Wellness Tracker - PWA Deployment Guide

## 🌐 Your App is Now a Progressive Web App (PWA)!

Your app currently runs at: **http://localhost:8080** (development)

Users can install it on **any device** (iPhone, Android, Desktop) by:
1. Opening the link in their browser
2. Tapping "Add to Home Screen" (iOS) or "Install App" (Android/Desktop)

---

## 📱 Quick Start - Testing Locally

The app is currently running at `http://localhost:8080`

**To share on your local network:**
1. Find your local IP: `ifconfig | grep "inet " | grep -v 127.0.0.1`
2. Share `http://YOUR-IP:8080` with devices on same WiFi
3. They can open in browser and add to home screen

---

## 🚀 Deployment Options (Choose One)

### Option 1: Firebase Hosting (Recommended - Free & Fast)

**Setup:**
```bash
# Install Firebase CLI (one time)
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize hosting
cd /Users/benh/Documents/TrackWellness
firebase init hosting
# Choose: existing project "trackwellness-ecbcb"
# Public directory: build/web
# Single-page app: Yes
# Set up GitHub Actions: No

# Build and deploy
flutter build web --release
firebase deploy --only hosting
```

**Your URL:** `https://trackwellness-ecbcb.web.app`

---

### Option 2: GitHub Pages (Free)

**Setup:**
```bash
# Build for GitHub Pages
flutter build web --release --base-href "/WellnessTrack/"

# Create gh-pages branch
cd build/web
git init
git checkout -b gh-pages
git add .
git commit -m "Deploy to GitHub Pages"
git remote add origin https://github.com/bholsinger09/WellnessTrack.git
git push -f origin gh-pages
```

**Your URL:** `https://bholsinger09.github.io/WellnessTrack/`

**Enable in GitHub:**
1. Go to: https://github.com/bholsinger09/WellnessTrack/settings/pages
2. Source: Deploy from branch
3. Branch: gh-pages / (root)
4. Save

---

### Option 3: Vercel (Free - Easy Deploy)

**Setup:**
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
cd /Users/benh/Documents/TrackWellness
flutter build web --release
vercel build/web --prod
```

**Your URL:** `https://wellness-track-xxx.vercel.app`

---

### Option 4: Netlify (Free - Drag & Drop)

**Setup:**
1. Build: `flutter build web --release`
2. Go to: https://app.netlify.com/drop
3. Drag `build/web` folder to upload
4. Get instant URL: `https://wellness-track-xxx.netlify.app`

**Or via CLI:**
```bash
npm install -g netlify-cli
netlify deploy --prod --dir=build/web
```

---

## 🔧 Known Issue: Build Compilation

Due to macOS 26 environment issues, the release build currently fails with dart2js.

**Workaround Options:**

1. **Use Development Build for Now:**
   ```bash
   # Run dev server (currently working)
   flutter run -d web-server --web-port=8080
   # Deploy build/web folder manually
   ```

2. **Build on Different Machine:**
   - Use GitHub Actions to build automatically
   - Build on macOS 15 or Linux machine

3. **Wait for Flutter Update:**
   - Flutter team is aware of macOS 26 compatibility issues
   - Next Flutter update should fix dart2js crashes

---

## 📲 How Users Install Your PWA

### iPhone (iOS):
1. Open `https://your-url.com` in Safari
2. Tap **Share** button (bottom center)
3. Scroll and tap **Add to Home Screen**
4. Tap **Add**
5. App appears on home screen like native app!

### Android:
1. Open `https://your-url.com` in Chrome
2. Tap menu (⋮) → **Install app** or **Add to Home Screen**
3. Tap **Install**
4. App appears in app drawer!

### Desktop:
1. Open `https://your-url.com` in Chrome/Edge
2. Click install icon (⊕) in address bar
3. Click **Install**
4. App opens in standalone window!

---

## 🎯 Next Steps

1. **Choose a deployment option above**
2. **Share the URL** with friends to test
3. **Get feedback** on the PWA experience
4. **Fix iOS build issues** later for native TestFlight distribution

---

## 💡 PWA Benefits

✅ **Cross-platform:** One app works everywhere  
✅ **No app store:** Direct distribution via link  
✅ **Instant updates:** Users get latest version automatically  
✅ **Offline capable:** Can work without internet (after configuration)  
✅ **Easy sharing:** Just send a link!  

---

## 🔗 Resources

- Firebase Hosting: https://firebase.google.com/docs/hosting
- GitHub Pages: https://pages.github.com/
- Vercel: https://vercel.com/docs
- Netlify: https://docs.netlify.com/

---

**Current Status:**
- ✅ PWA configured and working
- ✅ Development server running
- ⏳ Production build pending (macOS 26 compatibility)
- 🎯 Ready for deployment once build issue resolved
