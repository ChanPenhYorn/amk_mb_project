import 'dart:convert';

import 'package:amk_bank_project/core/utils/app_logger.dart';
import 'package:amk_bank_project/presentation/views/home/dashboard_view.dart';
import 'package:amk_bank_project/core/shared/app_font.dart';
import 'package:amk_bank_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amk_bank_project/presentation/views/khqr_scan_pay/pay_screen.dart';
import 'package:amk_bank_project/presentation/views/settings/theme_settings_screen.dart';
import 'package:khqr_scan_package/evm_pact_class.dart';
import 'package:khqr_scan_package/scan_qrcode.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardView(),
    const Center(child: Text("Cards")),
    const Center(child: Text("Scan")),
    const Center(child: Text("Chat")),
    const Center(child: Text("Others")),
  ];

  Future<void> scanAndPay() async {
    String? scanResult;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanQRCode(
          onScanResult: (result) {
            scanResult = result;

            final evmSpec = EmvSpec();
            final parsedResult = evmSpec.parseSubTags(result);

            AppLogger.logInfo("Scan result: ${json.encode(parsedResult)}");
          },
        ),
      ),
    );
    if (result != null && scanResult != null) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PayScreen(
              merchantName: 'Natura Cafe',
              accountNumber: '900010000101013',
              bankName: 'AMK Microfinance Plc.',
            ),
          ),
        );
      }
    }
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      scanAndPay();
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/amk_no_bg.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeSettingsScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_rounded,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_outline_rounded,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, left: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.amkPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        selectedItemColor: AppColors.amkPrimary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: AppFont.bold(fontSizeValue: 12),
        unselectedLabelStyle: AppFont.medium(fontSizeValue: 12),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_rounded),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.amkPrimary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.amkPrimary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Others',
          ),
        ],
      ),
    );
  }
}
