import 'package:flutter/material.dart';

class GameCell extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final String value;

  const GameCell({
    super.key,
    required this.index,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: Text(value), // Display cell content (X or O)
        ),
      ),
    );
  }
}