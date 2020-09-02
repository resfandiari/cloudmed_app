import 'package:cloudmed_app/model/token.dart';
import 'package:cloudmed_app/model/user.dart';

class RegisterRes {
  bool success;
  Token token;
  User user;

  RegisterRes({this.success, this.token, this.user});

  RegisterRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
