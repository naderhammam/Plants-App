import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plants_orange/layout/plants_layout.dart';
import 'package:plants_orange/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:plants_orange/modules/login_screen/login_cubit/login_states.dart';
import 'package:plants_orange/shared/component.dart';

import '../../network/cache_helper.dart';
import '../../style/colors.dart';

var emailControllerLogin = TextEditingController();
var passwordControllerLogin = TextEditingController();
var emailControllerRegister = TextEditingController();
var passwordControllerRegister = TextEditingController();
var confirmPasswordControllerRegister = TextEditingController();
var fNameController = TextEditingController();
var lNameController = TextEditingController();
var formController = GlobalKey<FormState>();
bool isLoading = false;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.type == 'Success') {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.accessToken)
                .then((value) {
              accessToken = state.loginModel.data!.accessToken;
              CacheHelper.saveData(
                      key: "refreshToken",
                      value: state.loginModel.data!.refreshToken)
                  .then((value) {
                refreshToken = state.loginModel.data!.refreshToken!;
              });
              Fluttertoast.showToast(
                  msg: 'Welcome To La Vie 🤍',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlantsLayout(),
                  ),
                  (route) => false);
            });
          } else {
            Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        if (state is SuccessSignInGoogle) {
          if (state.loginModel.type == 'Success') {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.accessToken)
                .then((value) {
              accessToken = state.loginModel.data!.accessToken;
              CacheHelper.saveData(
                      key: "refreshToken",
                      value: state.loginModel.data!.refreshToken)
                  .then((value) {
                refreshToken = state.loginModel.data!.refreshToken!;
              });
              Fluttertoast.showToast(
                  msg: 'Welcome To La Vie 🤍',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlantsLayout(),
                  ),
                  (route) => false);
            });
          } else {
            Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        if (state is LoginErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is RegisterSuccessState) {
          if (state.model.type == 'Success') {
            CacheHelper.saveData(
                    key: 'token', value: state.model.data!.accessToken)
                .then((value) {
              accessToken = state.model.data!.accessToken;
              CacheHelper.saveData(
                      key: "refreshToken",
                      value: state.model.data!.refreshToken)
                  .then((value) {
                refreshToken = state.model.data!.refreshToken!;
              });
              Fluttertoast.showToast(
                  msg: 'Welcome To La Vie 🤍',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlantsLayout(),
                  ),
                  (route) => false);
            });
          } else {
            Fluttertoast.showToast(
                msg: state.model.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        if (state is RegisterErrorState) {
          Fluttertoast.showToast(
              msg: 'There is already an account',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 169.h,
                      width: 190.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.topRight,
                          image: AssetImage(
                            'assets/images/image 68 (Traced).png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
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
                  SizedBox(
                    height: 74.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginCubit.get(context).isLogin
                          ? Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      LoginCubit.get(context).pressRegister();
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp,
                                        color: const Color(0xFF8A8A8A),
                                      ),
                                    )),
                                Container(
                                  height: 3.h,
                                  width: 76.w,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: PrimaryGreen,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 3.h,
                                  width: 76.w,
                                  color: PrimaryGreen,
                                )
                              ],
                            ),
                      SizedBox(
                        width: 114.w,
                      ),
                      LoginCubit.get(context).isLogin
                          ? Column(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: PrimaryGreen,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 3.h,
                                  width: 60.w,
                                  color: PrimaryGreen,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      LoginCubit.get(context).pressLogin();
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp,
                                        color: const Color(0xFF8A8A8A),
                                      ),
                                    )),
                                Container(
                                  height: 3.h,
                                  width: 60.w,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                )
                              ],
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 56.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 46.w, left: 45.w),
                      child: LoginCubit.get(context).isLogin
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  controller: emailControllerLogin,
                                  cursorColor: const Color(0xFF939393),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your email";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true, // important line
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.w, 28.h, 10.w, 0.h),
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
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 23.h,
                                ),
                                Text('Password',
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
                                  obscureText: true,
                                  controller: passwordControllerLogin,
                                  cursorColor: const Color(0xFF939393),
                                  onFieldSubmitted: (value) {
                                    if (formController.currentState!
                                        .validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailControllerLogin.text,
                                          password:
                                              passwordControllerLogin.text);
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your password";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true, // important line
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.w, 28.h, 10.w, 0.h),
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
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 37.h,
                                ),
                                (state is LoginLoadingState)
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: PrimaryGreen,
                                      ))
                                    : Container(
                                        width: double.infinity,
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          color: PrimaryGreen,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (formController.currentState!
                                                .validate()) {
                                              LoginCubit.get(context).userLogin(
                                                  email:
                                                      emailControllerLogin.text,
                                                  password:
                                                      passwordControllerLogin
                                                          .text);
                                            }
                                          },
                                          child: Text(
                                            'Login',
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
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('First Name',
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
                                            controller: fNameController,
                                            cursorColor:
                                                const Color(0xFF939393),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "please enter your first name";
                                              }
                                              return null;
                                            },
                                            style: const TextStyle(
                                              fontFamily: 'Roboto',
                                            ),
                                            decoration: InputDecoration(
                                              isDense: true, // important line
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10.w, 28.h, 10.w, 0.h),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                borderSide: const BorderSide(
                                                  style: BorderStyle.solid,
                                                  color: Color(0xFF939393),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF1ABC00),
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                            ),
                                            keyboardType: TextInputType.name,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 17.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Last Name',
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
                                            controller: lNameController,
                                            cursorColor:
                                                const Color(0xFF939393),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "please enter your last name";
                                              }
                                              return null;
                                            },
                                            style: const TextStyle(
                                              fontFamily: 'Roboto',
                                            ),
                                            decoration: InputDecoration(
                                              isDense: true, // important line
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10.w, 28.h, 10.w, 0.h),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                borderSide: const BorderSide(
                                                  style: BorderStyle.solid,
                                                  color: Color(0xFF939393),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF1ABC00),
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                            ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
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
                                  controller: emailControllerRegister,
                                  cursorColor: const Color(0xFF939393),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your email";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true, // important line
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.w, 28.h, 10.w, 0.h),
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
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                Text('Password',
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
                                  obscureText: true,
                                  controller: passwordControllerRegister,
                                  cursorColor: const Color(0xFF939393),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your password";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true, // important line
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.w, 28.h, 10.w, 0.h),
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
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                Text('Confirm password',
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
                                  obscureText: true,
                                  onFieldSubmitted: (value) {
                                    if (formController.currentState!
                                        .validate()) {
                                      LoginCubit.get(context).userRegister(
                                          fName: fNameController.text,
                                          lName: lNameController.text,
                                          email: emailControllerRegister.text,
                                          password:
                                              passwordControllerRegister.text);
                                    }
                                  },
                                  controller: confirmPasswordControllerRegister,
                                  cursorColor: const Color(0xFF939393),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your confirm password";
                                    }
                                    if (value !=
                                        passwordControllerRegister.text) {
                                      return "password not match";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true, // important line
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.w, 28.h, 10.w, 0.h),
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
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 37.h,
                                ),
                                (state is RegisterLoadingState)
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: PrimaryGreen,
                                      ))
                                    : Container(
                                        width: double.infinity,
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          color: PrimaryGreen,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (formController.currentState!
                                                .validate()) {
                                              LoginCubit.get(context).userRegister(
                                                  fName: fNameController.text,
                                                  lName: lNameController.text,
                                                  email: emailControllerRegister
                                                      .text,
                                                  password:
                                                      passwordControllerRegister
                                                          .text);
                                            }
                                          },
                                          child: Text(
                                            'Login',
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
                            )),
                  SizedBox(
                    height: 28.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 46.w, left: 45.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xff979797),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'or continue with',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.sp,
                            color: const Color(0xff979797),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xff979797),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 46.w, left: 45.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            height: 50.h,
                            width: 53.w,
                            color: Colors.white,
                            child: Image.asset('assets/images/Group 4.png'),
                          ),
                          onTap: () async {
                            try {
                              LoginCubit.get(context).signInWithGoogle();
                            } catch (e) {
                              if (e is FirebaseAuthException) {
                                Fluttertoast.showToast(
                                  msg: e.message!,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        InkWell(
                          child: Container(
                            height: 50.h,
                            width: 53.w,
                            color: Colors.white,
                            child: Image.asset('assets/images/Facebook.png'),
                          ),
                          onTap: () {
                            Fluttertoast.showToast(
                              msg: 'وربنا سيرفرات الفيس كانت واقعة امبارح 😂',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 120.h,
                      width: 190.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.topLeft,
                          image: AssetImage(
                            'assets/images/image 68 (Traced) (2).png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
