import 'package:amk_bank_project/presentation/controllers/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class TransactionDetailScreen extends ConsumerStatefulWidget {
  final Map<String, String> qrData;
  final String amount;

  const TransactionDetailScreen({
    super.key,
    required this.qrData,
    required this.amount,
  });

  @override
  ConsumerState<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState
    extends ConsumerState<TransactionDetailScreen> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final isDarkMode = themeState.isDarkMode ?? false;
    final fontScale = themeState.fontScale;

    // Dark Mode Colors
    // final surfaceColor = isDarkMode ? const Color(0xFF2C2C2C) : Colors.white;
    // final primaryTextColor = isDarkMode ? Colors.white : Colors.black87;
    // final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.black54;

    final merchantName =
        widget.qrData['name'] ?? widget.qrData['59'] ?? 'Natura Cafe';
    // For demo purposes, we can hardcode some mock data or reuse qrData
    final accountNumber = widget.qrData['01'] ?? '900010000101013';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB33071), Color(0xFF852454)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 8),
                child: Text(
                  'Result',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Text(
                'Successful',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // Receipt Ticket
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipPath(
                  clipper: TicketClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const SizedBox(height: 16),
                        // Logo
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/images/network/logo_amkpay.png',
                            width: 40,
                            package: 'khqr_scan_package',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '-${widget.amount}',
                          style: TextStyle(
                            // color: const Color(0xFFD32F2F), // Keep red? Or use error color? User wanted theme.
                            // But usually amount is specific color. Keeping specific or using theme error.
                            // User said 'follow theme settings'.
                            // Let's assume red is primary or error? AppColors.amkPrimary is maroon. 0xFFD32F2F is red.
                            // I'll keep the specific red but use GoogleFontsless style.
                            color: const Color(0xFFD32F2F),
                            fontSize: (24 * fontScale).toDouble(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: (14 * fontScale).toDouble(),
                                ),
                            children: [
                              const TextSpan(text: 'Pay to '),
                              TextSpan(
                                text: merchantName.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          accountNumber,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),

                        // Divider Area (handled by visual padding usually, clipper handles shape)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomPaint(
                            painter: DashedLinePainter(
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                            size: const Size(double.infinity, 1),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Details List
                        AnimatedCrossFade(
                          firstChild: _buildDetailsList(
                            context,
                            isDarkMode,
                            fontScale,
                          ),
                          secondChild: Container(),
                          crossFadeState: _isExpanded
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 300),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          icon: Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: const Color(0xFFBC346E),
                          ),
                        ),
                        // Footer
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/network/logo_amkpay.png',
                                    width: 40,
                                    package: 'khqr_scan_package',
                                  ),
                                  const SizedBox(width: 8),
                                  // Image has some Khmer text next to logo in screenshot.
                                  // I'll skip text or try to match if possible, but standard logo is fine.
                                  // The screenshot shows custom brand text.
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Mobile App',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFBC346E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Digital Receipt',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFBC346E),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 20),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          icon: Icons.refresh,
                          label: 'Redo',
                          onTap: () {
                            // Redo logic - maybe pop to scan?
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                          },
                        ),
                        const SizedBox(width: 60),
                        _buildActionButton(
                          icon: Icons.share,
                          label: 'Share',
                          onTap: () {
                            Share.share(
                              'Payment of ${widget.amount} to $merchantName successful!',
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Done Button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'DONE',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFBC346E),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsList(
    BuildContext context,
    bool isDarkMode,
    double fontScale,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _buildDetailItem(
            context,
            'Date',
            '07 Mar 2024 07:56 AM',
            isDarkMode: isDarkMode,
            fontScale: fontScale,
          ),
          _buildDetailItem(
            context,
            'From account',
            '507 785 45',
            isDarkMode: isDarkMode,
            fontScale: fontScale,
          ),
          _buildDetailItem(
            context,
            'Transaction ID',
            'FT2983274387236SFYU4',
            isDarkMode: isDarkMode,
            fontScale: fontScale,
          ),
          _buildDetailItem(
            context,
            'Purpose',
            'Pay for goods or services',
            isDarkMode: isDarkMode,
            fontScale: fontScale,
          ),
          _buildDetailItem(
            context,
            'Status',
            'Successful',
            valueColor: Colors.green,
            isDarkMode: isDarkMode,
            fontScale: fontScale,
          ),
          _buildDetailItem(
            context,
            'Amount',
            '40,000 KHR',
            isDarkMode: isDarkMode,
            fontScale: fontScale,
          ),
          _buildDetailItem(
            context,
            'Fee',
            '0 KHR',
            isDarkMode: isDarkMode,
            fontScale: fontScale,
          ),
          const SizedBox(height: 8),
          _buildDetailItem(
            context,
            'Total debit',
            '40,000 KHR',
            isBold: true,
            isDarkMode: isDarkMode,
            fontScale: fontScale,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    String label,
    String value, {
    required bool isDarkMode,
    required double fontScale,
    Color? valueColor,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: (13 * fontScale).toDouble(),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: (13 * fontScale).toDouble(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withAlpha(40), // Semi-transparent white
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    final double notchRadius = 8;
    final double notchY = 220; // Approximate position for the divider notch

    // Create left notch
    path.addOval(
      Rect.fromCircle(center: Offset(0, notchY), radius: notchRadius),
    );
    // Create right notch
    path.addOval(
      Rect.fromCircle(center: Offset(size.width, notchY), radius: notchRadius),
    );

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({
    this.color = const Color(0xFFE0E0E0),
  }); // Default to grey.shade300

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    var max = size.width;
    var dashWidth = 5;
    var dashSpace = 5;
    double startX = 0;
    while (startX < max) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
