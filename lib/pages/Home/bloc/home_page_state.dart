import 'package:flutter/cupertino.dart';

import '../../../models/medicine_info_model.dart';

@immutable
abstract class HomePageState {}

abstract class HomePageActionState extends HomePageState{}

final class HomePageInitialState extends HomePageState {}

final class HomePageSuccessState extends HomePageState {
  final List<MedicineInfoModel> medicineInfoList;

  HomePageSuccessState({required this.medicineInfoList});
}
