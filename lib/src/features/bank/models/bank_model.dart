class BankModel {
  String name;
  String bankCode;
  String categoryId;

  BankModel({
    required this.name,
    required this.bankCode,
    required this.categoryId,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      name: json['name'],
      bankCode: json['bankCode'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bankCode': bankCode,
      'categoryId': categoryId,
    };
  }
}
