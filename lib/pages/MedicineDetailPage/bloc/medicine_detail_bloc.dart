import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/data/DataManager.dart';
import 'package:medicine_reminder_app/data/medicine_records.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/pages/MedicineDetailPage/bloc/medicine_detail_event.dart';
import 'package:medicine_reminder_app/pages/MedicineDetailPage/bloc/medicine_detail_state.dart';

class MedicineDetailBloc
    extends Bloc<MedicineDetailEvent, MedicineDetailState> {
  MedicineDetailBloc() : super(MedicineDetailInitialState()) {
    on<LoadMedicineDetailEvent>(_onLoadMedicineDetail);
    on<RemoveMedicineReminderEvent>(_removeMedicineReminderEvent);
  }

  final DataManager dataManager = DataManager();

  void _onLoadMedicineDetail(
      LoadMedicineDetailEvent event, Emitter<MedicineDetailState> emit) {
    emit(MedicineDetailLoadingState());
    emit(
        MedicineDetailSuccessState(medicineInfoModel: event.medicineInfoModel));
  }
  
  FutureOr<void> _removeMedicineReminderEvent(
      RemoveMedicineReminderEvent event, Emitter<MedicineDetailState> emit) {
    // medicineRecords.remove(event.medicineInfoModel);de
    medicineRecords.removeWhere((item) => item.medicine_name == event.medicineInfoModel.medicine_name);
    _removeReminder(MedicineInfoModel(medicine_name: event.medicineInfoModel.medicine_name,
        dosage: event.medicineInfoModel.dosage,
        medicineType: event.medicineInfoModel.medicineType,
        interval: event.medicineInfoModel.interval,
        startTime: event.medicineInfoModel.startTime));
    emit(MedicineDetailSuccessState(medicineInfoModel: event.medicineInfoModel));
  }

  void _removeReminder(MedicineInfoModel medicineInfoModel) async{
    await dataManager.removeReminder(medicineInfoModel);
  }
}
