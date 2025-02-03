import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/medicine_records.dart';
import '../Home/bloc/home_page_bloc.dart';
import '../Home/bloc/home_page_event.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  // final HomePageBloc homePageBloc = HomePageBloc();

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.popUntil(context, (routes) => routes.isFirst);
    });

    print("size ---> ${medicineRecords.length}");
    print("data ---> ${medicineRecords[0].medicine_name}");

    // homePageBloc.add(HomePageInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/icons/green_tick.png',
            height: 200,
            width: 200,
          ),
        ));
  }
}
