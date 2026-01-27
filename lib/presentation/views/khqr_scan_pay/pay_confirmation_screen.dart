import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'confirm_password_screen.dart';

class PayConfirmationScreen extends ConsumerWidget {
  final Map<String, String> qrData;

  const PayConfirmationScreen({super.key, required this.qrData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantName = qrData['59'] ?? 'Natura Cafe';
    final accountNumber = qrData['01'] ?? '900010000101013';
    final bankName = qrData['00'] ?? 'AMK Microfinance Plc.';
    const fromAccount = '507 785 45 | KHR';
    const purpose = 'Pay for goods or services';
    const amount = '40,000 KHR';
    const fee = '0 KHR';
    const totalDebit = '40,000 KHR';

    return Scaffold(
      // backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFBC346E),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Confirmation',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/network/logo_amkpay.png',
              width: 50,
              package: 'khqr_scan_package',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Pay to Section
          Center(
            child: Column(
              children: [
                Text('Pay to', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(
                  merchantName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFFBC346E),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  accountNumber,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(bankName, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Details Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildDetailRow(context, 'From account', fromAccount),
                _buildDetailRow(context, 'Purpose', purpose),
                _buildDetailRow(context, 'Amount', amount),
                _buildDetailRow(context, 'Fee', fee),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    height: 1,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                _buildDetailRow(
                  context,
                  'Total debit',
                  totalDebit,
                  isBold: true,
                  isTotal: true,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Confirm Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Confirm Password Screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfirmPasswordScreen(
                        qrData: qrData,
                        amount: totalDebit,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBC346E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Confirm',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: isTotal
                ? Theme.of(context).textTheme.titleLarge
                : Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
                  ),
          ),
        ],
      ),
    );
  }
}
