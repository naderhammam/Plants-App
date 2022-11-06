import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plants_orange/shared/component.dart';

import '../../style/colors.dart';
import '../cart/cart_screen.dart';
import '../exam_screen/exam_screen.dart';
import '../search/search_screen.dart';
import 'home_cubit/plants_cubit.dart';
import 'home_cubit/plants_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = PlantsCubit.get(context);
        if (cubit.doneSeeds == false ||
            cubit.donePlants == false ||
            cubit.doneTools == false ||
            cubit.doneAll == false ||
            cubit.doneUser == false||
            cubit.doneBlogs == false||
            cubit.doneForums == false||
            cubit.doneMyForums == false) {
          return Center(
            child: CircularProgressIndicator(color: PrimaryGreen),
          );
        }
        var width = MediaQuery.of(context).size.width;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'La Vie',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 27.sp,
                              fontFamily: 'Meddon',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Image.asset(
                              'assets/images/Plant Based Milk.png',
                              height: 17.h,
                              width: 26.w,
                            ),
                          ),
                        ],
                      ),
                      if (isTimerWorking == false)
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.184,
                            right: width * 0.064,
                          ),
                          child: CircleAvatar(
                            radius: 19.r,
                            backgroundColor: PrimaryGreen,
                            child: FittedBox(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  String refresh = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ExamScreen(),
                                    ),
                                  );
                                  if (refresh == 'refresh') {
                                    cubit.getSeeds();
                                    cubit.getPlants();
                                    cubit.getTools();
                                    cubit.getAll();
                                    cubit.getUser();
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.184,
                            right: width * 0.064,
                          ),
                          child: CircleAvatar(
                            radius: 19.r,
                            backgroundColor: Colors.white,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Row(
                  children: [
                    Container(
                      height: 50.h,
                      width: 323.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchScreen()));
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.search_sharp,
                              color: const Color(0xFF979797),
                              size: 27.w,
                            ),
                            SizedBox(width: 13.w),
                            Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF979797),
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: PrimaryGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartScreen()));
                          },
                          child: SvgPicture.asset(
                            'assets/icons/Cart.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 37.h,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      width: 16.w,
                    ),
                    cubit.buttonAll
                        ? OutlinedButton(
                            onPressed: () {
                              cubit.changeButtonAll();
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
                              'All',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: PrimaryGreen,
                                  fontFamily: 'Roboto'),
                            ),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              cubit.changeButtonAll();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xffF8F8F8),
                              ),
                              backgroundColor: const Color(0xffF8F8F8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'All',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF979797),
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                    SizedBox(
                      width: 16.w,
                    ),
                    cubit.buttonPlants
                        ? OutlinedButton(
                            onPressed: () {
                              cubit.changeButtonPlants();
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
                              'Plants',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: PrimaryGreen,
                                  fontFamily: 'Plants'),
                            ),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              cubit.changeButtonPlants();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xffF8F8F8),
                              ),
                              backgroundColor: const Color(0xffF8F8F8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Plants',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF979797),
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                    SizedBox(
                      width: 16.w,
                    ),
                    cubit.buttonSeeds
                        ? OutlinedButton(
                            onPressed: () {
                              cubit.changeButtonSeeds();
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
                              'Seeds',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: PrimaryGreen,
                                  fontFamily: 'Roboto'),
                            ),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              cubit.changeButtonSeeds();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xffF8F8F8),
                              ),
                              backgroundColor: const Color(0xffF8F8F8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Seeds',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF979797),
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                    SizedBox(
                      width: 16.w,
                    ),
                    cubit.buttonTools
                        ? OutlinedButton(
                            onPressed: () {
                              cubit.changeButtonTools();
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
                              'Tools',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: PrimaryGreen,
                                  fontFamily: 'Roboto'),
                            ),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              cubit.changeButtonTools();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xffF8F8F8),
                              ),
                              backgroundColor: const Color(0xffF8F8F8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Tools',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF979797),
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                    SizedBox(
                      width: 16.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.57.h,
                  mainAxisSpacing: 9.w,
                  crossAxisSpacing: 9.h,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: cubit.typeGridView(context)!,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
