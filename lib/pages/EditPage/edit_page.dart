import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:medicine_reminder_app/data/DataManager.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/models/medicine_type_data_model.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_bloc.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_event.dart';
import 'package:medicine_reminder_app/pages/EditPage/bloc/edit_page_state.dart';
import 'package:medicine_reminder_app/pages/NewEntryPage/widgets/add_text_data.dart';
import 'package:sizer/sizer.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required MedicineInfoModel medicineInfoModel});

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
    selectedInterval = "Select an Interval";
    editPageBloc = EditPageBloc();
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
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Submitted")));
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
                          )
                        ],
                      )
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
