import 'package:cloudmed_app/model/like_res.dart';
import 'package:cloudmed_app/model/model.dart';
import 'package:dio/dio.dart';
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

  ///get all post
  ///required [page]
  ///response [Map]
  Future<Map> getPost({int page}) => apiProvider.getPost(page: page);

  ///get post comment
  ///required [page]
  ///response [Map]
  Future<Map> getPostComment({String post_id}) =>
      apiProvider.getPostComment(post_id: post_id);

  ///send post comment
  ///required [page]
  ///response [Map]
  Future<Response> sendPostComment({CommentReq commentReq}) =>
      apiProvider.sendPostComment(commentReq: commentReq);

  ///add post like/unlike
  ///required [page]
  ///response [Map]
  Future<LikeRes> postLikeAndUnlike({String post_id}) =>
      apiProvider.postLikeAndUnlike(post_id: post_id);
}
