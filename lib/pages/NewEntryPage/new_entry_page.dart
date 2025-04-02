import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/components/button_widget.dart';
import 'package:medicine_reminder_app/components/text_widget.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:medicine_reminder_app/data/DataManager.dart';
import 'package:medicine_reminder_app/data/medicine_type.dart';
import 'package:medicine_reminder_app/models/medicine_type_data_model.dart';
import 'package:medicine_reminder_app/pages/NewEntryPage/bloc/new_entry_page_bloc.dart';
import 'package:medicine_reminder_app/pages/NewEntryPage/widgets/add_text_data.dart';
import 'package:medicine_reminder_app/pages/NewEntryPage/widgets/medicine_type_card.dart';
import 'package:medicine_reminder_app/routes/routes_name.dart';
import 'package:sizer/sizer.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode medicineNameFocusNode = FocusNode();
  final dosageFocusNode = FocusNode();
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  String? dropDownValue;
  final DataManager dataManager = DataManager();

  // String? dropDownHintText;
  MedicineTypeDataModel? selectedMedicineType;
  int selectedMedicineTypeIndex = -1;
  bool showMedicineTypeValidation = false;
  String? selectedInterval;
  bool showIntervalValidation = false;
  TimeOfDay? selectedStartTime;
  bool showStartTimeValidation = false;
  final bool areAllConditionsChecked = false;
  late NewEntryPageBloc _newEntryPageBloc;

  @override
  void initState() {
    super.initState();
    selectedInterval = "Select an Interval";
    _newEntryPageBloc = NewEntryPageBloc();
    // selectedTime = TimeOfDay.now();
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
          body: BlocConsumer<NewEntryPageBloc, NewEntryPageState>(
            bloc: _newEntryPageBloc,
            listenWhen: (previous, current) =>
                current.isConfirmed != previous.isConfirmed,
            listener: (context, state) {
              if (state.isConfirmed) {
                Future.delayed(Duration(seconds: 5));
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Submitted")));
                Navigator.pushNamed(context, RoutesName.successScreen);
                // _addData(state);
              }
            },
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
                              _newEntryPageBloc.add(MedicineNameChanged(value));
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
                              _newEntryPageBloc.add(DosageChanged(value));
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
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     children: MedicineType.medicineTypesData
                          //         .map(
                          //           (e) => Padding(
                          //             padding: EdgeInsets.all(2.px),
                          //             child: MedicineTypeCard(
                          //               isItemSelected:
                          //                   selectedMedicineType == e,
                          //               imagePath: e.imagePath,
                          //               desc: e.desc,
                          //               onClick: () {
                          //                 setState(() {
                          //                   selectedMedicineType =
                          //                       MedicineTypeDataModel(
                          //                           imagePath: e.imagePath,
                          //                           desc: e.desc,
                          //                           isSelected: e.isSelected);
                          //
                          //                   print(
                          //                       "selectedMedicineType: => ${selectedMedicineType?.desc} ${selectedMedicineType?.imagePath} ${selectedMedicineType == e}");
                          //                 });
                          //               },
                          //             ),
                          //           ),
                          //         )
                          //         .toList(),
                          // [
                          //   MedicineTypeCard(
                          //     imagePath: 'assets/icons/bottle.png',
                          //     desc: 'Bottle',
                          //   ),
                          //   SizedBox(
                          //     width: 10,
                          //   ),
                          //   MedicineTypeCard(
                          //     imagePath: 'assets/icons/pills.png',
                          //     desc: 'Pills',
                          //   ),
                          //   SizedBox(
                          //     width: 10,
                          //   ),
                          //   MedicineTypeCard(
                          //     imagePath: 'assets/icons/syringe.png',
                          //     desc: 'Syringe',
                          //   ),
                          //   SizedBox(
                          //     width: 10,
                          //   ),
                          //   MedicineTypeCard(
                          //     imagePath: 'assets/icons/tablet.png',
                          //     desc: 'Tablet',
                          //   ),
                          // ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    MedicineType.medicineTypesData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      color: Colors.red,
                                      height: 20,
                                      child: MedicineTypeCard(
                                        isItemSelected:
                                            selectedMedicineTypeIndex == index,
                                        imagePath: MedicineType
                                            .medicineTypesData[index].imagePath,
                                        desc: MedicineType
                                            .medicineTypesData[index].desc,
                                        onClick: () {
                                          _newEntryPageBloc.add(
                                              MedicineTypeSelection(
                                                  MedicineTypeDataModel(
                                                      imagePath: MedicineType
                                                          .medicineTypesData[
                                                              index]
                                                          .imagePath,
                                                      desc: MedicineType
                                                          .medicineTypesData[
                                                              index]
                                                          .desc,
                                                      isSelected: MedicineType
                                                          .medicineTypesData[
                                                              index]
                                                          .isSelected)));

                                          setState(() {
                                            selectedMedicineType =
                                                MedicineTypeDataModel(
                                                    imagePath: MedicineType
                                                        .medicineTypesData[
                                                            index]
                                                        .imagePath,
                                                    desc: MedicineType
                                                        .medicineTypesData[
                                                            index]
                                                        .desc,
                                                    isSelected: MedicineType
                                                        .medicineTypesData[
                                                            index]
                                                        .isSelected);

                                            selectedMedicineTypeIndex = index;
                                            print(
                                                "selectedMedicineType: => ${selectedMedicineType?.desc} ${selectedMedicineType?.imagePath} ${selectedMedicineTypeIndex == index}");
                                          });
                                        },
                                      ));
                                }),
                          ),
                          Visibility(
                              visible: showMedicineTypeValidation,
                              child: TextWidget(
                                  data: "Fill it",
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(
                            height: 20.px,
                          ),
                          const TextWidget(
                              data: "Interval selection",
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          Row(
                            children: [
                              const TextWidget(
                                  data: "Remind me every   ",
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
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
                                    _newEntryPageBloc.add(
                                        IntervalChanged(selectedInterval!));
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
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: 5.px,
                                // ),
                                const TextWidget(
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
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                        context: context,
                                        initialTime: (selectedStartTime == null)
                                            ? TimeOfDay.now()
                                            : selectedStartTime!,
                                        initialEntryMode:
                                            TimePickerEntryMode.dial);
                                if (timeOfDay != null) {
                                  _newEntryPageBloc.add(
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
                                // SizedBox(
                                //   height: 5.px,
                                // ),
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
                                      _newEntryPageBloc.add(
                                        AddEntryConfirmBtnClickEvent(
                                            // medicineInfo: MedicineInfoModel(
                                            //     medicine_name:
                                            //         medicineNameController.text,
                                            //     dosage: dosageController.text,
                                            //     medicineType:
                                            //         selectedMedicineType!,
                                            //     interval: selectedInterval!,
                                            //     startTime: selectedStartTime!),
                                            ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
