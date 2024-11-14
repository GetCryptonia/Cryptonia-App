import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/profile/models/edit_email_model.dart';
import 'package:cryptonia/src/features/profile/models/user_profile_model.dart';
import 'package:cryptonia/src/features/profile/services/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  EditEmailModel? editEmailModel;
  EditEmailModel? get editEmail => editEmailModel;
  set editEmail(EditEmailModel? value) {
    editEmailModel = value;
    notifyListeners();
  }

  UserProfileModel? userProfileModel;
  UserProfileModel? get profile => userProfileModel;
  set profile(UserProfileModel? value) {
    userProfileModel = value;
    notifyListeners();
  }

  //change email
  Future<ApiResponse> changeEmail({
    required String otp,
    required String email,
    required String password,
  }) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    if (email.isEmpty) return ApiResponse.exception("Email is required");

    if (password.isEmpty) return ApiResponse.exception("Password is required");

    if (otp.isEmpty) return ApiResponse.exception("OTP is required");

    final res = await _profileService.changeEmail(
        otp: otp, token: token, email: email, password: password);

    if (res.status != Status.success || res.data == null) return res;

    AuthProvider().token = res.data;

    return res;
  }

  //get account
  Future<ApiResponse> getAccount() async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    final res = await _profileService.getAccount(token);

    if (res.status != Status.success || res.data == null) return res;

    profile = res.data;

    return res;
  }

  //edit account
  Future<ApiResponse> editAccount({
    required String token,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    if (firstName.isEmpty) {
      return ApiResponse.exception("First name is required");
    }

    if (lastName.isEmpty) {
      return ApiResponse.exception("Last name is required");
    }

    if (username.isEmpty) {
      return ApiResponse.exception("Username is required");
    }

    final res = await _profileService.editAccount(
        token: token,
        firstName: firstName,
        lastName: lastName,
        username: username);

    if (res.status != Status.success || res.data == null) return res;

    UserProfileModel profileModel = res.data;

    profile = profileModel;

    return res;
  }

  //delete account
  Future<ApiResponse> deleteAccount({
    required String otp,
    required String password,
  }) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    final res = await _profileService.deleteAccount(
        token: token, otp: otp, password: password);

    return res;
  }
}
