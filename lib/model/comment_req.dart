class CommentReq {
  int postId;
  String description;

  CommentReq({this.postId, this.description});

  CommentReq.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['description'] = this.description;
    return data;
  }
}
