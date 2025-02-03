import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String data;
  final TextAlign? textAlign;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? backgroundColor;
  const TextWidget(
      {super.key,
      required this.data,
      this.textAlign = TextAlign.start,
      required this.color,
      required this.fontSize,
      required this.fontWeight,
      this.backgroundColor = Colors.transparent});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.data,
      textAlign: widget.textAlign,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
        backgroundColor: widget.backgroundColor,
      ),
    );
  }
}
