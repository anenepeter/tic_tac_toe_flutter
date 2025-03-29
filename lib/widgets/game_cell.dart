import 'package:flutter/material.dart';

class GameCell extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final String value;
  final bool isWinningCell;

  const GameCell({
    super.key,
    required this.index,
    required this.onTap,
    required this.value,
    this.isWinningCell = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: isWinningCell ? Colors.yellow[200] : Colors.transparent, // Highlight winning cell
          border: Border.all(),
        ),
        child: Center(
          child: Text(value), // Display cell content (X or O)
        ),
      ),
    );
  }
}