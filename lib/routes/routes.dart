import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/pages/Home/home_page.dart';
import 'package:medicine_reminder_app/pages/MedicineDetailPage/medicine_detail_page.dart';
import 'package:medicine_reminder_app/pages/NewEntryPage/new_entry_page.dart';
import 'package:medicine_reminder_app/pages/SuccessPage/success_page.dart';
import 'package:medicine_reminder_app/routes/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case RoutesName.newEntryScreen:
        return MaterialPageRoute(builder: (context) => const NewEntryPage());
      case RoutesName.successScreen:
        return MaterialPageRoute(builder: (context) => const SuccessPage());
      case RoutesName.medicineDetailScreen:
        final args = settings.arguments as MedicineInfoModel;
        return MaterialPageRoute(
            builder: (context) => MedicineDetailPage(medicineInfoModel: args));
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Invalid Route'),
            ),
          );
        });
    }
  }
}
