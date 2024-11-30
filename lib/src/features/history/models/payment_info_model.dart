class PaymentInfoModel {
  String id;
  String client;
  String account;
  String type;
  String sessionId;
  String nameEnquiryReference;
  String paymentReference;
  String provider;
  String destinationInstitutionCode;
  String creditAccountName;
  String creditAccountNumber;
  DateTime createdAt;

  PaymentInfoModel({
    required this.id,
    required this.client,
    required this.account,
    required this.type,
    required this.sessionId,
    required this.nameEnquiryReference,
    required this.paymentReference,
    required this.provider,
    required this.destinationInstitutionCode,
    required this.creditAccountName,
    required this.creditAccountNumber,
    required this.createdAt,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) {
    return PaymentInfoModel(
      id: json['_id'],
      client: json['client'],
      account: json['account'],
      type: json['type'],
      sessionId: json['sessionId'],
      nameEnquiryReference: json['nameEnquiryReference'],
      paymentReference: json['paymentReference'],
      provider: json['provider'],
      destinationInstitutionCode: json['destinationInstitutionCode'],
      creditAccountName: json['creditAccountName'],
      creditAccountNumber: json['creditAccountNumber'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
    );
  }
}
