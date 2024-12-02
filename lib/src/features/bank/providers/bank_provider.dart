import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/bank/models/account_model.dart';
import 'package:cryptonia/src/features/bank/models/account_name.dart';
import 'package:cryptonia/src/features/bank/models/bank_model.dart';
import 'package:cryptonia/src/features/bank/services/account_service.dart';
import 'package:flutter/material.dart';

class BankProvider with ChangeNotifier {
  final AccountService _accountService = AccountService();

  void clearAll() {
    banks = [];
    accounts = [];
    accountName = null;
    selectedAccount = null;
    selectedBank = null;
    notifyListeners();
  }

  List<BankModel> allBanks = [];
  List<BankModel> get banks => allBanks;
  set banks(List<BankModel> value) {
    allBanks = value;
    notifyListeners();
  }

  List<AccountModel> userAccounts = [];
  List<AccountModel> get accounts => userAccounts;
  set accounts(List<AccountModel> value) {
    userAccounts = value;
    notifyListeners();
  }

  AccountName? accountNameData;
  AccountName? get accountName => accountNameData;
  set accountName(AccountName? value) {
    accountNameData = value;
    notifyListeners();
  }

  BankModel? selectedBank;
  BankModel? get bank => selectedBank;
  set bank(BankModel? value) {
    selectedBank = value;
    notifyListeners();
  }

  AccountModel? selectedAccount;
  AccountModel? get account => selectedAccount;
  set account(AccountModel? value) {
    selectedAccount = value;
    notifyListeners();
  }

  Future<ApiResponse> fetchBanks() async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception('Token not found');

    ApiResponse response = await _accountService.fetchBanks(token);

    if (response.status == Status.error || response.data == null) {
      return response;
    }

    banks = response.data as List<BankModel>;

    return response;
  }

  Future<ApiResponse> verifyAccountName(String accountNumber) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception('Token not found');

    if (bank == null) return ApiResponse.exception('Select a bank');

    ApiResponse response = await _accountService.verifyAccountName(
        token: token, bankCode: bank!.bankCode, accountNumber: accountNumber);

    if (response.status == Status.error || response.data == null) {
      return response;
    }

    accountName = response.data as AccountName;

    return response;
  }

  Future<ApiResponse> createUserAccount() async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception('Token not found');

    if (bank == null) return ApiResponse.exception('Select a bank');

    if (accountName == null) return ApiResponse.exception('Enter account data');

    ApiResponse response = await _accountService.createAccount(
      token: token,
      bankCode: accountName!.bankCode,
      bankName: bank!.name,
      accountNumber: accountName!.accountNumber,
      accountName: accountName!.accountName,
      categoryId: bank!.categoryId,
    );

    if (response.status == Status.error || response.data == null) {
      return response;
    }

    AccountModel account = response.data as AccountModel;

    accounts = [...userAccounts, account];

    return response;
  }

  Future<ApiResponse> fetchUserAccounts(BuildContext context) async {
    print('Hit the provider');
    String? token = AuthProvider().getToken(context);

    if (token == null) return ApiResponse.exception('Token not found');

    print('About to fetch accounts');

    ApiResponse response = await _accountService.fetchUserAccounts(token);

    if (response.status == Status.error || response.data == null) {
      return response;
    }

    accounts = response.data as List<AccountModel>;

    return response;
  }

  Future<ApiResponse> removeUserAccount(String accountId) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception('Token not found');

    ApiResponse response =
        await _accountService.deleteUserAccount(token: token, id: accountId);

    if (response.status == Status.error) return response;

    List<AccountModel> modifiedAccounts =
        accounts.where((a) => a.id != accountId).toList();

    accounts = modifiedAccounts;

    return response;
  }
}
