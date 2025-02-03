import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/components/text_widget.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:sizer/sizer.dart';

import '../../components/button_widget.dart';

class MedicineDetailPage extends StatefulWidget {
  const MedicineDetailPage({super.key});

  @override
  State<MedicineDetailPage> createState() => _MedicineDetailPageState();
}

class _MedicineDetailPageState extends State<MedicineDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            data: "Medicine Details",
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/icons/syringe.png',
                    height: 100,
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextWidget(
                        data: 'Medidine Name',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                    TextWidget(
                        data: 'Pandol',
                        color: kPrimaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        data: 'Dosage',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                    TextWidget(
                        data: '100 mg',
                        color: kPrimaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextWidget(
                data: 'Medicine Type',
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold),
            TextWidget(
                data: 'Pill',
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal),
            SizedBox(
              height: 20,
            ),
            TextWidget(
                data: 'Dose Interval',
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold),
            TextWidget(
                data: 'Every 8 hour(s) | 3 time(s) a day',
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal),
            SizedBox(
              height: 20,
            ),
            TextWidget(
                data: 'Start Time',
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold),
            TextWidget(
                data: '20:00',
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: SizedBox(
                height: 70.px,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                    backgroundColor: kPrimaryColor,
                    btnText: "Delete Reminder",
                    txtColor: Colors.white,
                    fontSize: 20,
                    onPressed: () {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
