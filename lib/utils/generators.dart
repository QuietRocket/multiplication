import 'dart:math';

List<List<int>> generateCombinations(int min, int max) {
  List<List<int>> combinations = [];

  for (int i = min; i <= max; i++) {
    for (int j = i; j <= max; j++) {
      combinations.add([i, j]);
    }
  }

  combinations.forEach((combo) => combo.shuffle());
  combinations.shuffle();

  return combinations;
}

List<int> generateAnswers(List<int> problem, int count) {
  Random random = Random();

  int minQ = problem.reduce(min);
  int maxQ = problem.reduce(max);

  int rightAnswer = minQ * maxQ;

  List<int> answers = [rightAnswer];

  while (answers.length < count) {
    int possibleWrong = maxQ * (minQ + random.nextInt(5) - 2) + random.nextInt(11) - 5;

    if (
      possibleWrong % 2 == rightAnswer % 2 &&
      possibleWrong > maxQ + minQ &&
      answers.indexOf(possibleWrong) == -1
    ) {
      answers.add(possibleWrong);
    }
  }

  answers.shuffle();

  return answers;
}
