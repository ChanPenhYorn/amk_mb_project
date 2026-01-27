import 'package:amk_bank_project/core/shared/app_font.dart';
import 'package:amk_bank_project/core/shared/app_string.dart';
import 'package:amk_bank_project/core/shared/extensions.dart';
import 'package:amk_bank_project/core/utils/app_colors.dart';
import 'package:amk_bank_project/core/utils/enum/app_textformfield_enum.dart';
import 'package:amk_bank_project/presentation/controllers/auth/signup_notifier.dart';
import 'package:amk_bank_project/presentation/views/auth/login_screen.dart';
import 'package:amk_bank_project/presentation/widgets/app_button_widget.dart';
import 'package:amk_bank_project/presentation/widgets/app_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signupProvider);

    ref.listen(signupProvider, (previous, next) {
      if (!next.isLoading && next.error == null && next.user == null) {
        // Assuming success if not loading and no error (and we might check a success flag if we had one)
        // Since our mock just sets loading false on success:
         if (previous?.isLoading == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Signup Successful! Please Login.')),
            );
            Navigator.pop(context);
         }
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Gradient Overlay (Reusing Login Style)
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
                const SizedBox(height: 10),
                // Header with Back Button and Language Selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const LanguageSelectorPill(),
                    ],
                  ),
                ),
                
                // Logo
                Hero(
                  tag: 'app_logo',
                  child: Image.asset(
                    'assets/images/amk_no_bg.png',
                    height: 50,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // Main Signup Card area
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                AppString.signUp.tr(ref),
                                textAlign: TextAlign.center,
                                style: AppFont.bold(
                                  fontSizeValue: 24,
                                  color: AppColors.amkPrimary,
                                ),
                              ),
                              const SizedBox(height: 20),
                              
                              AppTextformfieldWidget(
                                controller: _nameController,
                                label: AppString.fullName.tr(ref),
                                hintText: "Enter your name",
                                type: AppTextformfieldEnum.name,
                                prefixIcon: const Icon(Icons.person_outline),
                              ),
                              const SizedBox(height: 16),
                              
                              AppTextformfieldWidget(
                                controller: _phoneController,
                                label: AppString.phoneNumber.tr(ref),
                                hintText: "0xx xxx xxx",
                                type: AppTextformfieldEnum.phone,
                                keyboardType: TextInputType.phone,
                                prefixIcon: const Icon(Icons.phone_android),
                              ),
                              const SizedBox(height: 16),
                              
                              AppTextformfieldWidget(
                                controller: _passwordController,
                                label: "Password", // TODO: Add to AppString if strictly needed, using literal for now or reuse login hint
                                hintText: "******",
                                type: AppTextformfieldEnum.password,
                                obscureText: true,
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),
                              const SizedBox(height: 16),
                              
                              AppTextformfieldWidget(
                                controller: _confirmPasswordController,
                                label: AppString.confirmPassword.tr(ref),
                                hintText: "******",
                                type: AppTextformfieldEnum.password,
                                obscureText: true,
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),

                              const SizedBox(height: 24),
                              
                              AppPrimaryButton(
                                text: AppString.signUp.tr(ref),
                                width: double.infinity,
                                isLoading: state.isLoading,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ref.read(signupProvider.notifier).signup(
                                      _nameController.text,
                                      _phoneController.text,
                                      _passwordController.text,
                                      _confirmPasswordController.text,
                                    );
                                  }
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppString.alreadyHaveAccount.tr(ref),
                                    style: AppFont.regular(
                                      fontSizeValue: 14,
                                      color: Colors.grey[600]!,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      AppString.signIn.tr(ref),
                                      style: AppFont.bold(
                                        fontSizeValue: 14,
                                        color: AppColors.amkPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (state.error != null)
            Positioned(
              bottom: 20,
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
