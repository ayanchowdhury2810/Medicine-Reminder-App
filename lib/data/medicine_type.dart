import '../models/medicine_type_data_model.dart';

class MedicineType {
  static List<MedicineTypeDataModel> medicineTypesData = [
    MedicineTypeDataModel(
      imagePath: "assets/icons/bottle.png",
      desc: "Bottle",
      isSelected: false
    ),MedicineTypeDataModel(
      imagePath: "assets/icons/pills.png",
      desc: "Pills",
      isSelected: false
    ),MedicineTypeDataModel(
      imagePath: "assets/icons/syringe.png",
      desc: "Syringe",
      isSelected: false
    ),MedicineTypeDataModel(
      imagePath: "assets/icons/tablet.png",
      desc: "Tablet",
      isSelected: false
    ),
  ];

  static List<String> hrsList = ['1', '2', '3', '4', '5', '6', '7', '8'];

}
