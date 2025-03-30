# Tic Tac Toe Flutter

A complete Tic Tac Toe Android application using Flutter.

## Features

*   Single-player mode against an AI opponent with adjustable difficulty levels (Easy, Medium, Hard).
*   Local two-player mode.
*   Persistent win/loss tracking using local storage.
*   Clean, modern, and responsive user interface suitable for various Android screen sizes.
*   Subtle animations for player turns and winning sequences.
*   Adjustable AI difficulty levels.
*   Reset game functionality.
*   Prevents placing marks in already occupied cells.
*   Prevents user from playing before the AI in single-player mode.

## Project Structure

The project follows a feature-based folder structure:

*   `lib/`: Main application directory
    *   `models/`: Data models
    *   `providers/`: State management using Provider
    *   `screens/`: UI screens/views
    *   `widgets/`: Reusable UI components
    *   `services/`: Game logic and AI services
    *   `themes/`: App themes and styles
    *   `utils/`: Utility functions and constants

## How to Run

1.  Ensure you have Flutter installed and configured on your machine.
2.  Clone this repository.
3.  Navigate to the project directory: `cd tic_tac_toe_flutter`
4.  Run `flutter pub get` to install dependencies.
5.  Run `flutter run` to launch the application on your connected Android device or emulator.

## Dependencies

*   `flutter`: Flutter SDK
*   `provider`: State management
*   `shared_preferences`: Local storage
*   `audioplayers`: Sound effects (I will likely remove this later)

## AI Implementation

The AI opponent is implemented with three difficulty levels:

*   **Easy:** Random move selection.
*   **Medium:** Basic Minimax algorithm to block player wins or choose winning moves.
*   **Hard:** Minimax algorithm with alpha-beta pruning for optimal gameplay.


P.S. This project was created with the assistance of AI using vibe coding.
