// Determines if the square at the given index should be white
bool isWhite(int index) {
  int x = index ~/ 8;
  int y = index % 8;
  bool isWhite = (x + y) % 2 == 0;
  return isWhite;
}

//make sure the pieces are inside the board
bool isInBoard(int row, int col) {
  return row >= 0 && row < 8 && col >= 0 && col < 8;
}
