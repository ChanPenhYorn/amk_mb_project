import 'package:amk_bank_project/core/shared/app_string.dart';
import 'package:amk_bank_project/core/utils/app_colors.dart';
import 'package:amk_bank_project/core/utils/app_reqex.dart';
import 'package:amk_bank_project/core/utils/app_textformfiled_formatter.dart'
    show AppTextformfiledFormatter;
import 'package:amk_bank_project/core/utils/enum/app_textformfield_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextformfieldWidget extends StatelessWidget {
  const AppTextformfieldWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.prefixOnTap,
    this.suffixOnTap,
    this.type,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.isRequried = true,
    this.isEnable = true,
    this.maxLines,
    this.minLines,
    this.textStyle,
    this.contentPadding,
    this.focusNode,
    this.fillColor,
    this.maxLength,
    this.borderRadius,
    this.autofocus,
    this.borderSide,
    this.onFieldSubmitted,
    this.label,
  });
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final void Function()? prefixOnTap;
  final void Function()? suffixOnTap;
  final AppTextformfieldEnum? type;
  final AutovalidateMode? autovalidateMode;
  final bool? isRequried;
  final bool isEnable;
  final int? maxLines;
  final int? minLines;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final Color? fillColor;
  final int? maxLength;
  final BorderRadius? borderRadius;
  final bool? autofocus;
  final BorderSide? borderSide;
  final void Function(String)? onFieldSubmitted;
  final String? label;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatters = _getInputFormatters(
      type,
      controller,
    );

    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus ?? false,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      focusNode: focusNode,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      enabled: isEnable,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      textAlign: textAlign,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      controller: controller,
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        label: Text(label ?? '', style: Theme.of(context).textTheme.bodyMedium),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.amkPrimary),
        ),
      ),
      onChanged: onChanged,
      validator: validationMethod,
    );
  }

  List<TextInputFormatter>? _getInputFormatters(
    AppTextformfieldEnum? type,
    TextEditingController? controller,
  ) {
    switch (type) {
      case AppTextformfieldEnum.phone:
        return [AppTextformfiledFormatter.phoneInputFormatter()];
      case AppTextformfieldEnum.name:
        return [AppTextformfiledFormatter.toUpperCaseFormatter()];
      case AppTextformfieldEnum.password:
      default:
        return []; // Default case, no special formatting
    }
  }

  String? validationMethod(String? value) {
    if (value == null || value.isEmpty && isRequried == true) {
      return AppString.fieldRequired;
    }

    switch (type) {
      case AppTextformfieldEnum.email:
        if (!AppReqex().emailRegex.hasMatch(value)) {
          return AppString.invalidEmailFormat;
        }
        break;
      case AppTextformfieldEnum.name:
        if (!AppReqex().englishNameRegexp.hasMatch(value)) {
          return AppString.nameShouldContainEnglishCharactersOnly;
        }
        break;
      case AppTextformfieldEnum
          .password: // Corrected the typo from 'passwoord' to 'password'
        if (!AppReqex().passwordRegexp.hasMatch(value)) {
          // return 'message.password_at_least'.tr; // Improved message
          return AppString.passwordMustBeAtLeast6CharactersLong;
        }
        break;
      case AppTextformfieldEnum.phone:
        if (!AppReqex().khmerPhoneRegexp.hasMatch(value)) {
          return AppString.invalidPhoneNumberFormat;
        }
      default:
        break; // Default case, no validation
    }

    return null; // Return null if validation passes
  }
}
