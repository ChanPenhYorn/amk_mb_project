import 'package:amk_bank_project/presentation/controllers/splash/splash_notifier.dart';
import 'package:amk_bank_project/presentation/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start initialization after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen for state change to navigate
    ref.listen(splashProvider, (previous, next) {
      if (next is AsyncData && !next.value!.isLoading) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: Hero(
        transitionOnUserGestures: true,
        tag: 'app_logo',
        child: Image.asset('assets/images/amk_splash.jpg'),
      ),
    );
  }
}
