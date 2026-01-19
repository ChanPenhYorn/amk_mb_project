import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  /// The [ColorScheme] from the closest [Theme] instance that encloses the given context.
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
