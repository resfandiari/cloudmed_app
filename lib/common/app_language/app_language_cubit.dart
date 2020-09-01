import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<Locale> {
  AppLanguageCubit() : super(Locale("fa")) {
    fetchLocale();
  }

  /// current language
  Locale _appLocale;
  Locale get appLocale => _appLocale;

  /// get app saved language (default : FA)
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('fa');
      emit(_appLocale);
      return;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    emit(_appLocale);
    return;
  }

  /// change language between FA and EN.
  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("en")) {
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');

      _appLocale = Locale("en");
      emit(_appLocale);
      return;
    } else {
      await prefs.setString('language_code', 'fa');
      await prefs.setString('countryCode', 'IR');

      _appLocale = Locale("fa");
      emit(Locale("fa"));
      return;
    }
  }
}
