import 'package:amk_bank_project/core/shared/app_font.dart';
import 'package:amk_bank_project/core/utils/app_colors.dart';
import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:amk_bank_project/presentation/views/khqr_scan_pay/pay_confirmation_screen.dart';
import 'package:amk_bank_project/presentation/widgets/app_button_widget.dart';
import 'package:amk_bank_project/presentation/widgets/app_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amk_bank_project/presentation/controllers/pay/pay_notifier.dart';
import 'package:amk_bank_project/presentation/controllers/pay/pay_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gap/gap.dart';

class PayScreen extends ConsumerStatefulWidget {
  final String merchantName;
  final String accountNumber;
  final String bankName;

  const PayScreen({
    super.key,
    required this.merchantName,
    required this.accountNumber,
    required this.bankName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PayScreenState();
  }
}

class _PayScreenState extends ConsumerState<PayScreen> {
  @override
  void initState() {
    ref.read(payProvider.notifier).loadAccounts();
    ref.read(payProvider.notifier).loadPurposes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final payState = ref.watch(payProvider);
    final notifier = ref.read(payProvider.notifier);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.amkPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pay to',
          style: AppFont.bold(
            fontSizeValue: 18,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/network/logo_amkpay.png',
              height: 30,
              package: 'khqr_scan_package',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 10),
                  Text(
                    widget.merchantName,
                    style: AppFont.bold(
                      fontSizeValue: 18,
                      color: AppColors.amkPrimary,
                    ),
                  ),
                  Text(
                    widget.accountNumber,
                    style: AppFont.medium(
                      fontSizeValue: 16,
                      color: isDark
                          ? Colors.grey[400] ?? Colors.grey
                          : Colors.grey[800] ?? Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.bankName,
                    style: AppFont.regular(
                      fontSizeValue: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAmountInput(isDark, payState, notifier),

                  const SizedBox(height: 12),
                  // _buildDropdownSelector(
                  //   label: 'Pay from',
                  //   value: payState.selectedAccount,
                  //   isDark: isDark,
                  //   onTap: () {
                  //     // Handle account selection
                  //   },
                  // ),
                  Skeletonizer(
                    enabled: payState.accounts.isEmpty,

                    child: buildDropdownButton(
                      context,
                      label: "Pay From",
                      items: payState.accounts,
                      selectedValue: payState.selectedAccount,
                      onChanged: (NameModel? p1) {
                        if (p1 != null) {
                          notifier.setSelectedAccount(p1);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 4),

                  Skeletonizer(
                    enabled: payState.purposes.isEmpty,

                    child: buildDropdownButton(
                      context,
                      label: "Purpose",

                      items: payState.purposes,
                      selectedValue: payState.selectedPurpose,
                      onChanged: (NameModel? p1) {
                        if (p1 != null) {
                          notifier.setSelectedPurpose(p1);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildNumericKeypad(isDark, notifier),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppPrimaryButton(
              text: 'Continue',
              onPressed: payState.amount == '0'
                  ? null
                  : () {
                      final Map<String, String> qrData = {
                        'name': widget.merchantName,
                        'accountNumber': widget.accountNumber,
                        'bankName': widget.bankName,
                      };

                      // Handle continue
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PayConfirmationScreen(qrData: qrData),
                        ),
                      );
                    },
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Column buildDropdownButton(
    BuildContext context, {
    required List<NameModel> items,
    required NameModel? selectedValue,
    required void Function(NameModel?)? onChanged,
    required String label,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        Gap(2),
        AppDropdownButtonWidget(
          padding: EdgeInsets.only(right: 8),
          onChanged: onChanged,
          items: items,
          selectedValue: selectedValue,
        ),
      ],
    );
  }

  Widget _buildAmountInput(bool isDark, PayState state, PayNotifier notifier) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Currency:',
                style: AppFont.medium(fontSizeValue: 14, color: Colors.grey),
              ),
              Row(
                children: [
                  _buildCurrencyToggle('KHR', isDark, state, notifier),
                  const SizedBox(width: 8),
                  _buildCurrencyToggle('USD', isDark, state, notifier),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          RichText(
            maxLines: 1,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${state.amount} ",
                  style: AppFont.bold(
                    fontSizeValue: 40,
                    color: state.amount == '0'
                        ? (Colors.grey[300] ?? Colors.grey)
                        : (isDark ? Colors.white : Colors.black),
                  ),
                ),
                TextSpan(
                  text: state.currency,
                  style: AppFont.bold(
                    fontSizeValue: 20,
                    color: Colors.grey[400] ?? Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyToggle(
    String currency,
    bool isDark,
    PayState state,
    PayNotifier notifier,
  ) {
    bool isSelected = state.currency == currency;
    return GestureDetector(
      onTap: () => notifier.setCurrency(currency),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.amkPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.amkPrimary
                : Colors.grey[300] ?? Colors.grey,
          ),
        ),
        child: Text(
          currency,
          style: AppFont.bold(
            fontSizeValue: 14,
            color: isSelected ? Colors.white : Colors.grey[400] ?? Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildNumericKeypad(bool isDark, PayNotifier notifier) {
    return Container(
      color: isDark ? AppColors.darkSurface : Colors.white,
      child: Column(
        children: [
          _buildKeyRow(['1', '2', '3'], isDark, notifier),
          _buildKeyRow(['4', '5', '6'], isDark, notifier),
          _buildKeyRow(['7', '8', '9'], isDark, notifier),
          _buildKeyRow(['.', '0', 'backspace'], isDark, notifier),
        ],
      ),
    );
  }

  Widget _buildKeyRow(List<String> keys, bool isDark, PayNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((key) => _buildKey(key, isDark, notifier)).toList(),
      ),
    );
  }

  Widget _buildKey(String key, bool isDark, PayNotifier notifier) {
    Widget content;
    if (key == 'backspace') {
      content = Icon(
        Icons.backspace_outlined,
        color: isDark ? Colors.white : Colors.black,
      );
    } else {
      content = Text(
        key,
        style: AppFont.bold(
          fontSizeValue: 24,
          color: isDark ? Colors.white : Colors.black,
        ),
      );
    }

    return InkWell(
      onTap: () => notifier.onKeyTap(key),
      child: Container(
        width: 80,
        height: 50,
        alignment: Alignment.center,
        child: content,
      ),
    );
  }
}
