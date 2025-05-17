import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/components/button_widget.dart';
import 'package:medicine_reminder_app/components/text_widget.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:medicine_reminder_app/data/DataManager.dart';
import 'package:medicine_reminder_app/data/medicine_type.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/models/medicine_type_data_model.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_bloc.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_event.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_state.dart';
import 'package:medicine_reminder_app/pages/NewEntryPage/widgets/add_text_data.dart';
import 'package:medicine_reminder_app/pages/NewEntryPage/widgets/medicine_type_card.dart';
import 'package:medicine_reminder_app/routes/routes_name.dart';
import 'package:sizer/sizer.dart';

class EditPage extends StatefulWidget {
  final MedicineInfoModel medicineInfoModel;

  const EditPage({super.key, required this.medicineInfoModel});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode medicineNameFocusNode = FocusNode();
  final FocusNode dosageFocusNode = FocusNode();
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  String? dropDownValue;
  final DataManager dataManager = DataManager();
  MedicineTypeDataModel? selectedMedicineType;
  int selectedMedicineTypeIndex = -1;
  bool showMedicineTypeValidation = false;
  String? selectedInterval;
  bool showIntervalValidation = false;
  TimeOfDay? selectedStartTime;
  bool showStartTimeValidation = false;
  final bool areAllConditionsChecked = false;
  late EditPageBloc editPageBloc;

  @override
  void initState() {
    super.initState();
    medicineNameController.text = widget.medicineInfoModel.medicine_name;
    dosageController.text = widget.medicineInfoModel.dosage;
    selectedMedicineType = widget.medicineInfoModel.medicineType;
    selectedMedicineTypeIndex = MedicineType.medicineTypesData.indexWhere(
        (element) =>
            element.desc == widget.medicineInfoModel.medicineType.desc);
    selectedInterval = widget.medicineInfoModel.interval;
    selectedStartTime = widget.medicineInfoModel.startTime;
    editPageBloc = EditPageBloc(
        initialMedicineName: widget.medicineInfoModel.medicine_name,
        initialDosage: widget.medicineInfoModel.dosage,
        initialMedicineType: widget.medicineInfoModel.medicineType,
        initialInterval: widget.medicineInfoModel.interval,
        initialStartingTime: widget.medicineInfoModel.startTime);
  }

