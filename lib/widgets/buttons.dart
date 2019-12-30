import 'package:flutter/widgets.dart';
import 'dart:math';

class ButtonGrid extends StatelessWidget {
  final double sideLength;
  final List<Button> buttons;

  const ButtonGrid({ this.sideLength, this.buttons });

  @override
    Widget build(BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: Container(
          width: sideLength,
          height: sideLength,
          child: GridView.count(
            crossAxisCount: sqrt(buttons.length).round(),
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: buttons
          )
        )
      );
    }
}

class Button extends StatefulWidget {
  final String label;
  final Color color;
  final void Function(String label) onTap;

  const Button({ this.label, this.color, this.onTap });

  @override
    _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isPressed = false;

  void setPressed(bool pressed) {
    setState(() {
      isPressed = pressed;
    });
  }

  @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTapDown: (TapDownDetails details) => setPressed(true),
        onTapUp: (TapUpDetails details) => setPressed(false),
        onTapCancel: () => setPressed(false),
        onTap: () => widget.onTap(widget.label),
        child: Container(
          color: widget.color.withAlpha(isPressed ? 128 : 255),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w700
              )
            )
          )
        )
      );
    }
}
