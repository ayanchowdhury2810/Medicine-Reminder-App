import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/components/text_widget.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/pages/MedicineDetailPage/bloc/medicine_detail_bloc.dart';
import 'package:medicine_reminder_app/pages/MedicineDetailPage/bloc/medicine_detail_event.dart';
import 'package:medicine_reminder_app/pages/MedicineDetailPage/bloc/medicine_detail_state.dart';
import 'package:medicine_reminder_app/routes/routes_name.dart';
import 'package:sizer/sizer.dart';

import '../../components/button_widget.dart';

class MedicineDetailPage extends StatefulWidget {
  final MedicineInfoModel medicineInfoModel;

  const MedicineDetailPage({super.key, required this.medicineInfoModel});

  @override
  State<MedicineDetailPage> createState() => _MedicineDetailPageState();
}

class _MedicineDetailPageState extends State<MedicineDetailPage> {
  late final MedicineDetailBloc medicineDetailBloc;

  @override
  void initState() {
    super.initState();
    medicineDetailBloc = MedicineDetailBloc();
    medicineDetailBloc.add(
        LoadMedicineDetailEvent(medicineInfoModel: widget.medicineInfoModel));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicineDetailBloc, MedicineDetailState>(
      bloc: medicineDetailBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is MedicineDetailSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: TextWidget(
                  data: "Medicine Details",
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          state.medicineInfoModel.medicineType.imagePath,
                          height: 100,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const TextWidget(
                              data: 'Medicine Name',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          TextWidget(
                              data: state.medicineInfoModel.medicine_name,
                              color: kPrimaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextWidget(
                              data: 'Dosage',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          TextWidget(
                              data: state.medicineInfoModel.dosage,
                              color: kPrimaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextWidget(
                      data: 'Medicine Type',
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  TextWidget(
                      data: state.medicineInfoModel.medicineType.desc,
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextWidget(
                      data: 'Dose Interval',
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  TextWidget(
                      data: state.medicineInfoModel.interval,
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextWidget(
                      data: 'Start Time',
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  TextWidget(
                      data:
                          '${state.medicineInfoModel.startTime.hour}:${state.medicineInfoModel.startTime.minute}',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                    child: SizedBox(
                      height: 70.px,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonWidget(
                          backgroundColor: kPrimaryColor,
                          btnText: "Edit Reminder",
                          txtColor: Colors.white,
                          fontSize: 20,
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.editScreen, arguments: state.medicineInfoModel);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                    child: SizedBox(
                      height: 70.px,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonWidget(
                          backgroundColor: kPrimaryColor,
                          btnText: "Delete Reminder",
                          txtColor: Colors.white,
                          fontSize: 20,
                          onPressed: () {
                            setState(() {
                              medicineDetailBloc.add(
                                  RemoveMedicineReminderEvent(
                                      medicineInfoModel:
                                          state.medicineInfoModel));
                              Navigator.pop(context, true);
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
