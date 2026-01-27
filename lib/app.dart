import 'package:amk_bank_project/presentation/views/splash/splash_screen.dart';
import 'package:amk_bank_project/core/shared/app_theme.dart';
import 'package:amk_bank_project/presentation/controllers/localization/language_notifier.dart';
import 'package:amk_bank_project/presentation/controllers/theme/theme_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'flavors.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final langState = ref.watch(languageProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: F.title,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeState.isDarkMode == true
          ? ThemeMode.dark
          : ThemeMode.light,
      locale: langState.maybeWhen(
        data: (s) => s.locale,
        orElse: () => const Locale('en'),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(themeState.fontScale)),
          child: langState.when(
            data: (_) => child!,
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Scaffold(
              body: Center(child: Text('Error loading language: $err')),
            ),
          ),
        );
      },
      home: _flavorBanner(child: const SplashScreen(), show: kDebugMode),
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) => show
      ? Banner(
          location: BannerLocation.topStart,
          message: F.name,
          color: Colors.green.withAlpha(150),
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            letterSpacing: 1.0,
          ),
          textDirection: TextDirection.ltr,
          child: child,
        )
      : Container(child: child);
}
