import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/components/text_widget.dart';
import 'package:medicine_reminder_app/constants.dart';

class MedicineTypeCard extends StatefulWidget {
  final bool isItemSelected;
  final String imagePath;
  final String desc;
  final VoidCallback onClick;

  const MedicineTypeCard(
      {super.key,
      required this.imagePath,
      required this.desc,
      required this.onClick,
      required this.isItemSelected});

  @override
  State<MedicineTypeCard> createState() => _MedicineTypeCardState();
}

class _MedicineTypeCardState extends State<MedicineTypeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onClick();
        });
      },
      child: Container(
        height: 20,
        color: widget.isItemSelected ? kPrimaryColor : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              height: 100,
              width: 100,
              scale: 1,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
                data: widget.desc,
                color: widget.isItemSelected ? Colors.white : kPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.normal)
          ],
        ),
      ),
    );
  }
}
