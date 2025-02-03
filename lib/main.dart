import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:medicine_reminder_app/pages/Home/home_page.dart';
import 'package:medicine_reminder_app/pages/MedicineDetailPage/medicine_detail_page.dart';
import 'package:medicine_reminder_app/pages/NewEntryPage/new_entry_page.dart';
import 'package:medicine_reminder_app/pages/SuccessPage/success_page.dart';
import 'package:medicine_reminder_app/routes/routes.dart';
import 'package:medicine_reminder_app/routes/routes_name.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medicine Reminder',
        theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kScaffoldColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: kScaffoldColor,
            elevation: 0,
          ),
          // textTheme: TextTheme(
          //   // headlineLarge: TextStyle(
          //   //     fontSize: 28.sp,
          //   //     color: kSecondaryColor,
          //   //     fontWeight: FontWeight.w500),
          //   // headlineMedium: TextStyle(
          //   //     fontSize: 24.sp,
          //   //     fontWeight: FontWeight.w800,
          //   //     color: kTextColor),
          //   titleMedium:
          //       GoogleFonts.poppins(fontSize: 15.sp, color: kTextColor),
          // ),
        ),
        initialRoute: RoutesName.homeScreen,
        onGenerateRoute: Routes.generateRoute,
      );
    });
  }
}
