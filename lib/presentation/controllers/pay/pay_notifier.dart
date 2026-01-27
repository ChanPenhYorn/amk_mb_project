import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:amk_bank_project/presentation/controllers/pay/pay_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:amk_bank_project/presentation/controllers/pay/pay_state.dart';

part 'pay_notifier.g.dart';

@riverpod
class PayNotifier extends _$PayNotifier {
  @override
  PayState build() {
    return const PayState(accounts: [], purposes: []);
  }

  void onKeyTap(String key) {
    String currentAmount = state.amount;
    String newAmount = currentAmount;

    if (key == 'backspace') {
      if (currentAmount.length > 1) {
        newAmount = currentAmount.substring(0, currentAmount.length - 1);
      } else {
        newAmount = '0';
      }
    } else if (key == '.') {
      if (!currentAmount.contains('.')) {
        newAmount += '.';
      }
    } else {
      if (currentAmount == '0') {
        newAmount = key;
      } else {
        newAmount += key;
      }
    }

    state = state.copyWith(amount: newAmount);
  }

  void setCurrency(String currency) {
    state = state.copyWith(currency: currency);
  }

  void setSelectedAccount(NameModel account) {
    state = state.copyWith(selectedAccount: account);
  }

  void setSelectedPurpose(NameModel purpose) {
    state = state.copyWith(selectedPurpose: purpose);
  }

  void reset() {
    state = const PayState(accounts: [], purposes: []);
  }

  Future<void> loadAccounts() async {
    final accounts = await ref.read(payToUseCaseProvider).getAccounts();
    state = state.copyWith(
      accounts: accounts,
      selectedAccount: accounts.isNotEmpty ? accounts.first : null,
    );
  }

  Future<void> loadPurposes() async {
    final purposes = await ref.read(payToUseCaseProvider).getPurposes();
    state = state.copyWith(
      purposes: purposes,
      selectedPurpose: purposes.isNotEmpty ? purposes.first : null,
    );
  }
}
