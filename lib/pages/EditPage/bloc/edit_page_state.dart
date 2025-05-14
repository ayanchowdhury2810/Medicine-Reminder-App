import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/models/medicine_type_data_model.dart';

class EditPageState { 
  final String medicineName;
  final String dosage;
  final MedicineTypeDataModel medicineType;
  final String interval;
  final TimeOfDay startingTime;
  final bool isConfirmed;

  EditPageState(
      {required this.medicineName,
      required this.dosage,
      required this.medicineType,
      required this.interval,
      required this.startingTime,
      this.isConfirmed = false});

  EditPageState copyWith(
      {String? medicineName,
      String? dosage,
      MedicineTypeDataModel? medicineType,
      String? interval,
      TimeOfDay? startTime,
      bool? isConfirmed}) {
    return EditPageState(
        medicineName: medicineName ?? this.medicineName,
        dosage: dosage ?? this.dosage,
        medicineType: medicineType ?? this.medicineType,
        interval: interval ?? this.interval,
        startingTime: startTime ?? this.startingTime,
        isConfirmed: isConfirmed ?? this.isConfirmed);
  }
}
