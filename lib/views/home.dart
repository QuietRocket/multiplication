import 'package:flutter/cupertino.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/game'),
      child: Container(
        color: CupertinoColors.activeBlue,
        child: Center(
          child: Text(
            'Multiplication!\nTap to play.',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
