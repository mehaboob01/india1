import 'package:flutter/material.dart';

import '../constant/theme_manager.dart';
import '../popUps_page.dart';
import 'common_textfield.dart';

class CommonSearchTextField extends StatelessWidget {
  const CommonSearchTextField(
      {super.key,
      required this.itemList,
      required this.label,
      required this.hintText,
      required this.searchCtrl,
      required this.searchHintText,
      required this.itemListNullError,
      this.fieldEnabled,
      this.initialvalue,
      this.inputOnChanged});
  final List<dynamic> itemList;
  final String label;
  final String hintText;
  final TextEditingController searchCtrl;
  final String searchHintText;
  final String itemListNullError;
  final bool? fieldEnabled;
  final String? initialvalue;
  final String? Function(String? value)? inputOnChanged;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      formName: 'search',
      inputController: searchCtrl,
      isfieldEnabled: fieldEnabled ?? true,
      readonly: true,
      fieldOnTap: () {
        DisplayPopuP().getDropDownPopUp(
            context: context,
            itemList: itemList,
            searchCtrl: searchCtrl,
            searchFormName: label,
            searcHintText: searchHintText,
            itemListNullError: itemListNullError);
      },
      suffixIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 25,
        color: AppColors.greyInlineText.withOpacity(0.8),
      ),
      hintText: hintText,
      labelText: label,
      inputValidator: (value) {},
      inputOnChanged: inputOnChanged,
      initialValue: initialvalue,
    );
  }
}
