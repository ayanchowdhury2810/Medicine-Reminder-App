class MedicineTypeDataModel {
  final String imagePath;
  final String desc;
  final bool isSelected;

  MedicineTypeDataModel(
      {required this.imagePath, required this.desc, required this.isSelected});

  Map<String, dynamic> toJson() {
    return {'imagePath': imagePath, 'desc': desc, 'isSelected': isSelected};
  }

  factory MedicineTypeDataModel.fromJson(Map<String, dynamic> json) {
    return MedicineTypeDataModel(
        imagePath: json['imagePath'],
        desc: json['desc'],
        isSelected: json['isSelected']);
  }
}
