import 'package:amk_bank_project/core/utils/app_colors.dart';
import 'package:amk_bank_project/core/utils/enum/app_textformfield_enum.dart';
import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:amk_bank_project/presentation/controllers/country/country_notifier.dart';
import 'package:amk_bank_project/presentation/controllers/country/country_state.dart';
import 'package:amk_bank_project/presentation/controllers/localization/language_notifier.dart';
import 'package:amk_bank_project/presentation/controllers/theme/theme_notifier.dart';
import 'package:amk_bank_project/presentation/widgets/app_button_widget.dart';
import 'package:amk_bank_project/presentation/widgets/app_dropdown_button.dart';
import 'package:amk_bank_project/presentation/widgets/app_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSettingsScreen extends ConsumerStatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  ConsumerState<ThemeSettingsScreen> createState() =>
      _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends ConsumerState<ThemeSettingsScreen> {
  // Text Controllers for the input section
  final _searchController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('ThemeSettingsScreen build');
    final themeState = ref.watch(themeProvider);
    final countryState = ref.watch(countryProvider);

    final isDarkMode = themeState.isDarkMode ?? false;
    final fontScale = themeState.fontScale;

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.bac,
      appBar: AppBar(
        title: Text(
          'Banking App Theme & Settings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: AppColors.amkPrimary,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: Colors.white,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Language Selector
            _buildSectionCard(
              title: 'Language / ភាសា / 语言',
              child: _buildLanguageSelector(),
            ),
            const SizedBox(height: 16),

            // Font Scale
            _buildSectionCard(
              title: 'Font Scale: ${fontScale.toStringAsFixed(1)}x',
              child: _buildFontScaler(fontScale),
            ),
            const SizedBox(height: 16),

            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome to Banking App',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Custom Gradient Background',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Color Palette
            _buildSectionCard(
              title: 'Color Palette',
              child: _buildColorPalette(fontScale),
            ),
            const SizedBox(height: 16),

            // Typography
            _buildSectionCard(
              title: 'Typography',
              child: _buildTypography(fontScale, isDarkMode),
            ),
            const SizedBox(height: 16),

            // Custom Buttons
            _buildSectionCard(
              title: 'Custom Buttons',
              child: _buildCustomButtons(),
            ),
            const SizedBox(height: 16),

            // Custom Input Fields
            _buildSectionCard(
              title: 'Custom Input Fields',
              child: _buildCustomInputs(),
            ),

            const SizedBox(height: 16),

            // Custom Dropdown Button
            _buildSectionCard(
              title: 'Custom Dropdown Button',
              child: AppDropdownButtonWidget(
                onChanged: (value) {
                  if (value != null) {
                    ref.read(countryProvider.notifier).selectCountry(value);
                  }
                },
                items: countryState.countries,
                selectedValue: countryState.selectedCountry,
              ),
            ),
            const SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    final languageState = ref.watch(languageProvider);
    final currentLang = languageState.hasValue
        ? languageState.value!.locale.languageCode
        : 'en';

    return Row(
      children: [
        Expanded(child: _buildLangItem('Khmer', 'km', currentLang)),
        const SizedBox(width: 8),
        Expanded(child: _buildLangItem('Chinese', 'zh', currentLang)),
        const SizedBox(width: 8),
        Expanded(child: _buildLangItem('English', 'en', currentLang)),
      ],
    );
  }

  Widget _buildLangItem(String label, String code, String currentLang) {
    final isSelected = currentLang == code;
    return GestureDetector(
      onTap: () {
        ref.read(languageProvider.notifier).changeLanguage(Locale(code));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.amkPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.amkPrimary : Colors.grey.shade300,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dummy logic for language text, can be improved
            Text(
              code == 'km'
                  ? 'ខ្មែរ'
                  : code == 'zh'
                  ? '中文'
                  : 'English',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
            if (isSelected) ...[
              // Optional: Show "Current" text or similar if needed?
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFontScaler(double currentScale) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (currentScale > 0.5) {
                  ref
                      .read(themeProvider.notifier)
                      .setFontScale(currentScale - 0.1);
                }
              },
              icon: const Icon(Icons.remove),
            ),
            Expanded(
              child: Slider(
                value: currentScale,
                min: 1,
                max: 1.5,
                divisions: 5,
                activeColor: AppColors.amkPrimary,
                onChanged: (val) {
                  ref.read(themeProvider.notifier).setFontScale(val);
                },
              ),
            ),
            IconButton(
              onPressed: () {
                if (currentScale < 2.0) {
                  ref
                      .read(themeProvider.notifier)
                      .setFontScale(currentScale + 0.1);
                }
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).resetFontScale();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        Text(
          'Font: Inter (All text uses Inter font with custom scaling)',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildColorPalette(double fontScale) {
    return Column(
      children: [
        _buildColorRow(AppColors.amkPrimary, 'Primary'),
        const SizedBox(height: 8),
        _buildColorRow(
          AppColors.amkPrimary.withOpacity(0.6),
          'Primary Light',
        ), // Approximated
        const SizedBox(height: 8),
        _buildColorRow(
          const Color(0xFF7A1E4A),
          'Primary Dark',
        ), // Approximated dark maroon
      ],
    );
  }

  Widget _buildColorRow(Color color, String label) {
    final fontScale = ref.read(themeProvider).fontScale;
    final isDarkMode = ref.read(themeProvider).isDarkMode ?? false;

    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildTypography(double fontScale, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Display Large', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('Headline Medium', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text('Title Large', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('Body Large', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        Text('Body Medium', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildCustomButtons() {
    return Column(
      children: [
        AppPrimaryButton(
          text: 'Primary Button',
          onPressed: () {},
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        const AppPrimaryButton(
          text: 'Primary Disabled',
          onPressed: null, // Disabled
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        AppPrimaryButton(
          text: 'With Icon',
          onPressed: () {},
          icon: Icons.arrow_forward,
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        AppPrimaryButton(
          text: 'Loading',
          onPressed: () {},
          isLoading: true,
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        AppOutlineButton(
          text: 'Outline Button',
          onPressed: () {},
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        const AppOutlineButton(
          text: 'Outline Disabled',
          onPressed: null,
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        AppOutlineButton(
          text: 'With Icon',
          onPressed: () {},
          icon: Icons.send,
          width: double.infinity,
        ),
      ],
    );
  }

  Widget _buildCustomInputs() {
    return Column(
      children: [
        AppTextformfieldWidget(
          controller: _searchController,
          label: 'Search...',
          hintText: 'Search...', // Khmer text in screenshot: លេខសម្គាល់ ឬ ខ្មែរ
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(
            Icons.visibility_off_outlined,
          ), // Just to match icon presence
          // label: '',
        ),
        const SizedBox(height: 12),
        AppTextformfieldWidget(
          controller: _emailController,
          type: AppTextformfieldEnum.email,
          label: 'Email',
          hintText: 'Email',
          prefixIcon: const Icon(Icons.email),
        ),
        const SizedBox(height: 12),
        AppTextformfieldWidget(
          controller: _phoneController,
          type: AppTextformfieldEnum.phone,
          label: 'Phone Number',
          hintText: 'Phone Number',
          prefixIcon: const Icon(Icons.phone),
        ),
      ],
    );
  }

  Widget _buildCustomDropdownButton(CountryState countryState) {
    return Column(
      children: [
        AppDropdownButtonWidget(
          onChanged: (value) {},
          items: countryState.countries,
          selectedValue: null,
        ),
      ],
    );
  }
}
