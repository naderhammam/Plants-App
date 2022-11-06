import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/constant.dart';

class DetailsBlocsScreen extends StatelessWidget {
  dynamic data;

  DetailsBlocsScreen({this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('$BASE_URL${data.imageUrl}',
              height: 300.h,
              width: double.infinity,fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/ex_plant.png',
              width: double.infinity,
              height: 300.h,
            );
          }, loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null
                ? child
                : const Center(
                    child: CupertinoActivityIndicator(),
                  );
          }),
          SizedBox(
            height: 37.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data!.name,
                    style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    data.description,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Roboto',
                      height: 1.6.h,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff7D7B7B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
