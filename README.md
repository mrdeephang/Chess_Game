# Chess

**Chess game made using flutter within a short time constraint**

## Features

- Two Players can play
- Castling is possible
- Check Alert
- Checkmate Dialog
- Reset game on clicking floatingactionbutton & Clicked on Play Again on Checkmate

## Requirements

- Flutter SDK (v3.0+)
- Android Studio or VS Code
- Emulator or physical device

## Packages Used(Minimalist)

- flutter_launcher_icons(For App Icon)
- lottie (For Splash Animation Loading)
- No State Management Used(UI is simply updated using SetState((){}))

## Folder Structure

├── lib/
│ ├── custom/
│ │ ├── piece.dart
│ │ ├── square.dart
│ ├── easyconst/
│ │ ├── color.dart
│ ├── helper/
│ │ ├── helper_methods.dart
│ ├── screens/
│ │ ├── gamepage.dart
│ │ ├── splash.dart
│ ├── main.dart

## How to Run

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`

## Future Enhancement

- Add play with AI
- Adding Undo Option
- Promoting of Pawn when it reaches Opponent End
- Locally save game progress even when game is closed using (sharedpreferences, sqlite or hive)

## Author

Copyright © 2025 Deephang Thegim. All rights reserved.
