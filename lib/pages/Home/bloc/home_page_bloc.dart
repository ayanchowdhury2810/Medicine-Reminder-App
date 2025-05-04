import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/data/medicine_records.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/pages/Home/bloc/home_page_event.dart';
import 'package:medicine_reminder_app/pages/Home/bloc/home_page_state.dart';

import '../../../data/DataManager.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitialState()) {
    on<HomePageInitialEvent>(_updateHomePageEvent);
  }

  final DataManager dataManager = DataManager();
  List<MedicineInfoModel> data = [];

  FutureOr<void> _updateHomePageEvent(
      HomePageInitialEvent event, Emitter<HomePageState> emit) async{
    data = await _getData();
    print("medicineRecords -> ${medicineRecords.length}");
    print("data -> ${data}, medicineRecords -> ${medicineRecords}");
    print("data -> ${data.length}");
    // data.map((item) => medicineRecords.add(item));
    medicineRecords.clear();
    medicineRecords.addAll(data);
    // medicineRecords.add(data as MedicineInfoModel);
    emit(HomePageSuccessState(medicineInfoList: medicineRecords));
  }

  Future<List<MedicineInfoModel>> _getData() async {
    return await dataManager.getReminderList();
  }
}
