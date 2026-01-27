class PayEntity {
  final int id;
  final String merchantName;
  final String accountNumber;
  final String bankName;
  final String amount;
  final String currency;
  final String purpose;
  final String fromAccount;

  PayEntity({
    required this.id,
    required this.merchantName,
    required this.accountNumber,
    required this.bankName,
    required this.amount,
    required this.currency,
    required this.purpose,
    required this.fromAccount,
  });
}
