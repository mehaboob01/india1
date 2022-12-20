// ----------------------------- dropdown with search ------------------------------------------

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../constant/theme_manager.dart';

class SearchDropDown extends StatefulWidget {
  SearchDropDown(
      {super.key,
      required this.itemList,
      required this.validationText,
      required this.formkey,
      required this.labelName,
      required this.hintText,
      required this.onChanged,
      this.selectedValue,
      this.initialValue,
      this.searchIconColor,
      this.isDropDownEnabled,
      this.searchHintText,
      this.isforProfileScreen = false});

  final List<String> itemList;

  final String validationText;
  final GlobalKey formkey;
  final String labelName;
  final String hintText;
  final String? initialValue;
  String? selectedValue;
  final String? searchHintText;
  final bool? isDropDownEnabled;
  void Function(String?) onChanged;
  bool isforProfileScreen;
  Color? searchIconColor;
  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  bool isSearchOpen = false;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: DropdownSearch<String>(
        enabled: widget.isDropDownEnabled ?? true,
        selectedItem: widget.selectedValue == '' ? null : widget.selectedValue,
        items: widget.itemList,
        onChanged: widget.onChanged,
        popupProps: PopupProps.dialog(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
                controller: controller,
                // autofocus: true,
                onTap: () {
                  isSearchOpen = true;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.clear();
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColors.greyInlineText,
                    ),
                  ),
                  hintText: widget.searchHintText ?? null,
                  hintStyle: AppStyle.shortHeading.copyWith(
                      color: AppColors.greyInlineText,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0.sp),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 1.0.hp, horizontal: 4.0.wp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.0.wp),
                      borderSide: BorderSide(
                          width: 1.0, color: AppColors.greyInlineTextborder)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.0.wp),
                      borderSide: BorderSide(
                          width: 1.0, color: AppColors.greyInlineTextborder)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.0.wp),
                      borderSide: BorderSide(
                          width: 1.0, color: Theme.of(context).primaryColor)),
                )),
            dialogProps: DialogProps(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
        validator: (value) => value == null ? widget.validationText : null,
        dropdownButtonProps: DropdownButtonProps(
          iconSize: 34,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.greyInlineText,
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: widget.labelName,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: widget.hintText,
            hintStyle: AppStyle.shortHeading.copyWith(
                color: AppColors.greyInlineText,
                fontWeight: FontWeight.w400,
                fontSize: 12.0.sp),
            labelStyle: AppStyle.shortHeading.copyWith(
                color: AppColors.greyInlineText,
                fontWeight: FontWeight.w400,
                fontSize: 12.0.sp),
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.0.hp, horizontal: 4.0.wp),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0.wp),
                borderSide: BorderSide(
                    width: 1.0, color: AppColors.greyInlineTextborder)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0.wp),
                borderSide: BorderSide(
                    width: 1.0, color: AppColors.greyInlineTextborder)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0.wp),
                borderSide: BorderSide(width: 1.0, color: Colors.blue)),
          ),
        ),
      ),
    );
  }
}
