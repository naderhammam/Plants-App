import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import '../modules/home_screen/home_cubit/plants_cubit.dart';
import '../style/colors.dart';

class PlantsLayout extends StatelessWidget {
  const PlantsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = PlantsCubit.get(context);

    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          // floatingActionButton: BlocConsumer<LoginCubit, LoginState>(
          //   listener: (context, state) {
          //     // TODO: implement listener
          //   },
          //   builder: (context, state) {
          //     return FloatingActionButton(
          //       onPressed: () async {
          //         LoginCubit.get(context).signOutFromGoogle(context);
          //       },
          //       child: const Icon(Icons.add),
          //     );
          //   },
          // ),
          extendBodyBehindAppBar: true,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            items: [
              cubit.currentIndex == 0
                  ? SvgPicture.asset(
                      'assets/icons/leave .svg',
                      color: Colors.white,
                      height: 30.h,
                      width: 30.h,
                    )
                  : SvgPicture.asset(
                      'assets/icons/leave .svg',
                    ),
              cubit.currentIndex == 1
                  ? SvgPicture.asset(
                      'assets/icons/qr-code.svg',
                      color: Colors.white,
                    )
                  : SvgPicture.asset(
                      'assets/icons/qr-code.svg',
                    ),
              cubit.currentIndex == 2
                  ? SvgPicture.asset(
                      'assets/icons/Home.svg',
                      color: Colors.white,
                      height: 30.h,
                      width: 30.h,
                    )
                  : SvgPicture.asset(
                      'assets/icons/Home.svg',
                      color: Colors.black,
                    ),
              cubit.currentIndex == 3
                  ? SvgPicture.asset(
                      'assets/icons/all_notification.svg',
                      color: Colors.white,
                      height: 30.h,
                      width: 30.h,
                    )
                  : SvgPicture.asset(
                      'assets/icons/all_notification.svg',
                    ),
              cubit.currentIndex == 4
                  ? SvgPicture.asset(
                      'assets/icons/person.svg',
                      color: Colors.white,
                      height: 27.h,
                      width: 27.h,
                    )
                  : SvgPicture.asset(
                      'assets/icons/person.svg',
                    ),
            ],
            index: cubit.currentIndex,
            buttonBackgroundColor: PrimaryGreen,
            backgroundColor: Colors.transparent,
            color: Colors.white,
            animationDuration: const Duration(milliseconds: 500),
            height: 62.h,
            animationCurve: Curves.easeInOut,
            onTap: (index) {
              cubit.changeScreen(index);
            },
          ),
        );
      },
    );
  }
}
