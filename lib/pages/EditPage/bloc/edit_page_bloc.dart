 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/data/DataManager.dart';
import 'package:medicine_reminder_app/data/medicine_records.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/models/medicine_type_data_model.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_event.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_state.dart';

class EditPageBloc extends Bloc<EditPageEvent, EditPageState>{
  EditPageBloc() : super(EditPageState(
    medicineName: '',
      dosage: '',
      medicineType: MedicineTypeDataModel(
        imagePath: '',
        desc: '',
        isSelected: false,
      ),
      interval: '',
      startingTime: TimeOfDay.now()
  )){
    on<MedicineNameChanged>(_onMedicineNameChanged);
    on<DosageChanged>(_onDosageChanged);
    on<MedicineTypeSelection>(_onMedicineTypeSelection);
    on<IntervalChanged>(_onIntervalChanged);
    on<StartingTimeChanged>(_onStartTimeChanged);
    on<AddEntryConfirmBtnClickEvent>(_onAddEntryConfirmClickBtnClickEvent);
  }

  final DataManager dataManager = DataManager();

  FutureOr<void> _onMedicineNameChanged(MedicineNameChanged event,
      Emitter<EditPageState> emit) {
    emit(state.copyWith(medicineName: event.medicineName));
  }

  FutureOr<void> _onDosageChanged(DosageChanged event,
      Emitter<EditPageState> emit) {
    emit(state.copyWith(dosage: event.dosage));
  }

  FutureOr<void> _onMedicineTypeSelection(MedicineTypeSelection event,
      Emitter<EditPageState> emit) {
    emit(state.copyWith(medicineType: event.medicineType));
  }

  FutureOr<void> _onIntervalChanged(IntervalChanged event,
      Emitter<EditPageState> emit) {
    emit(state.copyWith(interval: event.interval));
  }


  FutureOr<void> _onStartTimeChanged(StartingTimeChanged event,
      Emitter<EditPageState> emit) {
    emit(state.copyWith(startTime: event.startingTime));
  }

  FutureOr<void> _onAddEntryConfirmClickBtnClickEvent(
      AddEntryConfirmBtnClickEvent event, Emitter<EditPageState> emit) {
    medicineRecords.add(
        MedicineInfoModel(
            medicine_name: state.medicineName,
            dosage: state.dosage,
            medicineType: state.medicineType,
            interval: state.interval,
            startTime: state.startingTime)
    );

    _addData(MedicineInfoModel(medicine_name: state.medicineName,
        dosage: state.dosage,
        medicineType: state.medicineType,
        interval: state.interval,
        startTime: state.startingTime));

    emit(state.copyWith(isConfirmed: true));
  }

  void _addData(MedicineInfoModel medicineInfo) async {
    await dataManager.addReminder(medicineInfo);
  }
}