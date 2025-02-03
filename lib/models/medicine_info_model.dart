import 'package:flutter/material.dart';

import 'medicine_type_data_model.dart';

class MedicineInfoModel {
  final String medicine_name;
  final String dosage;
  final MedicineTypeDataModel medicineType;
  final String interval;
  final TimeOfDay startTime;

  MedicineInfoModel({
    required this.medicine_name,
    required this.dosage,
    required this.medicineType,
    required this.interval,
    required this.startTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'medicine_name': medicine_name,
      'dosage': dosage,
      'medicineType': medicineType.toJson(),
      'interval': interval,
      'startTime': '${startTime.hour}:${startTime.minute}'
    };
  }

  factory MedicineInfoModel.fromJson(Map<String, dynamic> json) {
    List<String> timeParts = json['startTime'].split(':');
    return MedicineInfoModel(
        medicine_name: json['medicine_name'],
        dosage: json['dosage'],
        medicineType: MedicineTypeDataModel.fromJson(json['medicineType']),
        interval: json['interval'],
        startTime: TimeOfDay(
            hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1])));
  }
}
