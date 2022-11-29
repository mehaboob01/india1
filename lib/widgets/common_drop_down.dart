import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constant/theme_manager.dart';

class DropDown extends StatefulWidget {
  DropDown(
      {required this.data,
        Key? key,
        required this.validationText,
        required this.formName,
        required this.labelName,
        required this.hintText,
        this.initialValue,
        required this.onChanged,
        this.isDropDownEnabled,
         this.onTapped})
      : super(key: key);
  final List<String> data;
  final String validationText;
  final String formName;
  final String labelName;
  final String hintText;
  final String? initialValue;
  final String? Function(String? value) onChanged;
  final bool? isDropDownEnabled;
  final VoidCallback? onTapped;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      onTap: widget.onTapped,
      iconEnabledColor: AppColors.primary,
      iconDisabledColor: Colors.grey,
      name: widget.formName,
      enabled: widget.isDropDownEnabled ?? true,
      validator: (value) => value == null ? widget.validationText : null,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelName,
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
              borderSide: BorderSide(width: 1.0, color: AppColors.primary))),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.greyInlineText,
      ),
      iconSize: 34,
      isExpanded: true,
      elevation: 5,
      initialValue: widget.initialValue,
      items: widget.data.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: AppStyle.shortHeading.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: Dimens.font_16sp),
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        print('this is DropDownValue $value');
        setState(() {
          widget.onChanged(value);

          print('this is onchanged called');
        });
      },
    );
  }
}