part of 'new_entry_page_bloc.dart';

// @immutable
// sealed class NewEntryState {}
//
// abstract class NewEntryPageActionState extends NewEntryState {}

class NewEntryPageState {
  final String medicineName;
  final String dosage;
  final MedicineTypeDataModel medicineType;
  final String interval;
  final TimeOfDay startingTime;
  final bool isConfirmed;

  NewEntryPageState(
      {required this.medicineName,
      required this.dosage,
      required this.medicineType,
      required this.interval,
      required this.startingTime,
      this.isConfirmed = false});

  NewEntryPageState copyWith({
    String? medicineName,
    String? dosage,
    MedicineTypeDataModel? medicineType,
    String? interval,
    TimeOfDay? startTime,
    bool? isConfirmed
  }) {
    return NewEntryPageState(
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      medicineType: medicineType ?? this.medicineType,
      interval: interval ?? this.interval,
      startingTime: startTime ?? this.startingTime,
      isConfirmed: isConfirmed ?? this.isConfirmed
    );
  }
}