import 'package:flutter/cupertino.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';

@immutable
abstract class MedicineDetailEvent {}

class LoadMedicineDetailEvent extends MedicineDetailEvent {
  final MedicineInfoModel medicineInfoModel;

  LoadMedicineDetailEvent({required this.medicineInfoModel});
}

class RemoveMedicineReminderEvent extends MedicineDetailEvent {
  final MedicineInfoModel medicineInfoModel;

  RemoveMedicineReminderEvent({required this.medicineInfoModel});
}
