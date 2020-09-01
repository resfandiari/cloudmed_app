import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloudmed_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        final bool _isEN = local.languageCode.compareTo("en") == 0;

        return BlocBuilder<AppThemeCubit, bool>(
          builder: (context, isDark) {
            return ThemeProvider(
                initTheme: isDark
                    ? ThemeData.dark().copyWith(
                        primaryColor: Colors.cyan,
                        textTheme: Theme.of(context)
                            .textTheme
                            .apply(fontFamily: _isEN ? "Flutter" : "Vazir"),
                        primaryTextTheme: Theme.of(context)
                            .textTheme
                            .apply(fontFamily: _isEN ? "Flutter" : "Vazir"),
                        accentTextTheme: Theme.of(context)
                            .textTheme
                            .apply(fontFamily: _isEN ? "Flutter" : "Vazir"))
                    : ThemeData.light().copyWith(
                        primaryColor: Colors.cyan,
                        textTheme: Theme.of(context)
                            .textTheme
                            .apply(fontFamily: _isEN ? "Flutter" : "Vazir"),
                        primaryTextTheme: Theme.of(context)
                            .textTheme
                            .apply(fontFamily: _isEN ? "Flutter" : "Vazir"),
                        accentTextTheme: Theme.of(context)
                            .textTheme
                            .apply(fontFamily: _isEN ? "Flutter" : "Vazir")),
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
                    home: MyHomePage(title: 'Flutter Demo Home Page'),
                  );
                }));
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
