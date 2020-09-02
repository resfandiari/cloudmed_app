class User {
  int id;
  int timelineId;
  String mcc;
  String mobileNumber;
  int isMobileVerify;
  int isUserVerify;
  int verified;
  int balance;
  String birthday;
  int active;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String name;
  String avatar;
  Null cover;
  String about;
  String username;
  String type;
  int hideCover;
  Null backgroundId;

  User(
      {this.id,
      this.timelineId,
      this.mcc,
      this.mobileNumber,
      this.isMobileVerify,
      this.isUserVerify,
      this.verified,
      this.balance,
      this.birthday,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.name,
      this.avatar,
      this.cover,
      this.about,
      this.username,
      this.type,
      this.hideCover,
      this.backgroundId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timelineId = json['timeline_id'];
    mcc = json['mcc'];
    mobileNumber = json['mobile_number'];
    isMobileVerify = json['is_mobile_verify'];
    isUserVerify = json['is_user_verify'];
    verified = json['verified'];
    balance = json['balance'];
    birthday = json['birthday'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    avatar = json['avatar'];
    cover = json['cover'];
    about = json['about'];
    username = json['username'];
    type = json['type'];
    hideCover = json['hide_cover'];
    backgroundId = json['background_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timeline_id'] = this.timelineId;
    data['mcc'] = this.mcc;
    data['mobile_number'] = this.mobileNumber;
    data['is_mobile_verify'] = this.isMobileVerify;
    data['is_user_verify'] = this.isUserVerify;
    data['verified'] = this.verified;
    data['balance'] = this.balance;
    data['birthday'] = this.birthday;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['cover'] = this.cover;
    data['about'] = this.about;
    data['username'] = this.username;
    data['type'] = this.type;
    data['hide_cover'] = this.hideCover;
    data['background_id'] = this.backgroundId;

    return data;
  }
}
