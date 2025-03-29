import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'game_cell.dart';

class GameBoard extends StatefulWidget {
  final List<int> winningLine;

  const GameBoard({super.key, this.winningLine = const []});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, _) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          int row = index ~/ 3;
          int col = index % 3;
          bool isWinningCell = widget.winningLine.contains(index); // Check if cell is in winning line
          return GameCell(
            index: index,
            onTap: () => gameProvider.makeMove(row, col),
            value: gameProvider.board[row][col],
            isWinningCell: isWinningCell, // Pass isWinningCell to GameCell
          );
        },
        itemCount: 9,
      ),
    );
  }
}