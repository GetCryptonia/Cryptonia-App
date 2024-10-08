class SignupRequestModel {
  String username;
  String email;
  String password;
  String avatar;
  String? referralCode;

  SignupRequestModel({
    required this.username,
    required this.email,
    required this.password,
    required this.avatar,
    this.referralCode,
  });

  static bareBones() {
    return SignupRequestModel(
        username: "", email: "", password: "", avatar: "", referralCode: "");
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "avatar": avatar,
      "referralCode": referralCode
    };
  }
}
