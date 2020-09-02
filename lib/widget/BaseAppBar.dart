import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloudmed_app/common/app_language/app_language_cubit.dart';
import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:cloudmed_app/common/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final AppBar appBar;
  final PreferredSizeWidget bottom;

  const BaseAppBar({Key key, this.appBar, this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).translate("name_app"),
        style:
            TextStyle(fontSize: ScreenUtil().setSp(44), fontFamily: "YekanB"),
      ),
      centerTitle: true,
      actions: <Widget>[
        ThemeSwitcher(
          builder: (context) {
            return IconButton(
              onPressed: () => context
                  .bloc<AppThemeCubit>()
                  .changeTheme(!context.bloc<AppThemeCubit>().isDark, () {
                ThemeSwitcher.of(context).changeTheme(
                  theme:
                      ThemeProvider.of(context).brightness == Brightness.light
                          ? darkTheme
                          : lightTheme,
                );
              }),
              icon: Icon(
                ThemeProvider.of(context).brightness == Brightness.light
                    ? Icons.brightness_3
                    : Icons.flare,
                size: 25,
              ),
            );
          },
        ),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
