import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/data/DataManager.dart';
import 'package:medicine_reminder_app/data/medicine_records.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/models/medicine_type_data_model.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_event.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_state.dart';

class EditPageBloc extends Bloc<EditPageEvent, EditPageState> {
  EditPageBloc(
      {required String initialMedicineName,
      required String initialDosage,
      required MedicineTypeDataModel initialMedicineType,
      required String initialInterval,
      required TimeOfDay initialStartingTime})
      : super(EditPageState(
            medicineName: initialMedicineName,
            dosage: initialDosage,
            medicineType: initialMedicineType,
            interval: initialInterval,
            startingTime: initialStartingTime)) {
    on<MedicineNameChanged>(_onMedicineNameChanged);
    on<DosageChanged>(_onDosageChanged);
    on<MedicineTypeSelection>(_onMedicineTypeSelection);
    on<IntervalChanged>(_onIntervalChanged);
    on<StartingTimeChanged>(_onStartTimeChanged);
    on<EditEntryConfirmBtnClickEvent>(_onEditEntryConfirmClickBtnClickEvent);
  }

  final DataManager dataManager = DataManager();

  FutureOr<void> _onMedicineNameChanged(
      MedicineNameChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(medicineName: event.medicineName));
  }

  FutureOr<void> _onDosageChanged(
      DosageChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(dosage: event.dosage));
  }

  FutureOr<void> _onMedicineTypeSelection(
      MedicineTypeSelection event, Emitter<EditPageState> emit) {
    emit(state.copyWith(medicineType: event.medicineType));
  }

  FutureOr<void> _onIntervalChanged(
      IntervalChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(interval: event.interval));
  }

  FutureOr<void> _onStartTimeChanged(
      StartingTimeChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(startTime: event.startingTime));
  }

  FutureOr<void> _onEditEntryConfirmClickBtnClickEvent(
      EditEntryConfirmBtnClickEvent event, Emitter<EditPageState> emit) {
    int index =
        medicineRecords.indexWhere((medicine) => medicine.id == event.id);

    if (index != -1) {
      medicineRecords[index] = MedicineInfoModel(
          id: event.id,
          medicine_name: state.medicineName,
          dosage: state.dosage,
          medicineType: MedicineTypeDataModel(
              imagePath: state.medicineType.imagePath,
              desc: state.medicineType.desc,
              isSelected: state.medicineType.isSelected),
          interval: state.interval,
          startTime: state.startingTime);
    }

    _editData(medicineRecords[index]);

    print("resss-> ${medicineRecords[index].medicine_name}");

    emit(state.copyWith(isConfirmed: true));
  }

  void _editData(MedicineInfoModel medicineInfo) async {
    print("resss22222-> ${medicineInfo.medicine_name}");
    print(
        "ress00000-> ${medicineInfo.medicineType.imagePath}, ${medicineInfo.medicineType.desc}, ${medicineInfo.medicineType.isSelected}");

    await dataManager.editReminderList(medicineInfo);
  }
}
