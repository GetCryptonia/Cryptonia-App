import 'package:cryptonia/src/features/kyc/utils/enums/kyc_type.dart';

class UserProfileModel {
  String username;
  String email;
  bool emailVerified;
  String avatar;
  String? referralCode;
  String? firstName;
  String? lastName;
  KycType? kyc;

  UserProfileModel({
    required this.username,
    required this.email,
    required this.emailVerified,
    required this.avatar,
    required this.referralCode,
    this.firstName,
    this.lastName,
    required this.kyc,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    List<KycType> matchingKyc = json['kyc'] == null
        ? []
        : KycType.values
            .where((e) => e.name.toLowerCase() == json['kyc'])
            .toList();
    return UserProfileModel(
      username: json['username'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      avatar: json['avatar'],
      referralCode: json['referralCode'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      kyc:
          json['kyc'] == null || matchingKyc.isEmpty ? null : matchingKyc.first,
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
      "kyc": kyc?.name.toLowerCase(),
    };
  }
}
