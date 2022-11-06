import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/login_model.dart';
import '../shared/component.dart';
import 'cache_helper.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://lavie.orangedigitalcenteregypt.com',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      String? lang = 'en',
      String? token,
      dynamic data}) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      String? lang = 'en',
      String? token,
      required dynamic data}) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> patchData(
      {required String url,
      Map<String, dynamic>? query,
      String? lang = 'en',
      String? token,
      required dynamic data}) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio!.patch(
      url,
      queryParameters: query,
      data: data,
    );
  }
}

class DioExceptions implements Exception {
  String? message;

  LoginModel? loginModel;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = dioError.response?.data['message'];

        // this comment is login
        if (message == 'Token expired') {
          DioHelper.postData(url: '/api/v1/auth/refresh', data: {
            'refreshToken': loginModel!.data!.refreshToken,
          }).then((value) {
            loginModel = LoginModel.fromJson(value.data);
            CacheHelper.saveData(
                key: "token", value: loginModel!.data!.accessToken);
            CacheHelper.saveData(
                key: "refreshToken", value: loginModel!.data!.refreshToken);
            accessToken = CacheHelper.getData(key: "token");
            refreshToken = CacheHelper.getData(key: "refreshToken");
          }).catchError((onError) {
            if (onError is DioError) {
              final errorMessage =
                  DioExceptions.fromDioError(onError).toString();
              Fluttertoast.showToast(
                  msg: errorMessage,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          });
        }

        //     _handleError(
        //   dioError.response?.statusCode,
        //   dioError.response?.data,
        // );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message'];
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toStringgg() => message ?? '';
}
