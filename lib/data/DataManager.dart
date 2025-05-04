import 'dart:convert';

import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  static const _key = 'medicineInfo';

  Future<void> saveLReminderList(List<MedicineInfoModel> medicineInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final List<String> info = prefs.getStringList(_key) ?? [];
    final List<String> info =
        medicineInfo.map((medicine) => jsonEncode(medicine.toJson())).toList();
    await prefs.setStringList(_key, info);
  }

  Future<void> removeReminder(MedicineInfoModel medicineInfo) async {
    List<MedicineInfoModel> currentList = await getReminderList();
    currentList.removeWhere((item) =>
        item.medicine_name == medicineInfo.medicine_name &&
        item.dosage == medicineInfo.dosage &&
        item.medicineType.desc == medicineInfo.medicineType.desc &&
        item.interval == medicineInfo.interval &&
        item.startTime.hour == medicineInfo.startTime.hour &&
        item.startTime.minute == medicineInfo.startTime.minute);
    await saveLReminderList(currentList);
  }

  Future<List<MedicineInfoModel>> getReminderList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> info = prefs.getStringList(_key) ?? [];
    print("infoooo  get=> $info");
    return info
        .map((infoJson) => MedicineInfoModel.fromJson(jsonDecode(infoJson)))
        .toList();
  }

  Future<void> addReminder(MedicineInfoModel medicine) async {
    List<MedicineInfoModel> currentList = await getReminderList();
    currentList.add(medicine);
    await saveLReminderList(currentList);
  }
}