  void _unfocusTextFields() {
    if (medicineNameFocusNode.hasFocus) {
      medicineNameFocusNode.unfocus();
    }

    if (dosageFocusNode.hasFocus) {
      dosageFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String medicineTypeValidation = "";

    return GestureDetector(
      onTap: _unfocusTextFields,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: BlocConsumer<EditPageBloc, EditPageState>(
          bloc: editPageBloc,
          listener: (context, state) {
            if (state.isConfirmed) {
              Future<dynamic>.delayed(Duration(seconds: 5));
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Edited Successfully")));
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesName.homeScreen, (route) => false);
            }
          },
          listenWhen: (previous, current) =>
              current.isConfirmed != previous.isConfirmed,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AddTextData(
                          fieldTitle: "Medicine Name",
                          hintText: "Enter medicine name",
                          focusNode: medicineNameFocusNode,
                          textEditingController: medicineNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter medicine name";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            editPageBloc.add(MedicineNameChanged(value));
                          },
                        ),
                        SizedBox(
                          height: 20.px,
                        ),
                        AddTextData(
                          fieldTitle: "Dosage",
                          hintText: "Enter dosage",
                          focusNode: dosageFocusNode,
                          textEditingController: dosageController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter dosage";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            editPageBloc.add(DosageChanged(value));
                          },
                        ),
                        SizedBox(
                          height: 20.px,
                        ),
                        const TextWidget(
                            data: "Medicine Type",
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        SizedBox(
                          height: 20.px,
                        ),
                        SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: MedicineType.medicineTypesData.length,
                            itemBuilder: (context, index) {
                              return MedicineTypeCard(
                                  imagePath: MedicineType
                                      .medicineTypesData[index].imagePath,
                                  desc: MedicineType
                                      .medicineTypesData[index].desc,
                                  onClick: () {
                                    editPageBloc.add(
                                      MedicineTypeSelection(
                                        MedicineTypeDataModel(
                                            imagePath: MedicineType
                                                .medicineTypesData[index]
                                                .imagePath,
                                            desc: MedicineType
                                                .medicineTypesData[index].desc,
                                            isSelected: MedicineType
                                                .medicineTypesData[index]
                                                .isSelected),
                                      ),
                                    );

                                    setState(() {
                                      selectedMedicineType =
                                          MedicineTypeDataModel(
                                              imagePath: MedicineType
                                                  .medicineTypesData[index]
                                                  .imagePath,
                                              desc: MedicineType
                                                  .medicineTypesData[index]
                                                  .desc,
                                              isSelected: MedicineType
                                                  .medicineTypesData[index]
                                                  .isSelected);
                                      selectedMedicineTypeIndex = index;
                                    });
                                  },
                                  isItemSelected:
                                      selectedMedicineTypeIndex == index);
                            },
                          ),
                        ),
                        Visibility(
                          visible: showMedicineTypeValidation,
                          child: TextWidget(
                              data: "Fill it",
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 20.px,
                        ),
                        const TextWidget(
                            data: "Interval Selection",
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        Row(
                          children: [
                            const TextWidget(
                              data: "Remind me every  ",
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                            DropdownButton(
                              value: dropDownValue,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: kPrimaryColor,
                              ),
                              hint: TextWidget(
                                  data: selectedInterval!,
                                  color: kPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                              items: MedicineType.hrsList.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: TextWidget(
                                      data: item,
                                      color: kPrimaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                );
                              }).toList(),
                              onChanged: (String? newVal) {
                                setState(() {
                                  dropDownValue = newVal!;
                                  selectedInterval = newVal!;
                                  showIntervalValidation = false;
                                  editPageBloc
                                      .add(IntervalChanged(selectedInterval!));
                                });
                              },
                            ),
                            const TextWidget(
                                data: " hours",
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
                        Visibility(
                          visible: showIntervalValidation,
                          child: const Column(
                            children: [
                              TextWidget(
                                  data: "Please enter Interval",
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.px,
                        ),
                        const TextWidget(
                            data: "Starting Time",
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        SizedBox(
                          height: 10.px,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonWidget(
                            backgroundColor: kPrimaryColor,
                            btnText: (selectedStartTime == null)
                                ? "Pick Date"
                                : "${selectedStartTime?.hour}:${selectedStartTime?.minute}",
                            txtColor: Colors.white,
                            fontSize: 15,
                            onPressed: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: (selectedStartTime == null)
                                      ? TimeOfDay.now()
                                      : selectedStartTime!,
                                  initialEntryMode: TimePickerEntryMode.dial);
                              if (timeOfDay != null) {
                                editPageBloc.add(
                                  StartingTimeChanged(timeOfDay),
                                );
                                setState(() {
                                  selectedStartTime = timeOfDay;
                                  showStartTimeValidation = false;
                                });
                              }
                            },
                          ),
                        ),
                        Visibility(
                          visible: showStartTimeValidation,
                          child: const Column(
                            children: [
                              const TextWidget(
                                  data: "Please pick a start time",
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 50),
                          child: SizedBox(
                            height: 70.px,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ButtonWidget(
                                backgroundColor: kPrimaryColor,
                                btnText: "Confirm",
                                txtColor: Colors.white,
                                fontSize: 20,
                                onPressed: () {
                                  setState(() {
                                    if (selectedInterval!.isEmpty ||
                                        selectedInterval == null ||
                                        selectedInterval ==
                                            "Select an Interval") {
                                      showIntervalValidation = true;
                                    }

                                    if (selectedStartTime == null) {
                                      showStartTimeValidation = true;
                                    }
                                  });
                                  if (_formKey.currentState!.validate() &&
                                      !showIntervalValidation &&
                                      !showStartTimeValidation) {
                                    editPageBloc.add(
                                      EditEntryConfirmBtnClickEvent(
                                          id: widget.medicineInfoModel.id),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
