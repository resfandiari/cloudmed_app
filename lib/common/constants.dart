import 'package:flutter/material.dart';

class Constants {
  static const String SERVER = "https://clinic.cloudmed.ir/API7_v2/public/api/";

  //App related strings
  static String appNameEN = "Cloud Medical";
  static String appNameFA = "ابر پزشکی";

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}
