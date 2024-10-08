import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/auth/models/login_details_model.dart';
import 'package:cryptonia/src/features/auth/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<bool> storeToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('Token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Token');
  }

  Future<bool> storeLoginDetails(LoginDetailsModel loginDetails) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<bool> res = await Future.wait([
      prefs.setString('Email', loginDetails.email),
      prefs.setString('Password', loginDetails.password),
    ]);

    //only return true if every element is true and no false
    return res.every((element) => element == true);
  }

  Future<LoginDetailsModel?> getLoginDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('Email');
    String? password = prefs.getString('Password');

    return email == null || password == null
        ? null
        : LoginDetailsModel(email: email, password: password);
  }

  Future<bool> clearStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.clear();
  }

  Future<String?> getAccessToken(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Token');

    if (token == null || JwtDecoder.isExpired(token)) {
      PageNavigation.replaceAll(context, const SignIn());
      return null;
    }

    return token;
  }
}
