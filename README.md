# ♟️ Chess

> **A minimalist chess game built with Flutter** — featuring classic gameplay with smooth animations and intuitive controls.

---

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/0b86be2a-42b9-4355-a766-562fe216cb8b" alt="Chess Game Board" width="300"/>
  <img src="https://github.com/user-attachments/assets/09cd8947-bb32-4dfb-96ea-ca658178448c" alt="Chess Gameplay" width="300"/>
</p>

---

## ✨ Features

- ♟️ **Two-player mode** — Play with a friend locally
- 🏰 **Castling support** — Execute this special move when conditions are met
- ⚠️ **Check alerts** — Get notified when your king is in danger
- 🎯 **Checkmate detection** — Automatic game-end recognition with dialog
- 🔄 **Quick reset** — Restart via floating action button or "Play Again" option

---

## 🛠️ Requirements

- Flutter SDK (v3.0+)
- Android Studio or VS Code
- Emulator or physical device

---

## 📦 Dependencies

**Minimalist approach** — only one package used:

- **lottie** — Smooth splash screen animation

---

## 📁 Folder Structure

```
lib/
├── models/
│   ├── deadpiece.dart      # Manages captured pieces
│   ├── piece.dart           # Chess piece model with movement rules
│   └── square.dart          # Individual chessboard square
├── easyconst/
│   └── colors.dart          # UI color constants
├── helper/
│   └── helper_methods.dart  # Game logic utilities
├── screens/
│   ├── gamepage.dart        # Main game interface
│   └── splash.dart          # Welcome splash screen
└── main.dart                # App entry point
```

---

## 🚀 How to Run

```bash
# 1. Clone the repository
git clone https://github.com/mrdeephang/chess.git
cd chess

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

---

## 🔮 Future Enhancements

- 🤖 **AI opponent** — Single-player mode with difficulty levels
- ↩️ **Undo move** — Take back your last move
- 👑 **Pawn promotion** — Upgrade pawns reaching the opposite end
- 💾 **Save progress** — Persist game state using SharedPreferences/SQLite/Hive

---

## 👨‍💻 Author

**Deephang Thegim**  
GitHub: [@mrdeephang](https://github.com/mrdeephang)

---

## 📄 License

Copyright © 2025 Deephang Thegim. All rights reserved.
