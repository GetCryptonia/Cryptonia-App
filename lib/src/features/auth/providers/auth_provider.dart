import 'package:cryptonia/src/core/local/storage_service.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/models/login_details_model.dart';
import 'package:cryptonia/src/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();

  LoginDetailsModel? _loginDetails;

  LoginDetailsModel? get loginDetails => _loginDetails;
  set loginDetails(LoginDetailsModel? value) {
    _loginDetails = value;
    notifyListeners();
  }

  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) return ApiResponse.exception("Email is required");

    if (password.isEmpty) return ApiResponse.exception("Password is required");

    final res = await _authService.login(email: email, password: password);

    if (res.status != Status.success) return res;

    await _storageService.storeToken(res.data!);
    loginDetails = LoginDetailsModel(email: email, password: password);

    return res;
  }
}
