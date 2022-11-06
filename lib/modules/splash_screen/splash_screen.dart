import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plants_orange/layout/plants_layout.dart';
import 'package:plants_orange/shared/component.dart';

import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1700), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  (accessToken != null) ? const PlantsLayout() : const LoginScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
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
      ),
    );
  }
}
