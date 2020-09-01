import 'dart:io';
import 'package:flutter/material.dart';
import 'client_configs.dart';

class ApiProvider {
  ApiProvider({@required this.token, @required this.userID});

  final String token;
  final String userID;
  ClientConfigs _clientConfigs = new ClientConfigs();

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

  String changeExceptionToMessage(Type typeException) {
    switch (typeException.runtimeType) {
      case SocketException:
        return "سرور قابل دستیابی نیست.لطفا پس از بررسی اتصال اینترنت، دوباره امتحان کنید.";
        break;
    }
    return "اشکال در ارتباط با سرور";
  }
}
