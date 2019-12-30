import 'dart:math';
import 'dart:ui' show Color;

import '../utils/colors.dart';
import '../utils/generators.dart';

class Answer {
  final String label;
  final Color color;

  const Answer({ this.label, this.color });
}

class GameManager {
  int min, max, grid;

  GameManager({ this.min, this.max, this.grid });

  List<List<int>> sessionProblems;
  List<int> currentProblem = [];
  Iterable<Answer> answers = [];

  int get correctAnswer => currentProblem[0] * currentProblem[1];

  void createProblems() {
    sessionProblems = generateCombinations(min, max);
  }

  bool nextProblem() {
    if (sessionProblems.length > 0) {
      currentProblem = sessionProblems.removeLast();
      return true;
    } else {
      return false;
    }
  }

  void updateAnswers() {
    Random random = Random();
    List<Color> colors = FlatColors.values.toList();
    
    answers = generateAnswers(currentProblem, pow(grid, 2))
      .map(
        (answer) => Answer(
          label: '$answer',
          color: colors.removeAt(random.nextInt(colors.length))
        )
      );
  }
}
