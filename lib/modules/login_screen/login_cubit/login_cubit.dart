import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plants_orange/models/google_model.dart';
import 'package:plants_orange/modules/login_screen/login_cubit/login_states.dart';
import 'package:plants_orange/shared/component.dart';
import '../../../models/login_model.dart';
import '../../../network/cache_helper.dart';
import '../../../network/dio_helper.dart';
import '../../../shared/constant.dart';
import '../login_screen.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN_URL, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.data!.user!.email);

      CacheHelper.saveData(key: 'token', value: loginModel!.data!.accessToken)
          .then((value) {
        accessToken = loginModel!.data!.accessToken!;
      });
      CacheHelper.saveData(
              key: "refreshToken", value: loginModel!.data!.refreshToken)
          .then((value) {
        refreshToken = loginModel!.data!.refreshToken!;
      });
      emit(LoginSuccessState(loginModel!));
    }).onError((error, stackTrace) {
      if (error is DioError) {
        emit(LoginErrorState(error: error.response!.data['message']));
      } else {
        emit(LoginErrorState(error: error.toString()));
      }
    });
  }

  void userRegister({
    required String fName,
    required String lName,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER_URL,
      data: {
        "firstName": fName,
        "lastName": lName,
        "email": email,
        "password": password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((onError) {
      emit(RegisterErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  Future signIn() async {
    await GoogleSign.login().then((value) {
      emit(SuccessGoogleToken());
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorGoogleToken());
    });
  }

  bool isLogin = true;

  void pressLogin() {
    isLogin = true;
    emit(pressLoginState());
  }

  void pressRegister() {
    isLogin = false;
    emit(pressSignUpState());
  }

  bool isPass = true;
  IconData icon = Icons.visibility_outlined;

  void changeVisibilityPass() {
    isPass = !isPass;
    icon = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePassVisibilityState());
  }

  LoginModel? loginGoogleModel;
  GoogleModel? googleModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<String?> signInWithGoogle() async {
    emit(LoadingSignInGoogle());
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential _credential = await _auth.signInWithCredential(credential);
      print('gggggggggggggggggggggggggggggggggggggggg');

      print(_credential.user!.displayName!.split(' ')[0]);
      DioHelper.postData(url: GOOGLE_SIGN, data: {
        "id": _credential.user!.uid,
        "email": _credential.user!.email,
        "firstName": _credential.user!.displayName!.split(' ')[0],
        "lastName": _credential.user!.displayName!.split(' ')[1],
        "picture": _credential.user!.photoURL,
      }).then((value) {
        loginGoogleModel = LoginModel.fromJson(value.data);
        log(value.data.toString());
        emit(SuccessSignInGoogle(loginGoogleModel!));
      }).onError((error, stackTrace) {
        print(error.toString());
        emit(ErrorSignInGoogle(error: error.toString()));
      });

      //    userRegister(
      //      fName: _credential.user!.displayName!.split(' ')[0],
      //      lName: _credential.user!.displayName!.split(' ')[1],
      //      email: _credential.user!.email!,
      //      password: '0111141515PP',
      //    );

      //   emit(SuccessSignInGoogle());

    } on FirebaseAuthException catch (e) {
      print(e.message);
      emit(ErrorSignInGoogle(error: e.message!));
      rethrow;
    }
  }


  Future<void> signOutFromGoogle(context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}

class GoogleSign {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

class Resource {
  final Status status;

  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }

enum LoginType { Google, Twitter, Facebook }
