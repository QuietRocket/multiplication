import 'package:flutter/widgets.dart';
import 'dart:math';

import '../widgets/buttons.dart';
import '../utils/gamemanager.dart';
import '../utils/gametimer.dart';

class GameView extends StatefulWidget {

  final void Function(List<List<int>> incorrect, Duration completionTime) setResults;

  GameView(this.setResults);

  @override
    _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  static double gridCoef = 0.85;

  GameManager manager;
  GameTimer timer;

  List<List<int>> incorrect;
  Duration currentTime;

  List<Button> buttons;

  @override
    void initState() {
      super.initState();
      manager = GameManager(min: 2, max: 12, grid: 2)
        ..createProblems();

      nextProblem();

      timer = GameTimer(
          duration: (int time) => Duration(seconds: time),
          onTick: (Duration time) {
            setState(() {
              currentTime = time;            
            });
          }
        )
        ..start();

        incorrect = [];
        currentTime = Duration.zero;
    }

  void nextProblem() {
    if (manager.nextProblem()) {
      manager.updateAnswers();
      buttons = manager.answers
        .map(
          (answer) =>
            Button(
              label: answer.label,
              color: answer.color,
              onTap: buttonPressed
            )
        )
        .toList();
    } else {
      showResults();
    }
  }

  void buttonPressed(String label) {
    if (label != '${manager.correctAnswer}') {
      incorrect.add(manager.currentProblem);
    }
    setState(() {
      nextProblem();
    });
  }

  void showResults() {
    widget.setResults(incorrect, currentTime);
    Navigator.pushNamed(context, '/results');
    timer.stop();
  }

  @override
    Widget build(BuildContext context) {
      Size screenSize = MediaQuery.of(context).size;

      double gridWidth = min(screenSize.height, screenSize.width) * gridCoef;

      return Container(
        color: Color(0xFFE5E5EA),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('${manager.sessionProblems.length} left.',
                  style: TextStyle(
                    color: Color(0xff4a4a4a)
                  )
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    onTap: showResults,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: Color(0xffed0b65),
                      child: Text('Show Results'),
                    )
                  ),
                )
              ]
            ),
            Text(currentTime.toString().split('.')[0],
              style: TextStyle(
                color: Color(0xff4a4a4a),
                fontSize: 50
              )
            ),
            Text('Multiply the following...',
              style: TextStyle(
                color: Color(0xff4a4a4a),
                fontSize: 25
              )
            ),
            Text('${manager.currentProblem[0]} x ${manager.currentProblem[1]} = ?',
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 50,
                fontWeight: FontWeight.w600
              )
            ),
            ButtonGrid(
              sideLength: gridWidth,
              buttons: buttons
            )
          ]
        )
      );
    }
}
