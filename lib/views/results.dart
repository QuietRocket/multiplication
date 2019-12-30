import 'package:flutter/widgets.dart';
import 'dart:math';

class ResultsView extends StatelessWidget {
  final List<List<int>> incorrect;
  final Duration completionTime;

  ResultsView(this.incorrect, this.completionTime);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffe5e5ea),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${completionTime.toString().split('.')[0]}',
                  style: TextStyle(color: Color(0xff000000), fontSize: 35)),
              Text('Mistakes:',
                  style: TextStyle(color: Color(0xff000000), fontSize: 35)),
              Corrections(incorrect),
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: GestureDetector(
                      onTap: () =>
                          Navigator.popUntil(context, ModalRoute.withName('/')),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Color(0xffed0b65),
                        child: Text('Try Again',
                            style: TextStyle(
                                fontSize: 35, color: Color(0xffffffff))),
                      )))
            ]));
  }
}

class Corrections extends StatelessWidget {
  final List<List<int>> problems;

  Corrections(this.problems);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double gridWidth = min(screenSize.height, screenSize.width) * 0.85;

    List<Widget> correctGrid = problems
        .expand((problem) => [
              '${problem[0]} x ${problem[1]}',
              '=',
              '${problem[0] * problem[1]}'
            ])
        .map((problem) => Center(
            child: Text(problem,
                style: TextStyle(color: Color(0xff000000), fontSize: 30))))
        .toList();

    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: Container(
            height: gridWidth,
            width: gridWidth,
            color: Color(0xffe0e0e5),
            child: GridView.count(
                childAspectRatio: 2,
                crossAxisCount: 3,
                children: correctGrid)));
  }
}
