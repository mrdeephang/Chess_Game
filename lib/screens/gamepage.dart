import 'package:chess_game/custom/deadpiece.dart';
import 'package:chess_game/custom/piece.dart';
import 'package:chess_game/custom/square.dart';
import 'package:chess_game/easyconst/color.dart';
import 'package:chess_game/helper/helper_methods.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  //2D chessboard
  late List<List<ChessPiece?>>
  board; //promise that it will be initialized later in future
  ChessPiece? selectedPiece; //no piece selected it is null
  int selectedRow = -1; //default value when no selected currently
  int selectedCol = -1;
  List<List<int>> validMoves = []; // valid Moves for each Pieces
  List<ChessPiece> whitePiecesTaken = []; //list of killed white pieces
  List<ChessPiece> blackPiecesTaken = []; //list of killed black pieces
  bool isWhiteTurn = true; //white always starts first
  List<int> whiteKingPositon = [7, 4]; //initial king postion
  List<int> blackKingPosition = [0, 4];
  bool checkStatus = false; //initially always false

  // Castling Initialization
  bool whiteKingMoved = false;
  bool blackKingMoved = false;
  bool whiteRookKingSideMoved = false;
  bool whiteRookQueenSideMoved = false;
  bool blackRookKingSideMoved = false;
  bool blackRookQueenSideMoved = false;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  //initialization of board
  void _initializeBoard() {
    List<List<ChessPiece?>> newBoard = List.generate(
      8,
      (index) => List.generate(8, (index) => null),
    );

    //place pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: false,
        imagePath: 'assets/images/pawn.png',
      );
      newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        imagePath: 'assets/images/pawn.png',
      );
    }
    //place rooks
    newBoard[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'assets/images/rook.png',
    );
    newBoard[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'assets/images/rook.png',
    );
    newBoard[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'assets/images/rook.png',
    );
    newBoard[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'assets/images/rook.png',
    );
    //place knights
    newBoard[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'assets/images/knight.png',
    );
    newBoard[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'assets/images/knight.png',
    );
    newBoard[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'assets/images/knight.png',
    );
    newBoard[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'assets/images/knight.png',
    );

    //place bishops
    newBoard[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'assets/images/bishop.png',
    );
    newBoard[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'assets/images/bishop.png',
    );
    newBoard[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'assets/images/bishop.png',
    );
    newBoard[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'assets/images/bishop.png',
    );

    //place queens
    newBoard[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: false,
      imagePath: 'assets/images/queen.png',
    );
    newBoard[7][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: true,
      imagePath: 'assets/images/queen.png',
    );

    //place kings
    newBoard[0][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: false,
      imagePath: 'assets/images/king.png',
    );
    newBoard[7][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: true,
      imagePath: 'assets/images/king.png',
    );
    board = newBoard;
  }

  //selection
  void pieceSelected(int row, int col) {
    // If no piece is selected yet
    if (selectedPiece == null) {
      // Check if there's a piece at this position and it's the correct turn
      if (board[row][col] != null && board[row][col]!.isWhite == isWhiteTurn) {
        setState(() {
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
          validMoves = calculateRealValidMoves(row, col, selectedPiece, true);
        });
      }
      return;
    }

    // If clicking on the same piece, deselect it
    if (row == selectedRow && col == selectedCol) {
      setState(() {
        selectedPiece = null;
        selectedRow = -1;
        selectedCol = -1;
        validMoves = [];
      });
      return;
    }

    // If clicking on another piece of the same color, select that instead
    if (board[row][col] != null && board[row][col]!.isWhite == isWhiteTurn) {
      setState(() {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
        validMoves = calculateRealValidMoves(row, col, selectedPiece, true);
      });
      return;
    }

    // Check if the move is valid
    bool isValidMove = false;
    for (var move in validMoves) {
      if (move[0] == row && move[1] == col) {
        isValidMove = true;
        break;
      }
    }

    if (isValidMove) {
      movePiece(row, col);
    }
  }

  //calculaterawvalidmoves
  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];

    int direction = piece!.isWhite ? -1 : 1;

    /* Move Swich cases */
    switch (piece.type) {
      case ChessPieceType.pawn:
        // pawn can move forward if the square is not occupied

        // Forward move
        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        // Two-square initial move
        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        // Left diagonal capture (only if not in column 0)
        if (col > 0 &&
            isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }

        // Right diagonal capture (only if not in column 7)
        if (col < 7 &&
            isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }
        break;
      case ChessPieceType.rook:
        final directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            final newRow = row + i * direction[0];
            final newCol = col + i * direction[1];

            if (!isInBoard(newRow, newCol)) {
              break; // Stop if out of bounds
            }

            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([
                  newRow,
                  newCol,
                ]); // Capture opponent's piece
              }
              break; // Blocked (by own or opponent's piece)
            }
            candidateMoves.add([newRow, newCol]); // Empty square
            i++;
          }
        }
        break;
      case ChessPieceType.knight:
        // All eight possible moves the knight can make
        var knightMoves = [
          [-2, -1], // up 2 left 1
          [-2, 1], // up 2 right 1
          [-1, -2], // up 1 left 2
          [-1, 2], // up 1 right 2
          [1, -2], // down 1 left 2
          [1, 2], // down 1 right 2
          [2, -1], // down 2 left 1
          [2, 1], // down 2 right 1
        ];

        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];

          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); // capture opponent's piece
            }
            continue; // blocked by own piece or after capture
          }

          candidateMoves.add([newRow, newCol]); // empty square
        }
        break;
      case ChessPieceType.bishop:
        final directions = [
          [-1, -1], // up-left
          [-1, 1], // up-right
          [1, -1], // down-left
          [1, 1], // down-right
        ];

        for (var dir in directions) {
          var i = 1;
          while (true) {
            final newRow = row + i * dir[0];
            final newCol = col + i * dir[1];

            if (!isInBoard(newRow, newCol)) {
              break; // Stop if out of bounds
            }

            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([
                  newRow,
                  newCol,
                ]); // Capture opponent's piece
              }
              break; // Blocked (by own or opponent's piece)
            }
            candidateMoves.add([newRow, newCol]); // Empty square
            i++;
          }
        }
        break;
      case ChessPieceType.queen:
        // All eight directions: orthogonal (like rook) + diagonal (like bishop)
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
          [-1, -1], // up-left
          [-1, 1], // up-right
          [1, -1], // down-left
          [1, 1], // down-right
        ];

        for (var dir in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * dir[0];
            var newCol = col + i * dir[1];

            if (!isInBoard(newRow, newCol)) {
              break; // Stop if out of bounds
            }

            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([
                  newRow,
                  newCol,
                ]); // Capture opponent's piece
              }
              break; // Blocked (by own or opponent's piece)
            }
            candidateMoves.add([newRow, newCol]); // Empty square
            i++;
          }
        }
        break;
      case ChessPieceType.king:
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];

        for (var direction in directions) {
          final newRow = row + direction[0];
          final newCol = col + direction[1];

          if (!isInBoard(newRow, newCol)) continue;

          if (board[newRow][newCol] == null ||
              board[newRow][newCol]!.isWhite != piece.isWhite) {
            candidateMoves.add([newRow, newCol]);
          }
        }

        // Castling logic
        if (!(piece.isWhite ? whiteKingMoved : blackKingMoved)) {
          // King-side castling (short castling)
          if (!(piece.isWhite
                  ? whiteRookKingSideMoved
                  : blackRookKingSideMoved) &&
              board[row][7]?.type == ChessPieceType.rook &&
              board[row][7]?.isWhite == piece.isWhite &&
              board[row][5] == null &&
              board[row][6] == null &&
              !isSquareUnderAttack(row, 4, !piece.isWhite) &&
              !isSquareUnderAttack(row, 5, !piece.isWhite) &&
              !isSquareUnderAttack(row, 6, !piece.isWhite)) {
            candidateMoves.add([row, 6]); // King moves to g-file
          }

          // Queen-side castling (long castling)
          if (!(piece.isWhite
                  ? whiteRookQueenSideMoved
                  : blackRookQueenSideMoved) &&
              board[row][0]?.type == ChessPieceType.rook &&
              board[row][0]?.isWhite == piece.isWhite &&
              board[row][1] == null &&
              board[row][2] == null &&
              board[row][3] == null &&
              !isSquareUnderAttack(row, 2, !piece.isWhite) &&
              !isSquareUnderAttack(row, 3, !piece.isWhite) &&
              !isSquareUnderAttack(row, 4, !piece.isWhite)) {
            candidateMoves.add([row, 2]); // King moves to c-file
          }
        }
        break;
    }
    return candidateMoves;
  }

  //check if squares are underattack
  bool isSquareUnderAttack(int row, int col, bool byWhite) {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        ChessPiece? piece = board[i][j];
        if (piece == null || piece.isWhite != byWhite) continue;

        List<List<int>> moves = calculateRawValidMoves(i, j, piece);
        if (moves.any((move) => move[0] == row && move[1] == col)) {
          return true;
        }
      }
    }
    return false;
  }

  //calculaterealvalidmoves
  List<List<int>> calculateRealValidMoves(
    int row,
    int col,
    ChessPiece? piece,
    bool checkSimulation,
  ) {
    if (piece == null) return [];

    List<List<int>> candidateMoves = calculateRawValidMoves(row, col, piece);
    List<List<int>> realValidMoves = [];

    if (!checkSimulation) {
      return candidateMoves;
    }

    for (var move in candidateMoves) {
      int endRow = move[0];
      int endCol = move[1];

      // Simulate the move
      ChessPiece? capturedPiece = board[endRow][endCol];
      board[endRow][endCol] = piece;
      board[row][col] = null;

      // Update king position if moving king
      List<int>? originalKingPosition;
      if (piece.type == ChessPieceType.king) {
        originalKingPosition = piece.isWhite
            ? whiteKingPositon
            : blackKingPosition;
        if (piece.isWhite) {
          whiteKingPositon = [endRow, endCol];
        } else {
          blackKingPosition = [endRow, endCol];
        }
      }

      // Check if king is in check after move
      bool isSafe = !isKingInCheck(piece.isWhite);

      // Restore board state
      board[row][col] = piece;
      board[endRow][endCol] = capturedPiece;

      // Restore king position if needed
      if (piece.type == ChessPieceType.king) {
        if (piece.isWhite) {
          whiteKingPositon = originalKingPosition!;
        } else {
          blackKingPosition = originalKingPosition!;
        }
      }

      if (isSafe) {
        realValidMoves.add(move);
      }
    }

    return realValidMoves;
  }

  //Move Piece
  void movePiece(int newRow, int newCol) {
    bool isCastling =
        selectedPiece!.type == ChessPieceType.king &&
        (selectedCol - newCol).abs() == 2;
    // Handle castling - move the rook
    if (isCastling) {
      if (newCol == 6) {
        // King-side castling
        board[newRow][5] = board[newRow][7]; // Move rook to f-file
        board[newRow][7] = null;
      } else if (newCol == 2) {
        // Queen-side castling
        board[newRow][3] = board[newRow][0]; // Move rook to d-file
        board[newRow][0] = null;
      }
    }

    // Update king/rook moved status
    if (selectedPiece!.type == ChessPieceType.king) {
      if (selectedPiece!.isWhite) {
        whiteKingMoved = true;
      } else {
        blackKingMoved = true;
      }
    } else if (selectedPiece!.type == ChessPieceType.rook) {
      if (selectedRow == 7 && selectedCol == 7) whiteRookKingSideMoved = true;
      if (selectedRow == 7 && selectedCol == 0) whiteRookQueenSideMoved = true;
      if (selectedRow == 0 && selectedCol == 7) blackRookKingSideMoved = true;
      if (selectedRow == 0 && selectedCol == 0) blackRookQueenSideMoved = true;
    }

    //if new spot it can move has an enemy piece
    if (board[newRow][newCol] != null) {
      //add the caputrud place to apppr list
      var capturedPiece = board[newRow][newCol];
      if (capturedPiece!.isWhite) {
        whitePiecesTaken.add(capturedPiece);
      } else {
        blackPiecesTaken.add(capturedPiece);
      }
    }
    //check if piece being moved to a king
    if (selectedPiece!.type == ChessPieceType.king) {
      //update the kin position appropriately
      if (selectedPiece!.isWhite) {
        whiteKingPositon = [newRow, newCol];
      } else {
        blackKingPosition = [newRow, newCol];
      }
    }
    //move and clear old spot
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    //if king is in check
    if (isKingInCheck(!isWhiteTurn)) {
      checkStatus = true;
    } else {
      checkStatus = false;
    }
    //clear selection
    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });
    //checkmate check shows alert if it is checkmate
    if (isCheckMate(!isWhiteTurn)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            'CHECK MATE!!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          actions: [
            TextButton(
              onPressed: resetgame,
              style: TextButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: Text(
                'Play Again!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
    }
    //change turn
    isWhiteTurn = !isWhiteTurn;
  }

  //King in check? oK
  bool isKingInCheck(bool isWhiteKing) {
    List<int> kingPosition = isWhiteKing ? whiteKingPositon : blackKingPosition;

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        ChessPiece? piece = board[i][j];
        if (piece == null || piece.isWhite == isWhiteKing) continue;

        List<List<int>> moves = calculateRawValidMoves(i, j, piece);
        for (var move in moves) {
          if (move[0] == kingPosition[0] && move[1] == kingPosition[1]) {
            return true;
          }
        }
      }
    }
    return false;
  }

  //simulation of future move to see if its safe
  bool simulatedMoveisSafe(
    ChessPiece piece,
    int startRow,
    int startCol,
    int endRow,
    int endCol,
  ) {
    //save the current state of board
    ChessPiece? originalDestinationPiece = board[endRow][endCol];
    //if the piece is the king, save its current position & update newone
    List<int>? originalKingPosition;
    if (piece.type == ChessPieceType.king) {
      originalKingPosition = piece.isWhite
          ? whiteKingPositon
          : blackKingPosition;

      //update the King Position
      if (piece.isWhite) {
        whiteKingPositon = [endRow, endCol];
      } else {
        blackKingPosition = [endRow, endCol];
      }
    }
    //simulate the move
    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;

    //check if our king is under attack
    bool KingInCheck = !isKingInCheck(piece.isWhite);

    //restore board to original
    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestinationPiece;

    //if the piece was king, original position is restored
    if (piece.type == ChessPieceType.king) {
      if (piece.isWhite) {
        whiteKingPositon = originalKingPosition!;
      } else {
        blackKingPosition = originalKingPosition!;
      }
    }
    // if check is true,king ain't safe
    return !KingInCheck;
  }

  //Checkmate
  bool isCheckMate(bool isWhiteKing) {
    if (!isKingInCheck(isWhiteKing)) {
      return false;
    }
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == null || board[i][j]!.isWhite != isWhiteKing) {
          continue;
        }
        List<List<int>> placeValidMoves = calculateRealValidMoves(
          i,
          j,
          board[i][j],
          true,
        );
        if (placeValidMoves.isNotEmpty) {
          return false;
        }
      }
    }
    //when no above conditions are true, it's checkmate
    return true;
  }

  //Reset Game using try catch to handle exceptions
  void resetgame() {
    try {
      // Close any open dialogs if they exist
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      /*Reset all game state*/
      _initializeBoard(); // Recreate the board
      whitePiecesTaken.clear();
      blackPiecesTaken.clear();
      whiteKingPositon = [7, 4];
      blackKingPosition = [0, 4];
      isWhiteTurn = true;
      checkStatus = false;
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
      // Reset castling flags
      whiteKingMoved = false;
      blackKingMoved = false;
      whiteRookKingSideMoved = false;
      whiteRookQueenSideMoved = false;
      blackRookKingSideMoved = false;
      blackRookQueenSideMoved = false;
      // Trigger UI update
      setState(() {});
    } catch (e) {
      debugPrint('Error during reset: $e');
      // Fallback reset if something went wrong
      setState(() {
        _initializeBoard();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          checkStatus ? 'CHECK!' : "",
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            //whitepieces killed
            Expanded(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: whitePiecesTaken.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) => DeadPiece(
                  imagePath: whitePiecesTaken[index].imagePath,
                  isWhite:
                      true, // Make sure this is set to true for white pieces
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 8 * 8,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 8;
                  int col = index % 8;
                  bool isSelected = selectedRow == row && selectedCol == col;
                  bool isValidMove = false;
                  for (var position in validMoves) {
                    if (position[0] == row && position[1] == col) {
                      isValidMove = true;
                    }
                  }
                  return Square(
                    isWhite: isWhite(index),
                    piece: board[row][col],
                    isSelected: isSelected,
                    isValidMove: isValidMove,
                    onTap: () => pieceSelected(row, col),
                  );
                },
              ),
            ),
            //Check Status

            //blackpieces killed
            Expanded(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: blackPiecesTaken.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) => DeadPiece(
                  imagePath: blackPiecesTaken[index].imagePath,
                  isWhite: false,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => resetgame(),
        child: Icon(Icons.restart_alt, color: Colors.white),
      ),
    );
  }
}
