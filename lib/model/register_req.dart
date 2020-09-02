class RegisterReq {
  String name;
  String username;
  String email;
  String mobileNumber;
  String mcc;
  String password;
  String about;
  String type;

  RegisterReq(
      {this.name,
      this.username,
      this.email,
      this.mobileNumber,
      this.mcc,
      this.password,
      this.about,
      this.type});

  RegisterReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    mcc = json['mcc'];
    password = json['password'];
    about = json['about'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['mcc'] = this.mcc;
    data['password'] = this.password;
    data['about'] = this.about;
    data['type'] = this.type;
    return data;
  }
}
