import 'package:flutter/cupertino.dart';

import '../../../models/medicine_info_model.dart';

@immutable
abstract class HomePageEvent {}

class HomePageInitialEvent extends HomePageEvent {}

class RemoveMedicineReminderEvent extends HomePageEvent {
  final MedicineInfoModel medicineInfoModel;

  RemoveMedicineReminderEvent({required this.medicineInfoModel});
}
