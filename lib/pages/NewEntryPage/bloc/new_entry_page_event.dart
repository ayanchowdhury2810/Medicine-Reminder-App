part of 'new_entry_page_bloc.dart';

@immutable
sealed class NewEntryPageEvent {}

class MedicineNameChanged extends NewEntryPageEvent {
  final String medicineName;

  MedicineNameChanged(this.medicineName);
}

class DosageChanged extends NewEntryPageEvent {
  final String dosage;

  DosageChanged(this.dosage);
}

class MedicineTypeChanged extends NewEntryPageEvent {
  final MedicineTypeDataModel medicineType;

  MedicineTypeChanged(this.medicineType);
}

class IntervalChanged extends NewEntryPageEvent {
  final String interval;

  IntervalChanged(this.interval);
}

class StartingTimeChanged extends NewEntryPageEvent {
  final String startingTime;

  StartingTimeChanged(this.startingTime);
}

class AddEntryConfirmBtnClickEvent extends NewEntryPageEvent {
  final MedicineInfoModel medicineInfo;

  AddEntryConfirmBtnClickEvent({required this.medicineInfo});
}
