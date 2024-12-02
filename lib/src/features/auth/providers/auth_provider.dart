import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/local/storage_service.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/models/login_details_model.dart';
import 'package:cryptonia/src/features/auth/models/signup_request_model.dart';
import 'package:cryptonia/src/features/auth/screens/sign_in.dart';
import 'package:cryptonia/src/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

String? userToken;
String? _forgotPasswordEmail;
String? _forgotPasswordOtp;
SignupRequestModel? _signupRequestModel;
LoginDetailsModel? _loginDetails;

class AuthProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();

  void clearAll() {
    token = null;
    forgotPasswordEmail = null;
    forgotPasswordOtp = null;
    signupRequestModel = null;
    notifyListeners();
  }

  String? getToken(BuildContext context) {
    if (userToken == null || JwtDecoder.isExpired(userToken!)) {
      PageNavigation.replaceAll(context, const SignIn());
      return null;
    }
    return userToken;
  }

  String? get token => userToken;
  set token(String? value) {
    userToken = value;
    notifyListeners();
  }

  String? get forgotPasswordEmail => _forgotPasswordEmail;
  set forgotPasswordEmail(String? value) {
    _forgotPasswordEmail = value;
    notifyListeners();
  }

  String? get forgotPasswordOtp => _forgotPasswordOtp;
  set forgotPasswordOtp(String? value) {
    _forgotPasswordOtp = value;
    notifyListeners();
  }

  SignupRequestModel? get signupRequestModel => _signupRequestModel;
  set signupRequestModel(SignupRequestModel? value) {
    _signupRequestModel = value;
    notifyListeners();
  }

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
    token = res.data;

    return res;
  }

  Future<ApiResponse> sendOtp(String email) async {
    if (email.isEmpty) return ApiResponse.exception("Email is required");

    final res = await _authService.sendOtp(email);

    if (res.status == Status.success) {
      forgotPasswordEmail = email;
      notifyListeners();
    }

    return res;
  }

  Future<ApiResponse> changePassword(String password) async {
    if (password.isEmpty) return ApiResponse.exception("Password is required");

    final res = await _authService.changePassword(
        email: forgotPasswordEmail!,
        password: password,
        otp: forgotPasswordOtp!);

    return res;
  }

  Future<ApiResponse> signUp({
    required String email,
    required String username,
    required String password,
    required String avatar,
    required String? referralCode,
  }) async {
    if (email.isEmpty) return ApiResponse.exception("Email is required");

    if (username.isEmpty) return ApiResponse.exception("Username is required");

    if (password.isEmpty) return ApiResponse.exception("Password is required");

    if (avatar.isEmpty) return ApiResponse.exception("Avatar is required");

    final res = await _authService.signUp(
      email: email,
      username: username,
      password: password,
      avatar: avatar,
      referralCode: referralCode,
    );

    if (res.status == Status.success) {
      loginDetails = LoginDetailsModel(email: email, password: password);
      token = res.data;
    }

    return res;
  }

  Future<ApiResponse> verifyEmail(BuildContext context, String otp) async {
    if (otp.length < 6) return ApiResponse.exception("Enter a valid otp");

    String? token = getToken(context);

    if (token == null) return ApiResponse.exception("Token is required");

    final res = await _authService.verifyEmail(otp: otp, token: token);

    if (res.status != Status.success) return res;

    token = res.data;

    return res;
  }
}
