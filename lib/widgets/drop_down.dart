import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constant/theme_manager.dart';

class DropDown extends StatefulWidget {
  const DropDown({
    required this.data,
    required this.hint,
    Key? key,
    required this.validationText,
    required this.formName,
  }) : super(key: key);
  final List<String> data;
  final String hint;
  final String validationText;
  final String formName;
  @override
  _DropDownState createState() => _DropDownState();
}
class _DropDownState extends State<DropDown> {
  String? _chosenValue1;
  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: widget.formName,
      validator: (value) => value == null ? widget.validationText : null,
      decoration: InputDecoration(
          labelText: 'Bank Name',
          labelStyle: AppStyle.shortHeading.copyWith(
              color: AppColors.greyInlineText,
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
              borderSide: const BorderSide(
                  width: 1.0, color: AppColors.greyInlineTextborder))),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.greyInlineText,
      ),
      iconSize: 30,
      isExpanded: true,
      initialValue: _chosenValue1,
      elevation: 5,
      items: widget.data.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: AppStyle.shortHeading.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 11.0.sp),
          ),
        );
      }).toList(),
      // hint: Text(
      //   widget.hint,
      //   style: AppStyle.shortHeading.copyWith(
      //       color: AppColors.greyInlineText,
      //       fontWeight: FontWeight.w400,
      //       fontSize: 11.0.sp),
      // ),
      onChanged: (String? value) {
        setState(() {
          _chosenValue1 = value;
        });
      },
    );
  }
}