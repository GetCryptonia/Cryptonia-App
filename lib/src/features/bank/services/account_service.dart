import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/bank/models/account_model.dart';
import 'package:cryptonia/src/features/bank/models/account_name.dart';
import 'package:cryptonia/src/features/bank/models/bank_model.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:dio/dio.dart';

class AccountService {
  final String _banksPath = "${AppConstants.baseUrl}banks/";
  final String _accountsPath = "${AppConstants.baseUrl}accounts/";

  //fetch bank list
  Future<ApiResponse> fetchBanks(String token) async {
    try {
      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final response = await dio.get(_banksPath);

      final data = response.data;

      List<BankModel> banks =
          data['data'].map<BankModel>((e) => BankModel.fromJson(e)).toList();

      return ApiResponse.success(message: data['message'], data: banks);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  //verify account name
  Future<ApiResponse> verifyAccountName({
    required String token,
    required String bankCode,
    required String accountNumber,
  }) async {
    try {
      final Dio dio = Dio();

      const String endpoint = 'name/';

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final body = {'bankCode': bankCode, 'accountNumber': accountNumber};

      final response = await dio.post("$_banksPath$endpoint", data: body);

      final data = response.data;

      AccountName accountName = AccountName.fromJson(data['data']);

      return ApiResponse.success(message: data['message'], data: accountName);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  //create user account
  Future<ApiResponse> createAccount({
    required String token,
    required String bankCode,
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String categoryId,
  }) async {
    try {
      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final body = {
        "bankCode": bankCode,
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountName": accountName,
        "categoryId": categoryId
      };

      final response = await dio.post(_accountsPath, data: body);

      final data = response.data;

      AccountModel account = AccountModel.fromJson(data['data']);

      return ApiResponse.success(message: data['message'], data: account);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  //fetch user accounts
  Future<ApiResponse> fetchUserAccounts(String token) async {
    try {
      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final response = await dio.get(_accountsPath);

      final data = response.data;

      print(data);

      List<AccountModel> accounts = data['data']
          .map<AccountModel>((e) => AccountModel.fromJson(e))
          .toList();

      return ApiResponse.success(message: data['message'], data: accounts);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  //delete user account
  Future<ApiResponse> deleteUserAccount(
      {required String token, required String id}) async {
    try {
      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final body = {"accountId": id};

      final response = await dio.delete(_accountsPath, data: body);

      final data = response.data;

      return ApiResponse.success(message: data['message']);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }
}
