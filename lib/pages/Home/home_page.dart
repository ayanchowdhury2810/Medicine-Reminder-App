import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/components/text_widget.dart';
import 'package:medicine_reminder_app/constants.dart';
import 'package:medicine_reminder_app/data/DataManager.dart';
import 'package:medicine_reminder_app/models/medicine_info_model.dart';
import 'package:medicine_reminder_app/pages/Home/bloc/home_page_bloc.dart';
import 'package:medicine_reminder_app/pages/Home/bloc/home_page_event.dart';
import 'package:medicine_reminder_app/pages/Home/bloc/home_page_state.dart';
import 'package:medicine_reminder_app/routes/routes_name.dart';
import 'package:sizer/sizer.dart';

import '../../data/medicine_records.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageBloc homePageBloc = HomePageBloc();
  final DataManager dataManager = DataManager();

  @override
  void initState() {
    super.initState();
    print("size ---> ${medicineRecords.length}");
    print("data ---> ${medicineRecords}");
    homePageBloc.add(HomePageInitialEvent());
  }

  @override
  void dispose() {
    print("size ---> ${medicineRecords.length}");
    print("data ---> ${medicineRecords}");
    super.dispose();
  }

  Future<List<MedicineInfoModel>> _getDataa() async {
    final data = await dataManager.getReminderList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<HomePageBloc, HomePageState>(
          bloc: homePageBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomePageSuccessState) {
              return Column(
                children: [
                  TextContainer(
                    sizeOfList: state.medicineInfoList.length,
                  ),
                  SizedBox(height: 2.h),
                  state.medicineInfoList.isEmpty
                      ? const Flexible(child: BottomContainer())
                      : Flexible(
                          child: GridView.builder(
                            itemCount: state.medicineInfoList.length,
                            padding: EdgeInsets.only(
                                left: 2.h, right: 2.h, top: 2.h, bottom: 2.h),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 2.gitin0,
                                    childAspectRatio: 0.9),
                            itemBuilder: (context, index) {
                              return MedicineInfoGrid(
                                  medicineInfoModel:
                                      state.medicineInfoList[index],
                                  homePageBloc: homePageBloc);
                            },
                          ),
                        )
                ],
              );
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result =
                await Navigator.pushNamed(context, RoutesName.newEntryScreen);
            print("result --------> $result");
            homePageBloc.add(HomePageInitialEvent());
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: kPrimaryColor,
          ),
        ));
  }
}

class TextContainer extends StatelessWidget {
  final int sizeOfList;

  const TextContainer({super.key, required this.sizeOfList});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: kPrimaryColor),
        child: Padding(
            padding:
                EdgeInsets.only(left: 2.h, right: 2.h, top: 8.h, bottom: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 1.h,
                  ),
                  alignment: Alignment.topLeft,
                  child: const TextWidget(
                    data: "Worry less, \nlive healthier.",
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: const TextWidget(
                    data: 'Welcome to Daily Dose.',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: TextWidget(
                      data: '$sizeOfList',
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ))
              ],
            )));
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: TextWidget(
      data: 'No Medicine',
      textAlign: TextAlign.center,
      color: kPrimaryColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ));
  }
}

class MedicineInfoGrid extends StatefulWidget {
  final MedicineInfoModel medicineInfoModel;
  final HomePageBloc homePageBloc;

  const MedicineInfoGrid(
      {super.key, required this.medicineInfoModel, required this.homePageBloc});

  @override
  State<MedicineInfoGrid> createState() => _MedicineInfoGridState();
}

class _MedicineInfoGridState extends State<MedicineInfoGrid> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(
            context, RoutesName.medicineDetailScreen,
            arguments: widget.medicineInfoModel);

        print("result --------> $result");
        widget.homePageBloc.add(HomePageInitialEvent());
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        widget.medicineInfoModel.medicineType.imagePath,
                      ),
                    ))),
                TextWidget(
                    data: "Name : ${widget.medicineInfoModel.medicine_name}",
                    textAlign: TextAlign.start,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                TextWidget(
                    data: "Dosage : ${widget.medicineInfoModel.dosage}",
                    textAlign: TextAlign.start,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                TextWidget(
                    data:
                        "Medicine Type : ${widget.medicineInfoModel.medicineType.desc}",
                    textAlign: TextAlign.start,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                TextWidget(
                    data:
                        "Start Time : ${widget.medicineInfoModel.startTime.hour}:${widget.medicineInfoModel.startTime.minute}",
                    textAlign: TextAlign.start,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal)
              ],
            ),
          )),
    );
  }
}
