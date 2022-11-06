import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import 'package:plants_orange/style/colors.dart';

var emailController = TextEditingController();
var addressController = TextEditingController();
var formController = GlobalKey<FormState>();

class UpdateEmailScreen extends StatelessWidget {
  const UpdateEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        emailController.text =
        PlantsCubit.get(context).userModel!.data!.email!;
        addressController.text =
        PlantsCubit.get(context).userModel!.data!.address!;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Update Email',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,

          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 80.h, right: 20.w, left: 20.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Email',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFF6F6F6F),
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: emailController,
                        cursorColor: const Color(0xFF939393),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter email";
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        decoration: InputDecoration(
                          isDense: true, // important line
                          contentPadding:
                          EdgeInsets.fromLTRB(10.w, 28.h, 10.w, 0.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(
                              style: BorderStyle.solid,
                              color: Color(0xFF939393),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF1ABC00),
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      Text('Address',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFF6F6F6F),
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: addressController,
                        cursorColor: const Color(0xFF939393),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter address";
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        decoration: InputDecoration(
                          isDense: true, // important line
                          contentPadding:
                          EdgeInsets.fromLTRB(10.w, 28.h, 10.w, 0.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(
                              style: BorderStyle.solid,
                              color: Color(0xFF939393),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF1ABC00),
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      (state is UserLoadingState)
                          ? Center(
                          child: CircularProgressIndicator(
                            color: PrimaryGreen,
                          ))
                          : Container(
                        width: double.infinity,
                        height: 55.h,
                        decoration: BoxDecoration(
                          color: PrimaryGreen,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (formController.currentState!.validate()) {
                              PlantsCubit.get(context).updateUserEmail(
                                  email:  emailController.text,
                                  address: addressController.text);
                            }
                          },
                          child: Text(
                            'Update',
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
              ),
            ),
          ),
        );
      },
    );
  }
}
