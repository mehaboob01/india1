import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {this.hintText,
      this.labelText,
      this.maxlines = 1,
      this.keyboardType = TextInputType.text,
        this.inputController,
      required this.inputValidator,
      this.inputOnChanged,
      this.isObscure = false,
      this.inputOnSubmitted,
      required this.formName,
      this.initialValue,
      this.isfieldEnabled});
  final String? hintText;
  final String? labelText;
  final int maxlines;
  final TextInputType keyboardType;
  final TextEditingController? inputController;
  final String? Function(String? value) inputValidator;
  final void Function(dynamic)? inputOnChanged;
  final void Function(dynamic)? inputOnSubmitted;
  final bool isObscure;
  final String formName;
  final String? initialValue;
  final bool? isfieldEnabled;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: formName,
      enabled: isfieldEnabled ?? true,
      initialValue: initialValue ?? null,
      controller: inputController,
      maxLines: maxlines,
      keyboardType: keyboardType,
      validator: inputValidator,
      obscureText: isObscure,
      onChanged: inputOnChanged,
      style: AppStyle.shortHeading.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: 11.0.sp),
      decoration: InputDecoration(
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 4.0.wp, horizontal: 4.0.wp),
          hintText: hintText, //'Slide the amount above or enter', // dynamic
          hintStyle: AppStyle.shortHeading.copyWith(
              color: AppColors.greyInlineText,
              fontWeight: FontWeight.w400,
              fontSize: 11.0.sp),
          label: Text(
            labelText!, //'Points for cashback', // dynamic
            style: AppStyle.shortHeading.copyWith(
                color: AppColors.greyInlineText,
                fontWeight: FontWeight.w400,
                fontSize: 11.0.sp),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorStyle: AppStyle.shortHeading.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 11.0.sp,
              color: Colors.red),
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
    );
  }
}
