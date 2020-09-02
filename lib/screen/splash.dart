import 'dart:io';

import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'intro.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  getThemeBrightness()
                      ? Colors.black.withOpacity(0.9)
                      : Colors.white.withOpacity(0.9),
                  BlendMode.srcOver),
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200.h,
                ),
                Image.asset(
                  "assets/icons/app_ic.png",
                  width: ScreenUtil.screenWidth / 1.5,
                ),
                SizedBox(
                  height: 100.h,
                ),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///get theme property
  bool getThemeBrightness() {
    return context.bloc<AppThemeCubit>().isDark;
  }

  ///check internet connection
  _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          _checkLogin();
        }
      } on SocketException catch (_) {
        _tryToConnectServer();
      }
    } else {
      _tryToConnectServer();
    }
  }

  ///dialog for run internet connection checking
  _tryToConnectServer() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: AlertDialog(
            title: Text(
              'متاسفیم',
              style: TextStyle(fontSize: ScreenUtil().setSp(38)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      "اشکال در ارتباط با سرور لطفا ارتباط خود با اینترنت را چک کنید.",
                      style: TextStyle(fontSize: ScreenUtil().setSp(38))),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('سعی دوباره'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _checkConnection();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ///check user registering
  _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs != null &&
        prefs.getString('user.api_token') != null &&
        prefs.getString('user.api_token').length != 0) {
      String _token = prefs.getString('user.api_token');
      String _userID = prefs.getString('user.id');
      _navigateToHome(token: _token, userID: _userID);
    } else
      _navigateToLogin();
  }

  ///navigate to login page for registering
  _navigateToLogin() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.of(context)
              .pushReplacement(new MaterialPageRoute(builder: (context) {
            return Intro(version: packageInfo.version);
          }));
        });
      });
    });
  }

  ///navigate to home page
  _navigateToHome({String token, String userID}) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          return App(token: token, userId: userID);
        }));
      });
    });
  }
}
