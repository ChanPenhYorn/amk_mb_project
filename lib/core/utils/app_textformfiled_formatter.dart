import 'package:flutter/services.dart';

class AppTextformfiledFormatter {
  static TextInputFormatter englishNameFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final formattedText = newValue.text.toUpperCase(); // Convert to uppercase
      return TextEditingValue(
        text: formattedText,
        selection: newValue.selection,
      );
    });
  }

  static TextInputFormatter toUpperCaseFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      return TextEditingValue(
        text: newValue.text.toUpperCase(), // Converts the input to uppercase
        selection: newValue.selection,
      );
    });
  }

  static TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase().toString(),
      selection: newValue.selection,
    );
  }

// ✅ Phone number formatter (XXX XXX XXX or XXX XXX XXXX)
  static TextInputFormatter phoneInputFormatter() {
    return TextInputFormatter.withFunction(
      (oldValue, newValue) => khmerPhoneFormatEditUpdate(oldValue, newValue),
    );
  }

  static TextEditingValue khmerPhoneFormatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    if (digitsOnly.startsWith('855')) {
      // Format like: 855 819 641 69 or 855 819 641 690
      for (int i = 0; i < digitsOnly.length; i++) {
        buffer.write(digitsOnly[i]);
        if (i == 2 || i == 5 || i == 8) buffer.write(' ');
      }
    } else if (digitsOnly.startsWith('0')) {
      // ✅ Support both 9-digit (xxx xxx xxx) and 10-digit (xxx xxx xxxx)
      for (int i = 0; i < digitsOnly.length; i++) {
        buffer.write(digitsOnly[i]);

        // Insert space after 3rd and 6th digit
        if (i == 2 || i == 5) buffer.write(' ');
      }
    } else {
      // Other numbers — group in 3s
      for (int i = 0; i < digitsOnly.length; i++) {
        buffer.write(digitsOnly[i]);
        if ((i + 1) % 3 == 0 && i + 1 != digitsOnly.length) buffer.write(' ');
      }
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
