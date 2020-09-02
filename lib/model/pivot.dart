class Pivot {
  int postId;
  int mediaId;

  Pivot({this.postId, this.mediaId});

  Pivot.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    mediaId = json['media_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['media_id'] = this.mediaId;
    return data;
  }
}
