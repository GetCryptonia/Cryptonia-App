import 'package:cryptonia/src/features/history/models/payment_info_model.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';

class OrderModel {
  String id;
  String userId;
  TokenType token;
  String address;
  TransactionStatus status;
  double tokenAmount;
  double fiatAmount;
  String receiverBank;
  String receiverBankCode;
  String receiverSessionId;
  String receiverAccountName;
  String receiverAccountNumber;
  DateTime createdAt;
  PaymentInfoModel? paymentInfo;

  OrderModel({
    required this.id,
    required this.userId,
    required this.token,
    required this.address,
    required this.status,
    required this.tokenAmount,
    required this.fiatAmount,
    required this.receiverBank,
    required this.receiverBankCode,
    required this.receiverSessionId,
    required this.receiverAccountName,
    required this.receiverAccountNumber,
    required this.createdAt,
    required this.paymentInfo,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      userId: json['userId'],
      token: TokenType.values.firstWhere((e) => e.symbol == json['symbol']),
      address: json['address'],
      status:
          TransactionStatus.values.firstWhere((e) => e.name == json['status']),
      tokenAmount: json['tokenAmount'].toDouble(),
      fiatAmount: json['fiatAmount'].toDouble(),
      receiverBank: json['receiverBank'],
      receiverBankCode: json['receiverBankCode'],
      receiverSessionId: json['receiverSessionId'],
      receiverAccountName: json['receiverAccountName'],
      receiverAccountNumber: json['receiverAccountNumber'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      paymentInfo: json['paymentInfo'] == null
          ? null
          : PaymentInfoModel.fromJson(json['paymentInfo']),
    );
  }
}
