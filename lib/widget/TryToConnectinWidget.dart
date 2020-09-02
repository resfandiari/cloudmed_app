import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TryToConnectionWidget {
  final String error;
  final VoidCallback clickCallBack;
  final BuildContext context;

  TryToConnectionWidget(
      {@required this.error,
      @required this.clickCallBack,
      @required this.context});

  Widget get() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(error,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: getThemeBrightness()
                          ? Colors.black87
                          : Colors.white)),
              SizedBox(height: 10),
              MaterialButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    AppLocalizations.of(context).translate("try_again"),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(36),
                        color: getThemeBrightness()
                            ? Colors.white
                            : Colors.black87),
                  ),
                  onPressed: () => clickCallBack(),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  elevation: 2,
                  highlightElevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))
            ]),
      ),
    );
  }

  bool getThemeBrightness() {
    return ThemeProvider.of(context).brightness == Brightness.light
        ? true
        : false;
  }
}
