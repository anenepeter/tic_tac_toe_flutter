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
        transform: isWinningCell ? Matrix4.diagonal3Values(1.2, 1.2, 1.0) : Matrix4.identity(), // Scale winning cell
        decoration: BoxDecoration(
          color: isWinningCell ? Colors.yellow[200] : Colors.transparent, // Highlight winning cell
          border: Border.all(color: isWinningCell ? Colors.orange : Colors.black), // Change border color
        ),
        child: Center(
          child: Text(value), // Display cell content (X or O)
        ),
      ),
    );
  }
}