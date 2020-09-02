import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloudmed_app/bloc/post/post.dart';
import 'package:cloudmed_app/common/app_language/app_language_cubit.dart';
import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:cloudmed_app/network/network.dart';
import 'package:cloudmed_app/widget/BaseAppBar.dart';
import 'package:cloudmed_app/widget/SliverFooter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'home.dart';

class App extends StatefulWidget {
  String token;
  String userId;

  App({@required this.token, @required this.userId});
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin<App> {
  Repository _repo;
  List<DrawerItem> _drawerItem;
  ProgressDialog pr;

  @override
  void initState() {
    ///config repo
    _repo = new Repository(
        apiProvider:
            new ApiProvider(token: widget.token, userID: widget.userId));

    super.initState();

    ///drawer item
    _drawerItem = [
      DrawerItem(id: 0, name: "logout", icon: FontAwesomeIcons.signOutAlt),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///config dialog
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false,
        textDirection: TextDirection.rtl);
    pr.style(message: "در حال ارسال...", textAlign: TextAlign.start);

    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
        ),
        body: SafeArea(
          top: false,
          child: MultiBlocProvider(providers: [
            BlocProvider<PostListBloc>(
                create: (context) => PostListBloc(_repo)),
          ], child: Home(_repo)),
        ),
        drawer: Drawer(
          child: new CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                DrawerHeader(
                  margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
                  padding: EdgeInsets.zero,
                  child: SizedBox.shrink(),
                  decoration: BoxDecoration(
                      color: getThemeBrightness()
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      image: DecorationImage(
                          image: AssetImage("assets/icons/app_ic.png"),
                          fit: BoxFit.contain)),
                )
              ])),
              new SliverFixedExtentList(
                itemExtent: 48,
                delegate: new SliverChildBuilderDelegate((context, index) {
                  return new SizedBox.expand(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onDrawerClick(index);
                      },
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              _drawerItem[index].icon,
                              size: 18,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate(_drawerItem[index].name),
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(36),
                                fontFamily: "VazirB",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }, childCount: _drawerItem.length),
              ),
              new SliverFooter(
                child: new Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);

                      context
                                  .bloc<AppLanguageCubit>()
                                  .appLocale
                                  .languageCode
                                  .compareTo("en") ==
                              0
                          ? context
                              .bloc<AppLanguageCubit>()
                              .changeLanguage(Locale("fa"))
                          : context
                              .bloc<AppLanguageCubit>()
                              .changeLanguage(Locale("en"));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4, left: 4, right: 4, top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              FontAwesomeIcons.language,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("app_lang"),
                              style: TextStyle(
                                  fontFamily: "VazirM",
                                  fontSize: ScreenUtil().setSp(36),
                                  color: getThemeBrightness()
                                      ? Colors.black87
                                      : Colors.white),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            CircleAvatar(
                              backgroundColor: Theme.of(context).accentColor,
                              child: Image.asset(
                                context
                                            .bloc<AppLanguageCubit>()
                                            .appLocale
                                            .languageCode
                                            .compareTo("en") ==
                                        0
                                    ? "assets/images/iran_flag.png"
                                    : "assets/images/uk_flag.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///get theme property
  bool getThemeBrightness() {
    return context.bloc<AppThemeCubit>().isDark;
  }

  ///handle click on drawer item
  void onDrawerClick(int index) {
    switch (index) {
      case 0:
        _logout();
        break;
      default:
        break;
    }
  }

  ///logout user
  _logout() async {
    await pr.show();
    _repo.logout().then((value) {
      print('print then $value');
      if (pr.isShowing()) {
        pr.hide();
      }
      _removeUserInfo();
    }).catchError((e) {
      if (pr.isShowing()) {
        pr.hide();
      }
      Flushbar(
        title: "متاسفیم!",
        message: e.toString().contains('Exception:')
            ? e.toString().replaceAll('Exception:', "")
            : e.toString(),
        duration: Duration(seconds: 2),
      )..show(context);
      print('print catchError $e');
    });
  }

  ///remove user information and rest whole app
  _removeUserInfo() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.clear().then((value) => RestartWidget.restartApp(context));
    });
  }
}

class DrawerItem {
  final int id;
  final String name;
  final IconData icon;

  DrawerItem({this.id, this.name, this.icon});
}
