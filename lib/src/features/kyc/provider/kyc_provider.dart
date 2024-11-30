import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/kyc/services/kyc_service.dart';
import 'package:cryptonia/src/features/kyc/utils/enums/kyc_type.dart';
import 'package:cryptonia/src/features/profile/models/user_profile_model.dart';
import 'package:cryptonia/src/features/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';

class KycProvider with ChangeNotifier {
  final KycService _service = KycService();
  String? kycNumber;
  String? get number => kycNumber;
  set number(String? value) {
    kycNumber = value;
    notifyListeners();
  }

  //send kyc otp
  Future<ApiResponse> sendOtp({
    required String number,
    required KycType type,
  }) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    return await _service.sendOtp(token: token, number: number, type: type);
  }

  //verify kyc otp
  Future<ApiResponse> verifyOtp({
    required String otp,
    required KycType type,
  }) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    final res = await _service.verifyOtp(token: token, otp: otp, type: type);

    if (res.status == Status.success && res.data != null) {
      UserProfileModel profile = res.data as UserProfileModel;
      ProfileProvider().userProfileModel = profile;
    }

    return res;
  }
}
