import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<bool> {
  AppThemeCubit() : super(false) {
    fetchTheme();
  }

  /// current Theme
  bool _isDark = false;
  bool get isDark => _isDark;

  /// get app saved Theme (default : light)
  fetchTheme() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('theme_select') == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

      _isDark = isPlatformDark;
      emit(_isDark);
      return;
    }
    _isDark = prefs.getBool('theme_select');
    emit(_isDark);
    return;
  }

  /// change Theme between FA and EN.
  void changeTheme(bool dark, VoidCallback callback) async {
    if (_isDark == dark) {
      return;
    }
    var prefs = await SharedPreferences.getInstance();
    _isDark = dark;
    await prefs.setBool('theme_select', dark).then((value) => callback.call());
    return;
  }
}
