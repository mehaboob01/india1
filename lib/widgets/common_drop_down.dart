import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';
class DropDown extends StatefulWidget {
  const DropDown(
      {required this.data,
        Key? key,
        required this.validationText,
        required this.formName,
        required this.labelName,
        required this.hintText,
        this.initialValue,
        required this.onChanged})
      : super(key: key);
  final List<String> data;
  final String validationText;
  final String formName;
  final String labelName;
  final String hintText;
  final String? initialValue;
  final String? Function(String? value) onChanged;


  @override
  _DropDownState createState() => _DropDownState();
}
class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      iconEnabledColor: AppColors.primary,
      iconDisabledColor: Colors.grey,
      name: widget.formName,
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
              color: AppColors.greyText,
              fontWeight: FontWeight.w400,
              fontSize: 12.0.sp),
          contentPadding:
          EdgeInsets.symmetric(vertical: 4.0.wp, horizontal: 4.0.wp),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.0.wp),
              borderSide: const BorderSide(
                  width: 1.0, color: AppColors.greyInlineTextborder)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.0.wp),
              borderSide: const BorderSide(
                  width: 1.0, color: AppColors.greyInlineTextborder)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.0.wp),
              borderSide:  BorderSide(
                  width: 1.0, color: AppColors.primary))),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
       // color: AppColors.greyInlineText,
      ),
      iconSize: 30,
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
                fontWeight: FontWeight.w600,
                fontSize: 11.0.sp),
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          widget.onChanged(value);

          print('this is onchanged called');
        });
      },
    );
  }
}