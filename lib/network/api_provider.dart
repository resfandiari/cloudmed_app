import 'dart:io';
import 'package:cloudmed_app/model/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'client_configs.dart';

class ApiProvider {
  ApiProvider({@required this.token, @required this.userID});

  final String token;
  final String userID;
  ClientConfigs _clientConfigs = new ClientConfigs();

  ///change server error code to message
  String changeErrorCodeToMessage(int errorCode) {
    switch (errorCode) {
      case 400:
        return "اشکال در انجام درخواست";
      case 401:
        return "اشکال در تایید هویت";
      case 403:
        return "شما مجوز لازم برای این کار را ندارید.";
      case 404:
        return "این درخواست امکان پذیر نیست.";
      case 406:
        return "اطلاعات وارد شده صحیح نیست.";
      case 301:
        return "ادرس تغییر کرده است.";
      case 0:
        return "مشکل در ارتباط ، لطفا دوباره تلاش کنید";
        break;
    }
    return "مشکل در ارتباط ، لطفا دوباره تلاش کنید";
  }

  ///change exception type to message
  String changeExceptionToMessage(Type typeException) {
    switch (typeException.runtimeType) {
      case SocketException:
        return "سرور قابل دستیابی نیست.لطفا پس از بررسی اتصال اینترنت، دوباره امتحان کنید.";
        break;
    }
    return "اشکال در ارتباط با سرور";
  }

  ///Register user
  ///required [RegisterReq]
  ///response [RegisterRes]
  Future<RegisterRes> register({RegisterReq registerReq}) async {
    Response response;
    try {
      response = await _clientConfigs
          .dio()
          .post('user/register', data: registerReq.toJson());
      print('response.data ${response.data}');
    } catch (e) {
      print(e);
      throw Exception(
          changeErrorCodeToMessage(response != null ? response.statusCode : 0));
    }

    if (response.statusCode == 200) {
      return RegisterRes.fromJson(response.data);
    } else {
      if (response != null && response.statusCode == 401) {
        throw Exception("این مشخصات قبلا ثبت شده است.");
      }
      if (response != null && response.statusCode == 406) {
        throw Exception("شماره وارد شده صحیح نیست.");
      } else if (response != null && response.statusCode == 429) {
        throw Exception(
            "امکان ثبت نام تا 24 ساعت اینده برای شما وجود ندارد.لطفا پس از این زمان دوباره امتحان کنید.");
      } else {
        throw Exception(changeErrorCodeToMessage(
            response != null ? response.statusCode : 0));
      }
    }
  }

  ///Login user
  ///required [LoginReq]
  ///response [LoginRes]
  Future<LoginRes> login({LoginReq loginReq}) async {
    Response response;
    try {
      response = await _clientConfigs
          .dio()
          .post('user/login', data: loginReq.toJson());
      print('response.data ${response.data}');
    } catch (e) {
      print(e);
      throw Exception(
          changeErrorCodeToMessage(response != null ? response.statusCode : 0));
    }

    if (response.statusCode == 200) {
      return LoginRes.fromJson(response.data);
    } else {
      throw Exception(
          changeErrorCodeToMessage(response != null ? response.statusCode : 0));
    }
  }

  ///Logout user
  ///required []
  ///response [LogoutRes]
  Future<LogoutRes> logout() async {
    Response response;
    try {
      response = await _clientConfigs.dio(token: token).get('user/logout');
      print('response.data ${response.data}');
    } catch (e) {
      print(e);
      throw Exception(
          changeErrorCodeToMessage(response != null ? response.statusCode : 0));
    }

    if (response.statusCode == 200) {
      return LogoutRes.fromJson(response.data);
    } else {
      throw Exception(
          changeErrorCodeToMessage(response != null ? response.statusCode : 0));
    }
  }
}
