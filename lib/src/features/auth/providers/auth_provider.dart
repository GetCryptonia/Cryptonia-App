import 'package:cryptonia/src/core/local/storage_service.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/models/login_details_model.dart';
import 'package:cryptonia/src/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class AuthProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();

  LoginDetailsModel? _loginDetails;

  LoginDetailsModel? get loginDetails => _loginDetails;
  set loginDetails(LoginDetailsModel? value) {
    _loginDetails = value;
    notifyListeners();
  }

  Future<void> fetchLoginDetails() async {
    loginDetails = await _storageService.getLoginDetails();
  }

  Future<bool> canUseBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    ;

    return availableBiometrics.contains(BiometricType.face) ||
        availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.strong);
  }

  Future<ApiResponse> authenticateWithBiometrics() async {
    try {
      final LocalAuthentication auth = LocalAuthentication();

      final bool authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to sign in to your account',
          options: const AuthenticationOptions(biometricOnly: true));

      return authenticated
          ? ApiResponse.success(message: 'Biometrics authenticated')
          : ApiResponse.exception('Biometrics failed');
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Add handling of no hardware here.
        return ApiResponse.exception("You can't use biometrics at this time");
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        return ApiResponse.exception("Biometrics is locked out");
      } else {
        return ApiResponse.exception("Biometrics failed");
      }
    }
  }

  Future<ApiResponse> storeLoginDetails() async {
    if (loginDetails == null) {
      return ApiResponse.exception("Login details are required");
    }

    bool stored = await _storageService.storeLoginDetails(loginDetails!);

    return stored
        ? ApiResponse.success(message: "Login details stored")
        : ApiResponse.exception("Failed to enable biometrics");
  }

  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) return ApiResponse.exception("Email is required");

    if (password.isEmpty) return ApiResponse.exception("Password is required");

    final res = await _authService.login(email: email, password: password);

    if (res.status != Status.success) return res;

    loginDetails = LoginDetailsModel(email: email, password: password);

    return res;
  }
}
