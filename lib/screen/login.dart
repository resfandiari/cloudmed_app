import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:cloudmed_app/model/login_req.dart';
import 'package:cloudmed_app/model/login_res.dart';
import 'package:cloudmed_app/network/api_provider.dart';
import 'package:cloudmed_app/network/repository.dart';
import 'package:cloudmed_app/screen/register.dart';
import 'package:cloudmed_app/widget/TextInputCustom.dart';
import 'package:cloudmed_app/widget/dash.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Repository repo;
  ProgressDialog pr;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    repo = new Repository(apiProvider: new ApiProvider());
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 56, bottom: 12),
                child: Image.asset(
                  "assets/icons/app_ic.png",
                  width: 500.w,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Form(
                  key: _formKey,
                  autovalidate: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        TextInputCustom(
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          controller: emailController,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                          maxLines: 1,
                          maxLength: 50,
                          onChanged: (str) {
                            setState(() {
                              _formKey.currentState.validate();
                            });
                            return str;
                          },
                          labelText: "ایمیل",
                          validator: (val) {
                            if (val.toString() != null &&
                                val.toString().length == 0) {
                              return "این فیلد نباید خالی باشد.";
                            } else if (val.toString() != null &&
                                val.toString().length != 0 &&
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val.toString())) {
                              return 'فرمت ایمیل صحیح نیست';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextInputCustom(
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.visiblePassword,
                          autofocus: false,
                          obscureText: true,
                          controller: passwordController,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                          maxLines: 1,
                          maxLength: 11,
                          onChanged: (str) {
                            setState(() {
                              _formKey.currentState.validate();
                            });
                            return str;
                          },
                          labelText: "پسورد",
                          validator: (val) {
                            if (val.toString() != null &&
                                val.toString().length == 0) {
                              return "این فیلد نباید خالی باشد.";
                            } else if (val.toString() != null &&
                                val.toString().length < 3) {
                              return "تعداد ارقام وارد شده نباید کمتر از 3 رقم باشد.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        MaterialButton(
                          minWidth: double.maxFinite,
                          height: 56,
                          onPressed: () => _checkFields(),
                          color: Theme.of(context).accentColor,

                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 12),
                            child: Text(
                              "ورود",
                              style: TextStyle(
                                  fontFamily: "YekanB",
                                  fontStyle: FontStyle.normal,
                                  color: getThemeBrightness()
                                      ? Colors.black87
                                      : Colors.white),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias, // Add This
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 12, right: 12),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "رمز عبو را فراموش کرده اید؟",
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
                        Dash(
                          direction: Axis.vertical,
                          length: 30,
                        ),
                        InkWell(
                          onTap: () => _navigateToRegister(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 4, left: 12, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "حساب کاربری ندارید؟",
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
                                Text(
                                  " ثبت نام",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "YekanB",
                                    fontStyle: FontStyle.normal,
                                    color: getThemeBrightness()
                                        ? Colors.deepOrange
                                        : Colors.deepOrange,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  ///validate phone number before send to server
  _checkFields() {
    if (this._formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      _login();
    }
  }

  ///send login info to server
  _login() async {
    await pr.show();
    repo
        .login(
            loginReq: LoginReq(
      email: emailController.text,
      password: passwordController.text,
    ))
        .then((value) {
      print('print then $value');
      if (pr.isShowing()) {
        pr.hide();
      }
      _saveUserInfo(value);
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

  ///save user information
  _saveUserInfo(LoginRes model) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('user.api_token', model.token.token);
      prefs
          .setString('user.id', model.user.id.toString())
          .then((value) => _success());
    });
  }

  ///restart app after register
  _success() async {
    RestartWidget.restartApp(context);
  }

  ///navigate to login page for registering
  _navigateToRegister() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          return Register();
        }));
      });
    });
  }
}
