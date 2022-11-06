import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';

import '../style/colors.dart';

String? accessToken = '';
String? refreshToken = '';

bool? isTimerWorking = false;

Widget buildCartsItem(model, context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.r),
    ),
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
                // 'https://assets.reedpopcdn.com/sonic-the-hedgehog-movie-reveals-less-awful-design-1573557005841.jpg/BROK/thumbnail/1600x800/format/jpg/quality/80/sonic-the-hedgehog-movie-reveals-less-awful-design-1573557005841.jpg',
                // model.image,
                model['image'],
                fit: BoxFit.cover,
                height: 140.h,
                width: 150.w, errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/ex_plant.png',
                fit: BoxFit.cover,
                width: 150.w,
                height: 140.h,
              );
            }, loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress == null
                  ? child
                  : SizedBox(
                      width: 150.w,
                      height: 140.h,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: PrimaryGreen,
                        ),
                      ),
                    );
            }),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                      //  model.title,
                      model['title'],
                      style: TextStyle(
                        fontSize: 17.sp,
                        height: 1.6.h,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF000000),
                      )),
                ),
                FittedBox(
                  child: Text(
                      //   model.des,
                      model['des'],
                      style: TextStyle(
                        fontSize: 13.sp,
                        height: 1.6.h,
                        fontWeight: FontWeight.w600,
                        color: PrimaryGreen,
                      )),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  children: [
                    Container(
                      height: 36.h,
                      width: 74.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: PrimaryGreen,
                              ),
                            ),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF000000),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: PrimaryGreen,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        PlantsCubit.get(context)
                            .deleteDataBase(id: model['id']);
                      },
                      child: SvgPicture.asset('assets/icons/delete.svg',
                          height: 24.h, width: 20.w),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
