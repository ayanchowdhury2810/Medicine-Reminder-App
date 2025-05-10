import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/components/text_field_widget.dart';
import 'package:medicine_reminder_app/components/text_widget.dart';

class AddTextData extends StatefulWidget {
  final String fieldTitle;
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final ValueChanged<String> onChanged;

  const AddTextData({
    super.key,
    required this.fieldTitle,
    required this.hintText,
    required this.focusNode,
    required this.textEditingController,
    this.validator,
    required this.onChanged,
  });

  @override
  State<AddTextData> createState() => _AddTextDataState();
}

class _AddTextDataState extends State<AddTextData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          data: widget.fieldTitle,
          textAlign: TextAlign.start,
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),

        TextFieldWidget(
          focusNode: widget.focusNode,
          hintText: widget.hintText,
          textEditingController: widget.textEditingController,
          onChanged: widget.onChanged,
          validator: widget.validator,
        )
      ],
    );
  }
}
