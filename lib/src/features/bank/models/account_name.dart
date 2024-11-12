class AccountName {
  String sessionId;
  String bankCode;
  String accountName;
  String accountNumber;

  AccountName({
    required this.sessionId,
    required this.bankCode,
    required this.accountName,
    required this.accountNumber,
  });

  factory AccountName.fromJson(Map<String, dynamic> json) {
    return AccountName(
      sessionId: json['sessionId'],
      bankCode: json['bankCode'],
      accountName: json['accountName'],
      accountNumber: json['accountNumber'],
    );
  }
}
