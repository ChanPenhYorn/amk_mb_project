import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khqr_scan_package/evm_pact_class.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zxing2/qrcode.dart';
import 'package:image/image.dart' as img;

class ScanQRCode extends StatefulWidget {
  final Function(String code)? onScanResult;

  const ScanQRCode({super.key, this.onScanResult});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode>
    with SingleTickerProviderStateMixin {
  final MobileScannerController controller = MobileScannerController();

  bool isScanMode = true;
  bool _isScanned = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 280,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();

    super.dispose();
  }

  String? handleImageQrcode(String path) {
    try {
      final file = File(path);
      if (!file.existsSync()) return null;

      final bytes = file.readAsBytesSync();
      final image = img.decodeImage(bytes);

      if (image == null) return null;

      LuminanceSource source = RGBLuminanceSource(
        image.width,
        image.height,
        image
            .convert(numChannels: 4)
            .getBytes(order: img.ChannelOrder.abgr)
            .buffer
            .asInt32List(),
      );
      var bitmap = BinaryBitmap(GlobalHistogramBinarizer(source));

      var reader = QRCodeReader();
      var result = reader.decode(bitmap);
      return result.text;
    } catch (e) {
      debugPrint('Error decoding QR code from image: $e');
      return null;
    }
  }

  // final List<String> networks = [
  //   'assets/svg/amk.svg',
  //   'assets/svg/khqr.svg',
  //   'assets/svg/o_network.svg',
  //   'assets/svg/lap_net.svg',
  //   'assets/svg/viet_qr.svg',
  //   'assets/svg/duitnow.svg',
  // ];

  final List<String> networks = [
    'assets/images/network/logo_amkpay.png',
    'assets/images/network/logo_khqr.png',
    'assets/images/network/logo_unionpay.png',
    'assets/images/network/logo_amkpay-1.png',
    'assets/images/network/vietqr.png',
    'assets/images/network/duitnow.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFFC04374),
              size: 18,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'Scan & Pay',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background (Live Camera)
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: MobileScanner(
                controller: controller,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final String code = barcodes.first.rawValue ?? "Unknown";
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _handleScanResult(code);
                    });
                  }
                },
              ),
            ),
          ),

          // Custom Overlay
          Positioned.fill(child: _buildScannerOverlay(context)),

          // Content Layer
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Toggle Tab
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 44,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isScanMode = true),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isScanMode
                                  ? const Color(0xFFBC346E)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Scan QR Code',
                              style: GoogleFonts.inter(
                                color: isScanMode
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isScanMode = false),
                          child: Container(
                            decoration: BoxDecoration(
                              color: !isScanMode
                                  ? const Color(0xFFBC346E)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Show QR Code',
                              style: GoogleFonts.inter(
                                color: !isScanMode
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Dropdown Select Service
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Select services available to scan',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  'Scan QR to perform transaction',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),

                const Spacer(),

                // Network Section
                Text(
                  'Our networks',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: networks
                          .map((network) => _buildNetworkLogo(network))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Bottom Buttons
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        Icons.flashlight_on_rounded,
                        'Flash',
                        () {
                          controller.toggleTorch();
                        },
                      ),
                      _buildActionButton(
                        Icons.image_outlined,
                        'Upload QR',
                        () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image == null) return;

                          final String? code = handleImageQrcode(image.path);

                          if (!context.mounted) return;

                          if (code != null) {
                            _handleScanResult(code);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No QR code found in image'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleScanResult(String code) {
    if (!mounted || _isScanned) return;
    if (!EmvSpec().validateCRC(code)) {
      if (context.mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          const SnackBar(content: Text('Invalid QR code')),
        );
      }
      return;
    }

    setState(() {
      _isScanned = true;
    });

    if (widget.onScanResult != null) {
      // Stop the camera to prevent further scans while processing
      controller.stop();
      widget.onScanResult!(code);
      Navigator.of(context).pop(code);
      return;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Scan Successful'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'QR Data:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SelectableText(code),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildScannerOverlay(BuildContext context) {
    return Stack(
      children: [
        // Semi-transparent background with hole using CustomPaint
        Positioned.fill(
          child: CustomPaint(painter: ScannerBackgroundPainter()),
        ),

        // Scan Frame
        Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              // Rounded Corners Frame
              CustomPaint(
                painter: ScannerFramePainter(),
                size: const Size(280, 280),
              ),

              // Animated Red Line
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    top: _animation.value,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.withValues(alpha: 0),
                            Colors.red,
                            Colors.red.withValues(alpha: 0),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.6),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkLogo(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Image.asset(
        name,
        width: 40,
        height: 24,
        fit: BoxFit.cover,
        package: 'khqr_scan_package',
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double cornerRadius = 24;
    final double lineLength = 40;

    // Top Left
    canvas.drawArc(
      Rect.fromLTWH(0, 0, cornerRadius * 2, cornerRadius * 2),
      180 * (3.14159 / 180),
      90 * (3.14159 / 180),
      false,
      paint,
    );
    canvas.drawLine(
      Offset(cornerRadius, 0),
      Offset(cornerRadius + lineLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(0, cornerRadius),
      Offset(0, cornerRadius + lineLength),
      paint,
    );

    // Top Right
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - cornerRadius * 2,
        0,
        cornerRadius * 2,
        cornerRadius * 2,
      ),
      270 * (3.14159 / 180),
      90 * (3.14159 / 180),
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width - cornerRadius, 0),
      Offset(size.width - cornerRadius - lineLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, cornerRadius),
      Offset(size.width, cornerRadius + lineLength),
      paint,
    );

    // Bottom Right
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - cornerRadius * 2,
        size.height - cornerRadius * 2,
        cornerRadius * 2,
        cornerRadius * 2,
      ),
      0 * (3.14159 / 180),
      90 * (3.14159 / 180),
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width - cornerRadius, size.height),
      Offset(size.width - cornerRadius - lineLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height - cornerRadius),
      Offset(size.width, size.height - cornerRadius - lineLength),
      paint,
    );

    // Bottom Left
    canvas.drawArc(
      Rect.fromLTWH(
        0,
        size.height - cornerRadius * 2,
        cornerRadius * 2,
        cornerRadius * 2,
      ),
      90 * (3.14159 / 180),
      90 * (3.14159 / 180),
      false,
      paint,
    );
    canvas.drawLine(
      Offset(cornerRadius, size.height),
      Offset(cornerRadius + lineLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height - cornerRadius),
      Offset(0, size.height - cornerRadius - lineLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ScannerBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.5);

    // Create a path for the full background
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create a path for the scanning hole (rounded rectangle)
    final holePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: 280,
            height: 280,
          ),
          const Radius.circular(24),
        ),
      );

    // Subtract hole from background
    final path = Path.combine(
      PathOperation.difference,
      backgroundPath,
      holePath,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
