import 'package:amk_bank_project/core/shared/app_font.dart';
import 'package:amk_bank_project/core/shared/app_string.dart';
import 'package:amk_bank_project/core/shared/extensions.dart';
import 'package:amk_bank_project/core/utils/app_colors.dart';
import 'package:amk_bank_project/presentation/controllers/auth/login_notifier.dart';
import 'package:amk_bank_project/presentation/controllers/localization/language_notifier.dart';
import 'package:amk_bank_project/presentation/views/auth/signup_screen.dart';
import 'package:amk_bank_project/presentation/views/home/home_screen.dart';
import 'package:amk_bank_project/presentation/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);

    ref.listen(loginProvider, (previous, next) {
      if (next.user != null && !next.isLoading) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Gradient Overlay
          Positioned.fill(
            child: Image.asset(
              'assets/images/amk_splash.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.amkPrimary.withOpacity(0.8),
                    AppColors.amkPrimary.withOpacity(0.2),
                    Colors.white.withOpacity(0.9),
                    Colors.white,
                  ],
                  stops: const [0.0, 0.4, 0.6, 0.8],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Header with Logo and Language Selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: 'app_logo',
                        child: Image.asset(
                          'assets/images/amk_no_bg.png',
                          height: 60,
                          color: Colors.white,
                        ),
                      ),
                      const LanguageSelectorPill(),
                    ],
                  ),
                ),

                const Spacer(),

                // Main Login Card area
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppPrimaryButton(
                          text: AppString.signIn.tr(ref),
                          width: double.infinity,
                          isLoading: state.isLoading,
                          onPressed: () => ref
                              .read(loginProvider.notifier)
                              .login('test@amk.com', 'password123'),
                        ),
                        const SizedBox(height: 16),
                        AppOutlineButton(
                          text: AppString.signUp.tr(ref),
                          width: double.infinity,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                AppString.noAccountMsg.tr(ref),
                                style: AppFont.regular(
                                  fontSizeValue: 12,
                                  color: Colors.grey[600]!,
                                ),
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              AppString.selfAccountOpening.tr(ref),
                              textAlign: TextAlign.center,
                              style: AppFont.bold(
                                fontSizeValue: 14,
                                color: AppColors.amkPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Footer Actions
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _FooterItem(
                        icon: Icons.chat_bubble_outline,
                        label: AppString.chat.tr(ref),
                        onTap: () {},
                      ),
                      _FooterItem(
                        icon: Icons.phone_in_talk_outlined,
                        label: AppString.contactUs.tr(ref),
                        onTap: () {},
                      ),
                      _FooterItem(
                        icon: Icons.info_outline,
                        label: AppString.aboutAmk.tr(ref),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (state.error != null)
            Positioned(
              bottom: 150,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class LanguageSelectorPill extends ConsumerWidget {
  const LanguageSelectorPill({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langState = ref.watch(languageProvider);
    final currentLocale = langState.maybeWhen(
      data: (s) => s.locale,
      orElse: () => const Locale('en'),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageOption(
            flag: 'assets/images/united-kingdom.png',
            label: 'EN',
            isSelected: currentLocale.languageCode == 'en',
            onTap: () => ref
                .read(languageProvider.notifier)
                .changeLanguage(const Locale('en')),
          ),
          _LanguageOption(
            flag: 'assets/images/china.png',
            label: '中文',
            isSelected: currentLocale.languageCode == 'zh',
            onTap: () => ref
                .read(languageProvider.notifier)
                .changeLanguage(const Locale('zh')),
          ),
          _LanguageOption(
            flag: 'assets/images/cambodia.png',
            label: 'ខ្មែរ',
            isSelected: currentLocale.languageCode == 'km',
            onTap: () => ref
                .read(languageProvider.notifier)
                .changeLanguage(const Locale('km')),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[200] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                flag,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppFont.bold(
                fontSizeValue: 10,
                color: isSelected ? AppColors.amkPrimary : Colors.grey[600]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FooterItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.amkPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppFont.medium(
              fontSizeValue: 12,
              color: AppColors.amkPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
