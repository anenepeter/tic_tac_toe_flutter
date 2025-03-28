import 'package:flutter/material.dart';

class DifficultySelector extends StatefulWidget {
  const DifficultySelector({super.key});

  @override
  State<DifficultySelector> createState() => _DifficultySelectorState();
}

class _DifficultySelectorState extends State<DifficultySelector> {
  String _selectedDifficulty = 'Easy'; // Default difficulty

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedDifficulty,
      onChanged: (String? newValue) {
        setState(() {
          _selectedDifficulty = newValue!;
          print('Selected difficulty: $_selectedDifficulty'); // Placeholder for difficulty selection logic
        });
      },
      items: <String>['Easy', 'Medium', 'Hard']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}