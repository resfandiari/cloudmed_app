class LikeRes {
  /// the success var has error in like response is bool
  /// and in unlike is string
  // bool success;
  bool liked;
  String message;
  int likecount;

  LikeRes({this.liked, this.message, this.likecount});

  LikeRes.fromJson(Map<String, dynamic> json) {
    // success = json['success'];
    liked = json['liked'];
    message = json['message'];
    likecount = json['likecount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['success'] = this.success;
    data['liked'] = this.liked;
    data['message'] = this.message;
    data['likecount'] = this.likecount;
    return data;
  }
}
