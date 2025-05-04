import 'package:flutter/cupertino.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';

@immutable
abstract class MedicineDetailState {}

class MedicineDetailInitialState extends MedicineDetailState {}

class MedicineDetailLoadingState extends MedicineDetailState {}

class MedicineDetailSuccessState extends MedicineDetailState {
  final MedicineInfoModel medicineInfoModel;

  MedicineDetailSuccessState({required this.medicineInfoModel});
}

class RemoveMedicineReminderState extends MedicineDetailState {
  // final MedicineInfoModel medicineInfoModel;

  RemoveMedicineReminderState();
}