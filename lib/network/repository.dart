import 'package:cloudmed_app/model/model.dart';
import 'package:flutter/material.dart';
import 'api_provider.dart';

class Repository {
  Repository({@required this.apiProvider});

  final ApiProvider apiProvider;

  ///Register user
  ///required [RegisterReq]
  ///response [RegisterRes]
  Future<RegisterRes> register({RegisterReq registerReq}) =>
      apiProvider.register(registerReq: registerReq);

  ///Login user
  ///required [LoginReq]
  ///response [LoginRes]
  Future<LoginRes> login({LoginReq loginReq}) =>
      apiProvider.login(loginReq: loginReq);

  ///Logout user
  ///required []
  ///response [LogoutRes]
  Future<LogoutRes> logout() => apiProvider.logout();
}
