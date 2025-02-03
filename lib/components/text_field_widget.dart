import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final FocusNode focusNode;
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final Color textColor;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  const TextFieldWidget(
      {super.key,
      required this.focusNode,
      required this.hintText,
      required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.textColor = Colors.black,
      required this.onChanged,
      this.validator});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

  @override
  void dispose() {
    widget.textEditingController.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      onChanged: widget.onChanged,
      controller: widget.textEditingController,
      style: TextStyle(color: widget.textColor),
      validator: widget.validator,
    );
  }
}
