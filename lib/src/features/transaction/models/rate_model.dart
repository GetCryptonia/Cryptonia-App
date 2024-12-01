class RateModel {
  String id;
  int amount;
  num fiatAmount;
  DateTime createdAt;

  RateModel({
    required this.id,
    required this.amount,
    required this.fiatAmount,
    required this.createdAt,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['_id'],
      amount: json['tokenAmount'],
      fiatAmount: json['fiatAmount'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
