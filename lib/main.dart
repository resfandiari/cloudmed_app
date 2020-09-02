import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloudmed_app/common/constants.dart';
import 'package:cloudmed_app/common/theme_config.dart';
import 'package:cloudmed_app/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'bloc/simple_bloc_observer.dart';
import 'common/app_localizations.dart';
import 'common/app_language/app_language_cubit.dart';
import 'common/app_theme/app_theme_cubit.dart';

void main() {
  //need to access the binary messenger before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  //init Bloc delegate
  Bloc.observer = SimpleBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AppLanguageCubit(),
      ),
      BlocProvider(
        create: (_) => AppThemeCubit(),
      )
    ],
    child: RestartWidget(
      child: MyApp(),
    ),
  ));
}

///Restart whole app
class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLanguageCubit, Locale>(
      builder: (context, local) {
        return BlocBuilder<AppThemeCubit, bool>(
          builder: (context, isDark) {
            return ThemeProvider(
                initTheme: isDark ? darkTheme : lightTheme,
                child: Builder(builder: (context) {
                  return MaterialApp(
                    locale: local,
                    title: local.languageCode.compareTo("en") == 0
                        ? Constants.appNameEN
                        : Constants.appNameFA,
                    theme: ThemeProvider.of(context),
                    supportedLocales: [
                      Locale('en', 'US'),
                      Locale('fa', 'IR'),
                    ],
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    debugShowCheckedModeBanner: false,
                    home: Prerequisite(),
                  );
                }));
          },
        );
      },
    );
  }
}

//prerequisite module for app
class Prerequisite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //set device run only in portrait screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ///Set the fit size
    ScreenUtil.init(context);

    return Splash();
  }
}
