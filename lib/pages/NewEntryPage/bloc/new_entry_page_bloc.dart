import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/data/medicine_records.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/DataManager.dart';
import '../../../models/medicine_type_data_model.dart';

part 'new_entry_page_event.dart';
part 'new_entry_page_state.dart';

class NewEntryPageBloc extends Bloc<NewEntryPageEvent, NewEntryPageState> {
  NewEntryPageBloc()
      : super(NewEntryPageState(
            medicineName: '',
            dosage: '',
            medicineType: MedicineTypeDataModel(
              imagePath: '',
              desc: '',
              isSelected: false,
            ),
            interval: '',
            startingTime: TimeOfDay.now())) {
    // on<MedicineNameChanged>(_onMedicineNameChanged);
    // on<DosageChanged>(_onDosageChanged);
    // on<MedicineTypeChanged>(_onMedicineTypeChanged);
    // on<IntervalChanged>(_onIntervalChanged);
    // on<StartingTimeChanged>(_onStartTimeChanged);
    on<AddEntryConfirmBtnClickEvent>(_onAddEntryConfirmClickBtnClickEvent);
  }
  final DataManager dataManager = DataManager();

  // FutureOr<void> _onMedicineNameChanged(
  //     MedicineNameChanged event, Emitter<NewEntryPageState> emit) {
  //   emit(state.copyWith(medicineName: event.medicineName));
  // }
  //
  // FutureOr<void> _onDosageChanged(
  //     DosageChanged event, Emitter<NewEntryPageState> emit) {
  //   emit(state.copyWith(dosage: event.dosage));
  // }
  //
  // FutureOr<void> _onMedicineTypeChanged(
  //     MedicineTypeChanged event, Emitter<NewEntryPageState> emit) {
  //   emit(state.copyWith(medicineType: event.medicineType));
  // }
  //
  // FutureOr<void> _onIntervalChanged(
  //     IntervalChanged event, Emitter<NewEntryPageState> emit) {
  //   emit(state.copyWith(interval: event.interval));
  // }
  //
  // FutureOr<void> _onStartTimeChanged(
  //     StartingTimeChanged event, Emitter<NewEntryPageState> emit) {
  //   emit(state.copyWith(startTime: event.startingTime));
  // }

  FutureOr<void> _onAddEntryConfirmClickBtnClickEvent(
      AddEntryConfirmBtnClickEvent event, Emitter<NewEntryPageState> emit) {
    medicineRecords.add(event.medicineInfo);
    _addData(event.medicineInfo);
    emit(state.copyWith(isConfirmed: true));
  }

  void _addData(MedicineInfoModel medicineInfo) async{
    await dataManager.addReminder(medicineInfo);
  }
}
