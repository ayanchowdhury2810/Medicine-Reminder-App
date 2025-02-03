import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final Color backgroundColor;
  final String btnText;
  final Color txtColor;
  final double fontSize;
  final VoidCallback onPressed;
  const ButtonWidget(
      {super.key,
      required this.backgroundColor,
      required this.btnText,
      required this.txtColor,
      required this.fontSize,
      required this.onPressed});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(widget.backgroundColor),
      ),
      child: Text(
        widget.btnText,
        style: TextStyle(color: widget.txtColor, fontSize: widget.fontSize),
      ),
    );
  }
}
