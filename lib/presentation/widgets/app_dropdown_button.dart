import 'package:amk_bank_project/core/utils/app_colors.dart';
import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'app_textformfield_widget.dart';

class AppDropdownButtonWidget extends StatelessWidget {
  const AppDropdownButtonWidget({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.hintText,
    this.isEnabled = true,
    this.searchController,
    this.isSearch = false,
    this.backgroundColor,
    this.hintStyle,
    this.model,
    this.selectColor,
    this.padding,
  });

  final List<NameModel> items;
  final NameModel? selectedValue;
  final void Function(NameModel?)? onChanged;
  final String? hintText;
  final bool isEnabled;
  final TextEditingController? searchController;
  final bool isSearch;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final dynamic model;
  final Color? selectColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<NameModel>(
      underline: const SizedBox(),
      isExpanded: true,
      value: selectedValue,
      onChanged: isEnabled ? onChanged : null,
      hint: Text(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        hintText ?? 'Select an option',
        style:
            hintStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.grey,
              overflow: TextOverflow.ellipsis,
            ),
      ),
      style: Theme.of(
        context,
      ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      items: items.map<DropdownMenuItem<NameModel>>((NameModel value) {
        return DropdownMenuItem<NameModel>(
          value: value,
          child: Text(
            value.name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: value.name == selectedValue?.name
                  ? selectColor ?? AppColors.primary
                  : Theme.of(context).textTheme.bodyMedium!.color,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
      buttonStyleData: ButtonStyleData(
        padding: padding ?? EdgeInsets.only(right: 10, top: 4, bottom: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey!),
          color: backgroundColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(),
      dropdownSearchData: isSearch
          ? DropdownSearchData(
              searchController: searchController,
              // searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: AppTextformfieldWidget(
                  isRequried: false,
                  controller: searchController!,
                  hintText: 'label.search',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value!.name.toString().contains(searchValue);
              },
            )
          : null,
      onMenuStateChange: isSearch
          ? (isOpen) {
              if (!isOpen) {
                searchController!.clear();
              }
            }
          : null,
    );
  }
}
