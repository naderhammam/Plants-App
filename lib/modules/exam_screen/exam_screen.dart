import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import 'package:plants_orange/network/cache_helper.dart';
import 'package:plants_orange/shared/component.dart';
import 'package:plants_orange/style/colors.dart';

var currentIndex = 0;
bool isChoose1_1 = false;
bool isChoose2_1 = false;
bool isChoose3_1 = false;

bool isChoose1_2 = false;
bool isChoose2_2 = false;
bool isChoose3_2 = false;

bool isChoose1_3 = false;
bool isChoose2_3 = false;
bool isChoose3_3 = false;
var controllerPage = PageController();

class ExamModel {
  String? number;

  String? question;

  String? answer1;

  String? answer2;

  String? answer3;

  ExamModel({
    this.number,
    this.question,
    this.answer1,
    this.answer2,
    this.answer3,
  });
}

List<dynamic> list = [
  ExamModel(
    number: '1',
    question: 'Which is not a function of the roots?',
    answer1: 'Absorb water',
    answer2: 'Anchor the plant',
    answer3: 'Photosynthesize',
  ),
  ExamModel(
    number: '2',
    question: 'Where does water enter the plant?',
    answer1: 'Root',
    answer2: 'Leaves',
    answer3: 'Stem',
  ),
  ExamModel(
    number: '3',
    question:
        'Water is transported to the leaves where it combines\nwith _____ to form sugar.',
    answer1: 'Oxygen',
    answer2: 'Carbon dioxide',
    answer3: 'Carbon dioxide',
  ),
];

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Course Exam',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 34.w,
          right: 34.w,
          top: 55.h,
        ),
        child: PageView.builder(
          itemBuilder: (context, index) => itemPageView(list[index]),
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          controller: controllerPage,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
            print(index);
          },
        ),
      ),
    );
  }

  Widget itemPageView(ExamModel data) {
    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlantsCubit.get(context);

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('Question',
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: Colors.black)),
                SizedBox(
                  width: 7.w,
                ),
                Text(data.number!,
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: PrimaryGreen)),
                Text('/3',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Roboto',
                      textBaseline: TextBaseline.ideographic,
                      color: Colors.grey,
                    )),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(data.question!,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Roboto',
                    color: const Color(0xFF3A3A3A))),
            SizedBox(
              height: 48.h,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  if (currentIndex == 0) {
                    setState(() {
                      isChoose1_1 = true;
                      isChoose2_1 = false;
                      isChoose3_1 = false;
                    });
                  }
                  if (currentIndex == 1) {
                    setState(() {
                      isChoose1_2 = true;
                      isChoose2_2 = false;
                      isChoose3_2 = false;
                    });
                  }
                  if (currentIndex == 2) {
                    setState(() {
                      isChoose1_3 = true;
                      isChoose2_3 = false;
                      isChoose3_3 = false;
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: PrimaryGreen,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.answer1!,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      if (currentIndex == 0)
                        (isChoose1_1)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                      if (currentIndex == 1)
                        (isChoose1_2)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                      if (currentIndex == 2)
                        (isChoose1_3)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  if (currentIndex == 0) {
                    setState(() {
                      isChoose2_1 = true;
                      isChoose1_1 = false;
                      isChoose3_1 = false;
                    });
                  }
                  if (currentIndex == 1) {
                    setState(() {
                      isChoose2_2 = true;
                      isChoose1_2 = false;
                      isChoose3_2 = false;
                    });
                  }
                  if (currentIndex == 2) {
                    setState(() {
                      isChoose2_3 = true;
                      isChoose1_3 = false;
                      isChoose3_3 = false;
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: PrimaryGreen,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.answer2!,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      if (currentIndex == 0)
                        (isChoose2_1)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                      if (currentIndex == 1)
                        (isChoose2_2)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                      if (currentIndex == 2)
                        (isChoose2_3)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  if (currentIndex == 0) {
                    setState(() {
                      isChoose3_1 = true;
                      isChoose1_1 = false;
                      isChoose2_1 = false;
                    });
                  }
                  if (currentIndex == 1) {
                    setState(() {
                      isChoose3_2 = true;
                      isChoose1_2 = false;
                      isChoose2_2 = false;
                    });
                  }
                  if (currentIndex == 2) {
                    setState(() {
                      isChoose3_3 = true;
                      isChoose1_3 = false;
                      isChoose2_3 = false;
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: PrimaryGreen,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.answer3!,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      if (currentIndex == 0)
                        (isChoose3_1)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                      if (currentIndex == 1)
                        (isChoose3_2)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                      if (currentIndex == 2)
                        (isChoose3_3)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: PrimaryGreen,
                                    size: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/Ellipse 14.svg',
                                    width: 26.w,
                                    height: 26.h,
                                  ),
                                ],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Ellipse 14.svg',
                                width: 26.w,
                                height: 26.h,
                              ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 90.h,
            ),
            if (currentIndex == 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40.h,
                    width: 170.w,
                    decoration: BoxDecoration(
                      color: PrimaryGreen,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        controllerPage.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            if (currentIndex == 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 170.w,
                    child: OutlinedButton(
                      onPressed: () {
                        controllerPage.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: PrimaryGreen,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: PrimaryGreen,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 170.w,
                    decoration: BoxDecoration(
                      color: PrimaryGreen,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        controllerPage.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            if (currentIndex == 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 170.w,
                    child: OutlinedButton(
                      onPressed: () {
                        controllerPage.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: PrimaryGreen,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: PrimaryGreen,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 170.w,
                    decoration: BoxDecoration(
                      color: PrimaryGreen,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        await CacheHelper.saveData(
                                key: 'isTimerWorking', value: true)
                            .then((value) {
                          isTimerWorking = true;
                        });

                        Timer.periodic(const Duration(days: 7), (Timer t) {
                          CacheHelper.saveData(
                                  key: 'isTimerWorking', value: false)
                              .then((value) {
                            isTimerWorking = false;
                            print(
                                '@@@@@@@@@@@@@@@@@@@@@ $isTimerWorking @@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                            cubit.getSeeds();
                            cubit.getPlants();
                            cubit.getTools();
                            cubit.getAll();
                            cubit.getUser();
                          });
                        });
                        Fluttertoast.showToast(
                            msg: 'Well done see you next week 🤍',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0.sp);
                        Navigator.pop(context, 'refresh');
                      },
                      child: Text(
                        'Finish',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
          ],
        );
      },
    );
  }
}
