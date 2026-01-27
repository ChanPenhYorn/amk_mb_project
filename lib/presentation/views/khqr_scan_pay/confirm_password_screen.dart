import 'package:amk_bank_project/presentation/views/khqr_scan_pay/transaction_detail_screen.dart';
import 'package:flutter/material.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  final Map<String, String> qrData;
  final String amount;

  const ConfirmPasswordScreen({
    super.key,
    required this.qrData,
    required this.amount,
  });

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  String pin = '';
  final int pinLength = 6;

  void _onKeyPressed(String value) {
    if (pin.length < pinLength) {
      setState(() {
        pin += value;
      });
      if (pin.length == pinLength) {
        _submitPin();
      }
    }
  }

  void _onDeletePressed() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  void _submitPin() {
    // Mock PIN submission
    debugPrint('PIN Submitted: $pin');
    // Here you would typically validate the PIN with a backend or local storage
    if (pin == '123456') {
      _showSuccess('Transaction Successful');
    } else {
      _showError('Invalid PIN');
      setState(() {
        pin = '';
      });
    }
  }

  void _showSuccess(String message) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TransactionDetailScreen(
          qrData: widget.qrData,
          amount: widget.amount,
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final merchantName =
        widget.qrData['name'] ?? widget.qrData['59'] ?? 'Natura Cafe';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB33071), // Approximate start color from image
              Color(0xFF852454), // Approximate end color from image
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Image.asset(
                        'assets/images/network/logo_amkpay.png',
                        width: 50,
                        package: 'khqr_scan_package',
                        color: Colors.white, // Ensure visibility on dark bg
                        colorBlendMode: BlendMode.srcIn,
                        // Note: The logo in image seems white-bordered or white version.
                        // Using srcIn to tint it white might be safe if it's a transparency png.
                        // If it's the full colored logo, we might just display it as is.
                        // Let's remove color filter for now as the image shows the standard logo in a white box?
                        // Wait, image shows a white outline box with "AMK Pay" text inside.
                      ),
                    ),
                  ],
                ),
              ),

              // Header workaround for Logo
              // In the image, the logo is top right, looks like the standard one but maybe white containment.
              // Let's assume the asset provided 'assets/images/network/logo_amkpay.png' is usable.
              // I'll stick to simple Image.asset for now.
              const SizedBox(height: 20),

              Text(
                'Pay to',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withAlpha(200),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                merchantName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.amount,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 60),

              Text(
                'Enter 6-digit password',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withAlpha(200),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              // PIN Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pinLength, (index) {
                  bool isFilled = index < pin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 24, // Size from image approximation
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled ? Colors.white : Colors.transparent,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  );
                }),
              ),

              const Spacer(),

              // Numpad
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNumpadRow(['1', '2', '3']),
                    const SizedBox(height: 20),
                    _buildNumpadRow(['4', '5', '6']),
                    const SizedBox(height: 20),
                    _buildNumpadRow(['7', '8', '9']),
                    const SizedBox(height: 20),
                    _buildLastRow(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumpadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) => _buildKey(key)).toList(),
    );
  }

  Widget _buildLastRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionKey(
          icon: Icons.face_retouching_natural,
          label: 'Face ID',
          onTap: () {
            debugPrint('Face ID triggered');
          },
        ),
        _buildKey('0'), // 0 is wider/same size? Image shows same size circle.
        _buildActionKey(
          icon: Icons.backspace_outlined,
          label: 'Delete',
          onTap: _onDeletePressed,
          isDelete: true, // Special icon handling if needed
        ),
      ],
    );
  }

  Widget _buildKey(String value) {
    return GestureDetector(
      onTap: () => _onKeyPressed(value),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withAlpha(80), width: 1),
          // color: Colors.white.withOpacity(0.1), // Optional fill for touch feel
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildActionKey({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDelete = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        height: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The image for Face ID shows an icon.
            // The image for Delete shows an icon with X.
            // Both are just icons in the layout provided, no circle border.
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
