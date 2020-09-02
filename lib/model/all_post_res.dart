import 'package:cloudmed_app/model/page_info.dart';

class AllPostRes {
  bool success;
  PageInfo data;

  AllPostRes({this.success, this.data});

  AllPostRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new PageInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
