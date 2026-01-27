import 'package:flutter/material.dart';

class LanguageState {
  final Locale locale;
  final bool isLoading;
  final Map<String, String> translations;

  LanguageState({
    required this.locale,
    this.isLoading = false,
    this.translations = const {},
  });

  LanguageState copyWith({
    Locale? locale,
    bool? isLoading,
    Map<String, String>? translations,
  }) {
    return LanguageState(
      locale: locale ?? this.locale,
      isLoading: isLoading ?? this.isLoading,
      translations: translations ?? this.translations,
    );
  }
}
