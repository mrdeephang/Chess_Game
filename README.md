# Chess

**Chess game made using flutter within a short time constraint**

## Screenshots

<img src="https://github.com/user-attachments/assets/b843d9b4-8947-4db0-9e1e-df842e04592f" alt="Image 1" width="300"/>
<img src="https://github.com/user-attachments/assets/66223d3f-d4d0-4a1f-bbea-944dce4e37dc" alt="Image 2" width="300"/>


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

- lottie (For Splash Animation Loading)

## Folder Structure

├── lib/
│ ├── models/
| | ├── deadpiece.dart #Manages captured chess pieces that are no longer in play.
│ │ ├── piece.dart #Defines the chess piece model with properties like type, color, and movement rules.
│ │ ├── square.dart #Represents an individual chessboard square that can contain a piece and handle interactions.
│ ├── easyconst/
│ │ ├── colors.dart #constant color values used for the chessboard and UI elements
│ ├── helper/
│ │ ├── helper_methods.dart #utility functions for game logic
│ ├── screens/
│ │ ├── gamepage.dart #maingame page
│ │ ├── splash.dart #initial welcome splash screen
│ ├── main.dart #main entry

## How to Run

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`

## Future Enhancement

- Add play with AI
- Adding Undo Option(single step)
- Promoting of Pawn when it reaches Opponent End
- Locally save game progress even when game is closed using (sharedpreferences or sqlite or hive)

## Author

Copyright © 2025 Deephang Thegim. All rights reserved.
