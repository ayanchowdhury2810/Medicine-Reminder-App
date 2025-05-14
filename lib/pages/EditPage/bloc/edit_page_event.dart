import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/models/medicine_type_data_model.dart';

@immutable
abstract class EditPageEvent {}

class MedicineNameChanged extends EditPageEvent {
  final String medicineName;

  MedicineNameChanged(this.medicineName);
}

class DosageChanged extends EditPageEvent {
  final String dosage;

  DosageChanged(this.dosage);
}

class MedicineTypeSelection extends EditPageEvent {
  final MedicineTypeDataModel medicineType;

  MedicineTypeSelection(this.medicineType);
}

class IntervalChanged extends EditPageEvent {
  final String interval;

  IntervalChanged(this.interval);
}

class StartingTimeChanged extends EditPageEvent {
  final TimeOfDay startingTime;

  StartingTimeChanged(this.startingTime);
}

class EditEntryConfirmBtnClickEvent extends EditPageEvent {
  final int id;

  EditEntryConfirmBtnClickEvent({required this.id});
}
