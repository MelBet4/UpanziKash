# UpanziKash – Empowering Youth Farmers in Kenya

**UpanziKash** is a mobile-first, offline-capable application designed to support young farmers in Kenya by enabling smart record-keeping, financial tracking, and access to farming tips — all in both Swahili and English.

Built using Flutter, UpanziKash is optimized for rural conditions, low-end devices, and users with limited internet access.

Live demo: https://upanzi-kash.vercel.app/

---

## Features

### Core Functionalities
- Record Income & Expenses  
  Track transactions by category (seeds, labor, sales, etc.)

- Manual M-Pesa Logging  
  Easily tag mobile money transactions as income or expenses

- Farming & Finance Tips  
  Weekly offline-accessible tips in English & Swahili

- Bilingual Interface  
  Seamlessly switch between Swahili and English

- Passcode Lock  
  Optional local security feature to protect user data

- Offline-First Design  
  App works offline and syncs when internet is available

---

## Tech Stack

- Frontend & UI: Flutter (Dart)
- State Management: setState (Flutter built-in)
- Local Storage: Hive
- Cloud Sync (Planned): Firebase / REST API

---

## Target Users

- Young, rural farmers in Kenya (18–35)
- First-time smartphone users
- Swahili/English speakers
- Areas with limited or no internet access

---

## Installation

### Prerequisites
- Flutter SDK (3.0+ recommended)
- Dart
- Android Studio or VS Code

### Steps
```bash
git clone https://github.com/YOUR_USERNAME/upanzikash.git
cd upanzikash
flutter pub get
flutter run
```

---

## Web Deployment (Vercel)

To deploy the Flutter web app to Vercel:

1. Build the web app:
   ```bash
   flutter build web
   ```
2. Ensure `vercel.json` is present in the project root with the following content:
   ```json
   {
     "builds": [
       { "src": "build/web/**", "use": "@vercel/static" }
     ],
     "rewrites": [
       { "source": "/(.*)", "destination": "/" }
     ]
   }
   ```
3. Connect your repo to Vercel and set:
   - Root Directory: FarmRecord/upanzi_kash (if your repo contains multiple projects)
   - Build Command: flutter build web
   - Output Directory: build/web
4. Deploy!

---

## Environment & Security

- Firebase Config:  
  The file `lib/firebaseoptions.dart` contains your Firebase credentials.  
  - This file is gitignored for security.
  - Use the provided `lib/firebaseoptions.example.dart` as a template and add your own credentials locally.

---

## Contributing

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a pull request

---

## Acknowledgements

- Developed by Melanie Chebet, 2025
- Built with the help of AI tools such as Cursor and OpenAI's GPT models
