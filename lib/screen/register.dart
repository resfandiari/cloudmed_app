import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:cloudmed_app/model/model.dart';
import 'package:cloudmed_app/network/api_provider.dart';
import 'package:cloudmed_app/network/repository.dart';
import 'package:cloudmed_app/widget/TextInputCustom.dart';
import 'package:cloudmed_app/widget/dash.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Repository repo;
  ProgressDialog pr;

  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final mccController = TextEditingController();
  final passwordController = TextEditingController();
  final aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    repo = new Repository(apiProvider: new ApiProvider());
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    mccController.dispose();
    passwordController.dispose();
    aboutController.dispose();
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
                          keyboardType: TextInputType.name,
                          autofocus: false,
                          controller: nameController,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                          maxLines: 1,
                          maxLength: 30,
                          onChanged: (str) {
                            setState(() {
                              _formKey.currentState.validate();
                            });
                            return str;
                          },
                          labelText: "نام",
                          validator: (val) {
                            if (val.toString() != null &&
                                val.toString().length == 0) {
                              return "این فیلد نباید خالی باشد.";
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
                          keyboardType: TextInputType.name,
                          autofocus: false,
                          controller: userNameController,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                          maxLines: 1,
                          maxLength: 30,
                          onChanged: (str) {
                            setState(() {
                              _formKey.currentState.validate();
                            });
                            return str;
                          },
                          labelText: "نام کاربری",
                          validator: (val) {
                            if (val.toString() != null &&
                                val.toString().length == 0) {
                              return "این فیلد نباید خالی باشد.";
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
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                          controller: phoneController,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                          maxLines: 1,
                          maxLength: 11,
                          onChanged: (str) {
                            setState(() {
                              _formKey.currentState.validate();
                            });
                            return str;
                          },
                          labelText: "موبایل",
                          validator: (val) {
                            if (val.toString() != null &&
                                val.toString().length == 0) {
                              return "این فیلد نباید خالی باشد.";
                            } else if (val.toString() != null &&
                                val.toString().length != 0 &&
                                val.toString()[0] != "0") {
                              return "شماره را با 0 وارد کنید.";
                            } else if (val.toString() != null &&
                                val.toString().length != 0 &&
                                val.toString()[1] != "9") {
                              return "بعد از صفر 9 را وارد کنید.";
                            } else if (val.toString() != null &&
                                val.toString().length < 11) {
                              return "تعداد ارقام وارد شده باید برابر با 11 رقم باشد.";
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
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          controller: mccController,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                          maxLines: 1,
                          maxLength: 10,
                          onChanged: (str) {
                            setState(() {
                              _formKey.currentState.validate();
                            });
                            return str;
                          },
                          labelText: "کد نظام پزشکی",
                          validator: (val) {
                            if (val.toString() != null &&
                                val.toString().length == 0) {
                              return "این فیلد نباید خالی باشد.";
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
                          controller: passwordController,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                          maxLines: 1,
                          maxLength: 10,
                          obscureText: true,
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
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextInputCustom(
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          controller: aboutController,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                          maxLines: 1,
                          maxLength: 50,
                          onChanged: (str) {
                            setState(() {
                              _formKey.currentState.validate();
                            });
                            return str;
                          },
                          labelText: "درباره من",
                          validator: (val) {
                            if (val.toString() != null &&
                                val.toString().length == 0) {
                              return "این فیلد نباید خالی باشد.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 12,
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
                              "ثبت نام",
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
                        SizedBox(
                          height: 10,
                        ),
                        Dash(
                          direction: Axis.vertical,
                          length: 30,
                        ),
                        InkWell(
                          onTap: () => _navigateToLogin(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 4, left: 12, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "حساب کاربری دارید؟",
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
                                  "ورود",
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
        .register(
            registerReq: RegisterReq(
                name: nameController.text,
                username: userNameController.text,
                email: emailController.text,
                mobileNumber: phoneController.text,
                mcc: mccController.text,
                password: passwordController.text,
                about: aboutController.text,
                type: "user"))
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
  _saveUserInfo(RegisterRes model) {
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
  _navigateToLogin() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          return Login();
        }));
      });
    });
  }
}
