import 'package:chess_game/custom/piece.dart';
import 'package:chess_game/easyconst/color.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final bool isValidMove;
  final VoidCallback onTap; // Changed to non-nullable

  const Square({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.isValidMove,
    required this.onTap, // Now required
  });

  @override
  Widget build(BuildContext context) {
    // Determine square color safely
    final Color? squareColor = _getSquareColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squareColor,
        margin: EdgeInsets.all(
          isValidMove ? 8 : 0,
        ), // Small margin between squares
        child: _buildPieceContent(),
      ),
    );
  }

  Color? _getSquareColor() {
    if (isSelected) return Colors.green;
    if (isValidMove) return Colors.green[300] ?? Colors.green; // Fallback
    return isWhite ? color1 : color2;
  }

  Widget? _buildPieceContent() {
    if (piece == null) return null;

    try {
      return Image.asset(
        piece!.imagePath,
        color: piece!.isWhite ? Colors.white : Colors.black,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error), // Fallback for missing images
      );
    } catch (e) {
      debugPrint('Error loading piece image: $e');
      return const Icon(Icons.error_outline);
    }
  }
}
