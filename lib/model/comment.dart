import 'package:cloudmed_app/model/user.dart';

class Comment {
  int id;
  int postId;
  String description;
  int userId;
  Null parentId;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  Null mediaId;
  User user;

  Comment(
      {this.id,
      this.postId,
      this.description,
      this.userId,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.mediaId,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    description = json['description'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    mediaId = json['media_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['media_id'] = this.mediaId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
