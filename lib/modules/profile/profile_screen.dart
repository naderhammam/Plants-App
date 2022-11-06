import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import 'package:plants_orange/modules/profile/update_email_screen.dart';
import 'package:plants_orange/modules/profile/update_name_screen.dart';

import '../posts/posts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubitUser = PlantsCubit.get(context).userModel;
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  height: height * 0.40,
                  width: double.maxFinite,
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image:
                          // ExactAssetImage("assets/images/close-up-young.jpg"),
                      NetworkImage( '${cubitUser!.data!.imageUrl}'),

                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7,),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.65),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 14.w, top: 45.h),
                                  child: const Icon(
                                    Icons.more_horiz_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage( '${cubitUser.data!.imageUrl}'),
                                  // const AssetImage(
                                  //     "assets/images/close-up-young.jpg"),
                              radius: 80.w,
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            Text(
                              "${cubitUser.data!.firstName} ${cubitUser.data!.lastName}",
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: height * 0.67,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  right: 24.w,
                  left: 24.w,
                  top: 32.h,
                  bottom: 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80.h,
                      color: const Color(0xFFF3FEF1),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          CircleAvatar(
                            backgroundColor: const Color(0xFFF3FEF1),
                            child: SvgPicture.asset(
                                'assets/icons/Profile_bonus.svg'),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Text('You have ${cubitUser.data!.userPoints} points',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text('Edit Profile',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        )),
                    SizedBox(
                      height: 25.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UpdateNameScreen()));
                      },
                      child: Container(
                        height: 85.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0)
                            ]),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                  'assets/icons/iconChangeName.svg'),
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Text('Change Name',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                )),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: const Icon(
                                Icons.arrow_forward_sharp,
                                color: Color(0xff1D592C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UpdateEmailScreen()));
                      },
                      child: Container(
                        height: 85.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0)
                            ]),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                  'assets/icons/iconChangeName.svg'),
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Text('Change Email',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                )),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: const Icon(
                                Icons.arrow_forward_sharp,
                                color: Color(0xff1D592C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PostsScreen()));
                      },
                      child: Container(
                        height: 85.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0)
                            ]),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                  'assets/icons/iconChangeName.svg'),
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Text('Posts',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                )),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: const Icon(
                                Icons.arrow_forward_sharp,
                                color: Color(0xff1D592C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
