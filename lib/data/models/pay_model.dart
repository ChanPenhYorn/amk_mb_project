import 'package:amk_bank_project/domain/entities/pay_entity.dart';

class PayModel extends PayEntity {
  PayModel({
    required super.id,
    required super.merchantName,
    required super.accountNumber,
    required super.bankName,
    required super.amount,
    required super.currency,
    required super.purpose,
    required super.fromAccount,
  });

  factory PayModel.fromJson(Map<String, dynamic> json) {
    return PayModel(
      id: json['id'],
      merchantName: json['merchantName'],
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
      amount: json['amount'],
      currency: json['currency'],
      purpose: json['purpose'],
      fromAccount: json['fromAccount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'merchantName': merchantName,
      'accountNumber': accountNumber,
      'bankName': bankName,
      'amount': amount,
      'currency': currency,
      'purpose': purpose,
      'fromAccount': fromAccount,
    };
  }
}
