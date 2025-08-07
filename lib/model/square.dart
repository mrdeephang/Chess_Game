import 'package:chess_game/model/piece.dart';
import 'package:chess_game/easyconst/color.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final bool isValidMove;
  final bool isCastlingMove;
  final VoidCallback onTap;

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
    final Color? squareColor = _getSquareColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squareColor,
        margin: EdgeInsets.all(isValidMove || isCastlingMove ? 2 : 0),
        child: _buildPieceContent(),
      ),
    );
  }

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

  Widget? _buildPieceContent() {
    if (piece == null) return null;

    return Stack(
      children: [
        Image.asset(
          piece!.imagePath,
          color: piece!.isWhite ? Colors.white : Colors.black,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error), // Fallback for missing images
        ),
        if (isCastlingMove)
          Positioned(
            bottom: 2,
            right: 2,
            child: Icon(
              Icons.castle,
              size: 16,
              color: piece!.isWhite ? Colors.black : Colors.white,
            ),
          ),
      ],
    );
  }
}