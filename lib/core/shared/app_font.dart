import 'package:flutter/material.dart';

class AppFont {
  static String fontFamily = 'KantumruyPro';

  static TextStyle getTextStyle({
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    FontSize fontSize = FontSize.medium,
    double? fontSizeValue,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: fontSizeValue ??
          (fontSize == FontSize.small
              ? 12.0
              : fontSize == FontSize.medium
                  ? 14.0
                  : fontSize == FontSize.large
                      ? 16.0
                      : 14.0),
      color: color,
    );
  }

  static TextStyle bold({
    FontSize fontSize = FontSize.medium,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
    double? fontSizeValue,
  }) {
    return getTextStyle(
      fontWeight: fontWeight,
      fontSizeValue: fontSizeValue,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle medium({
    FontSize fontSize = FontSize.medium,
    Color color = Colors.black,
    double? fontSizeValue,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return getTextStyle(
      fontWeight: fontWeight,
      fontSizeValue: fontSizeValue,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle italic({
    FontSize fontSize = FontSize.medium,
    Color color = Colors.black,
    double? fontSizeValue,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return getTextStyle(
      fontStyle: FontStyle.italic,
      fontSizeValue: fontSizeValue,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle regular({
    FontSize fontSize = FontSize.medium,
    Color color = Colors.black,
    double? fontSizeValue,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return getTextStyle(
      fontWeight: fontWeight,
      fontSizeValue: fontSizeValue,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle semiBold({
    FontSize fontSize = FontSize.medium,
    Color color = Colors.black,
    double? fontSizeValue,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return getTextStyle(
      fontWeight: fontWeight,
      fontSizeValue: fontSizeValue,
      fontSize: fontSize,
      color: color,
    );
  }
}

enum FontSize {
  small,
  medium,
  large,
}
