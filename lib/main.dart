import 'package:flutter/cupertino.dart';

import 'views/home.dart';
import 'views/game.dart';
import 'views/results.dart';

main() => runApp(LearningApp());

class LearningApp extends StatefulWidget {
  @override
  _LearningAppState createState() => _LearningAppState();
}

class _LearningAppState extends State<LearningApp> {
  List<List<int>> incorrect;
  Duration completionTime;

  void setResults(List<List<int>> incorrect, Duration completionTime) {
    this.incorrect = incorrect;
    this.completionTime = completionTime;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        color: CupertinoColors.white,
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => HomeView(),
          '/game': (BuildContext context) => GameView(setResults),
          '/results': (BuildContext context) =>
              ResultsView(incorrect, completionTime)
        });
  }
}
