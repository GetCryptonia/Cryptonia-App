class UserProfileModel {
  String username;
  String email;
  bool emailVerified;
  String avatar;
  String? referralCode;
  String? firstName;
  String? lastName;

  UserProfileModel({
    required this.username,
    required this.email,
    required this.emailVerified,
    required this.avatar,
    required this.referralCode,
    this.firstName,
    this.lastName,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      username: json['username'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      avatar: json['avatar'],
      referralCode: json['referralCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "emailVerified": emailVerified,
      "avatar": avatar,
      "referralCode": referralCode,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}
