import 'dart:convert';

import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  static const _key = 'medicineInfo';

  Future<void> saveLReminderList(List<MedicineInfoModel> medicineInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final List<String> info = prefs.getStringList(_key) ?? [];
    final List<String> info = medicineInfo.map((medicine) => jsonEncode(medicine.toJson())).toList();
    print("infoooo 11111=> $info");
    // info.add(jsonEncode(medicineInfo.toJson()));
    // print("infoooo 22222=> $info");
    await prefs.setStringList(_key, info);
  }

  Future<void> removeReminder(MedicineInfoModel medicineInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> info = prefs.getStringList(_key) ?? [];
    info.removeWhere((it) {
      final data = json.decode(it);
      return data['medicine_name'] == medicineInfo.medicine_name &&
          data['dosage'] == medicineInfo.dosage &&
          data['medicineType'] == medicineInfo.medicineType &&
          data['interval'] == medicineInfo.interval &&
          data['startTime'] == medicineInfo.startTime;
    });
  }

  Future<List<MedicineInfoModel>> getReminderList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> info = prefs.getStringList(_key) ?? [];
    print("infoooo  get=> $info");
    return info.map((infoJson) =>
      // final infoData = jsonDecode(infoJson);
      // return MedicineInfoModel(
      //     medicine_name: infoData['medicine_name'],
      //     dosage: infoData['dosage'],
      //     medicineType: infoData['medicineType'],
      //     interval: infoData['interval'],
      //     startTime: infoData['startTime']);
      MedicineInfoModel.fromJson(jsonDecode(infoJson))
    // }
    ).toList();
  }

  Future<void> addReminder(MedicineInfoModel medicine) async{
    List<MedicineInfoModel> currentList = await getReminderList();
    currentList.add(medicine);
    await saveLReminderList(currentList);
  }
}
