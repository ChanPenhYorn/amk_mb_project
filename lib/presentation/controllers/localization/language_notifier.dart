import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'language_state.dart';

part 'language_notifier.g.dart';

@Riverpod(keepAlive: true)
class LanguageNotifier extends _$LanguageNotifier {
  @override
  FutureOr<LanguageState> build() async {
    // Default to English
    return _loadLanguage(const Locale('en'));
  }

  Future<void> changeLanguage(Locale locale) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadLanguage(locale));
  }

  Future<LanguageState> _loadLanguage(Locale locale) async {
    final String langCode = locale.languageCode;
    // Special case for Chinese as the file is 'zh.json' but sometimes we use 'cn'
    final String fileName = langCode == 'zh' ? 'zh' : langCode;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/locales/$fileName.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final Map<String, String> translations = jsonMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );

      return LanguageState(
        locale: locale,
        translations: translations,
        isLoading: false,
      );
    } catch (e) {
      // Fallback to empty translations if file not found
      return LanguageState(locale: locale, translations: {}, isLoading: false);
    }
  }
}
