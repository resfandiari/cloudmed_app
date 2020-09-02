import 'image.dart';
import 'user.dart';

class Data {
  int id;
  String description;
  int timelineId;
  int userId;
  int active;
  String createdAt;
  String updatedAt;
  int commentsCount;
  int usersLikedCount;
  List<Images> images;
  User user;
  int isLiked;

  Data(
      {this.id,
      this.description,
      this.timelineId,
      this.userId,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.commentsCount,
      this.usersLikedCount,
      this.images,
      this.user,
      this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    timelineId = json['timeline_id'];
    userId = json['user_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commentsCount = json['comments_count'];
    usersLikedCount = json['users_liked_count'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['timeline_id'] = this.timelineId;
    data['user_id'] = this.userId;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['comments_count'] = this.commentsCount;
    data['users_liked_count'] = this.usersLikedCount;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['is_liked'] = this.isLiked;
    return data;
  }
}
