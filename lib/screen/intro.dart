import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:cloudmed_app/common/constants.dart';
import 'package:cloudmed_app/extention/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login.dart';

class Intro extends StatefulWidget {
  final String version;
  Intro({this.version});

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
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
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context).translate("name_app"),
                  style: TextStyle(
                      color:
                          getThemeBrightness() ? Colors.white : Colors.black87,
                      fontFamily: "YekanB",
                      fontSize: 38),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4, bottom: 12, left: 12, right: 12),
                  child: Text(
                    "ما به شما کمک می کنیم تا بهترین تجارب و \n ماجراها را پیدا کنید",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "YekanB",
                      fontStyle: FontStyle.normal,
                      color:
                          getThemeBrightness() ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () => _navigateToLogin(),
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "همین حالا شروع کن",
                      style: TextStyle(
                          fontFamily: "YekanB",
                          fontStyle: FontStyle.normal,
                          color: getThemeBrightness()
                              ? Colors.black87
                              : Colors.white),
                    ),
                  ),
                  // color: Constants.lightPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  clipBehavior: Clip.antiAlias, // Add This
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 4, left: 12, right: 12),
                    child: Text(
                      "قبلا ثبت نام کرده ام!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "YekanB",
                        fontStyle: FontStyle.normal,
                        color: getThemeBrightness()
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, bottom: 10, left: 12, right: 12),
                  child: Text(
                    "نسخه ${widget.version}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          getThemeBrightness() ? Colors.white : Colors.black87,
                      fontSize: 14,
                      fontFamily: "YekanB",
                    ),
                  ),
                ),
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

  ///navigate to login page for registering
  _navigateToLogin() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          return Login();
        }));
      });
    });
  }
}
