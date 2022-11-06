import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';

import '../../shared/component.dart';
import '../../style/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var carts = PlantsCubit.get(context).newTasks;

        if (state is LoadingCirclarCubit) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                title: Text('My Cart',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    )),
              ),
              body:  Center(
                child: CupertinoActivityIndicator(
                  color: PrimaryGreen,
                  radius: 20.r,
                ),
              ));
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: Text('My Cart',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                )),
          ),
          body: (carts.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/NotFound.png'),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text('Your cart is empty',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff212121),
                          )),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                          textAlign: TextAlign.center,
                          'Sorry, the keyword you entered cannot be\nfound, please check again or search with\n another keyword.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: 160.h,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    top: 16.h,
                    right: 30.w,
                    left: 30.w,
                    bottom: 55.h,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildCartsItem(carts[index], context),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.h,
                          ),
                          itemCount: carts.length,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '180,000',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              color: PrimaryGreen,
                            ),
                          ),
                          Text(
                            ' Egp',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: PrimaryGreen,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: PrimaryGreen,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'Checkout',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
