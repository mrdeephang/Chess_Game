import 'package:chess_game/models/piece.dart';
import 'package:chess_game/easyconst/color.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool isWhite; //Determines if the square is white or black
  final ChessPiece? piece; //Optional ChessPiece that might be on this square
  final bool isSelected; // Whether this square is currently selected
  final bool isValidMove; //Whether this square is a valid move target
  final bool isCastlingMove; //Special flag for castling moves
  final VoidCallback onTap; //Callback when the square is tapped simple do somthing function just runs code no input no output
  const Square({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.isValidMove,
    this.isCastlingMove = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color? squareColor =
        _getSquareColor(); //gets appropriate color for the square made for color change in castling

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squareColor,
        margin: EdgeInsets.all(isValidMove || isCastlingMove ? 2 : 0),
        child: _buildPieceContent(),
      ),
    );
  }

  //helper method to get appropriate color
  Color? _getSquareColor() {
    if (isSelected) {
      return Colors.green;
    }
    if (isCastlingMove) {
      return Colors.purple[300] ??
          Colors.purple; // Castling color with fallback
    }
    if (isValidMove) {
      return Colors.green[300] ??
          Colors.green; // Valid move color with fallback
    }
    return isWhite ? color1 : color2; // Default square color
  }

  //Returns null if no piece is on this square
  Widget? _buildPieceContent() {
    if (piece == null) return null;
    //Shows the piece image with color based on piece color
    return Stack(
      children: [
        Image.asset(
          piece!.imagePath,
          color: piece!.isWhite ? Colors.white : Colors.black,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error), // Fallback for missing images
        ),

        //Castling Indicator
      ],
    );
  }
}
