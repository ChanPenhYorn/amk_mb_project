class ThemeState {
  final bool? isDarkMode;
  final double fontScale;

  ThemeState({required this.isDarkMode, this.fontScale = 1.0});

  ThemeState copyWith({bool? isDarkMode, double? fontScale}) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      fontScale: fontScale ?? this.fontScale,
    );
  }
}
