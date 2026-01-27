import 'package:amk_bank_project/presentation/controllers/localization/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension ThemeContext on BuildContext {
  /// The [ColorScheme] from the closest [Theme] instance that encloses the given context.
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension TranslationExtension on String {
  String tr(WidgetRef ref) {
    final langState = ref.watch(languageProvider);
    return langState.maybeWhen(
      data: (state) => state.translations[this] ?? this,
      orElse: () => this,
    );
  }
}
