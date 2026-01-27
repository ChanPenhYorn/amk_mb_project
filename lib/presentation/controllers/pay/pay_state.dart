import 'package:amk_bank_project/data/models/name_model.dart';

class PayState {
  final String amount;
  final String currency;
  final NameModel? selectedAccount;
  final NameModel? selectedPurpose;

  final List<NameModel> accounts;
  final List<NameModel> purposes;

  const PayState({
    this.amount = '0',
    this.currency = 'KHR',

    required this.accounts,
    required this.purposes,
    this.selectedAccount,
    this.selectedPurpose,
  });

  PayState copyWith({
    String? amount,
    String? currency,
    NameModel? selectedAccount,
    NameModel? selectedPurpose,
    List<NameModel>? accounts,
    List<NameModel>? purposes,
  }) {
    return PayState(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      selectedPurpose: selectedPurpose ?? this.selectedPurpose,
      accounts: accounts ?? this.accounts,
      purposes: purposes ?? this.purposes,
    );
  }
}
