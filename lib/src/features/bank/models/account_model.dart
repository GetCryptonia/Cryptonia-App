class AccountModel {
  String id;
  String userId;
  String bankCode;
  String bankName;
  String accountNumber;
  String accountName;
  String categoryId;
  DateTime createdAt;

  AccountModel({
    required this.userId,
    required this.bankCode,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.categoryId,
    required this.id,
    required this.createdAt,
  });

  // {
// "userId": "67059bdf609a5da89db9060c",
// "bankCode": "000016",
// "bankName": "FIRST BANK OF NIGERIA",
// "accountNumber": "3125160840",
// "accountName": "EGBEJULE-JALLA RYAN ORITSESEYIGBEMI",
// "categoryId": "2",
// "_id": "67315a8a4ed94e395192fd26",
// "createdAt": "2024-11-11T01:14:50.555Z",
// "updatedAt": "2024-11-11T01:14:50.555Z",
// "__v": 0
// }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['_id'],
      userId: json['userId'],
      bankCode: json['bankCode'],
      bankName: json['bankName'],
      accountNumber: json['accountNumber'],
      accountName: json['accountName'],
      categoryId: json['categoryId'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'bankCode': bankCode,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'categoryId': categoryId,
      'createdAt': createdAt,
    };
  }
}
