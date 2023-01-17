import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constant/theme_manager.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    this.hintText,
    this.labelText,
    this.inUperCase,
    this.maxlines = 1,
    this.keyboardType = TextInputType.text,
    this.inputController,
    required this.inputValidator,
    this.inputOnChanged,
    this.isAutoValidate,
    this.isObscure = false,
    this.inputOnSubmitted,
    this.isUpperCase,
    this.inputFormat,
    this.suffixIcon,
    required this.formName,
    this.initialValue,
    this.isfieldEnabled,
    this.focus,
    this.fieldOnTap,
    this.floatingBehavior,
    this.readonly,
  });
  final String? hintText;
  final String? labelText;
  final bool? inUperCase;
  final int maxlines;
  final FocusNode? focus;
  final TextInputType keyboardType;
  final TextEditingController? inputController;
  final String? Function(String? value) inputValidator;
  final String? Function(String? value)? inputOnChanged;
  final String? Function(String? value)? inputOnSubmitted;
  final VoidCallback? fieldOnTap;
  final bool isObscure;
  final List<TextInputFormatter>? inputFormat;
  final String formName;
  final String? initialValue;
  final bool? isfieldEnabled;
  final bool? isAutoValidate;
  final bool? isUpperCase;
  final bool? readonly;
  final FloatingLabelBehavior? floatingBehavior;

  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      readOnly: readonly ?? false,
      autofocus: false,
      focusNode: focus,
      name: formName,
      onTap: fieldOnTap,
      textCapitalization: isUpperCase == true
          ? TextCapitalization.characters
          : TextCapitalization.none,
      enabled: isfieldEnabled ?? true,
      initialValue: initialValue ?? null,
      controller: inputController,
      autovalidateMode: isAutoValidate == true
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      maxLines: maxlines,
      inputFormatters: inputFormat,
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
          suffixIcon: suffixIcon ?? null,
          contentPadding:
              EdgeInsets.symmetric(vertical: 4.0.wp, horizontal: 4.0.wp),
          hintText: hintText, //'Slide the amount above or enter', // dynamic
          hintStyle: AppStyle.shortHeading.copyWith(
              color: AppColors.greyInlineText,
              fontWeight: FontWeight.w400,
              fontSize: 11.0.sp),
          label: labelText == null
              ? null
              : text(
                  labelText!, //'Points for cashback', // dynamic
                  style: AppStyle.shortHeading.copyWith(
                      color: AppColors.greyInlineText,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.0.sp),
                ),
          floatingLabelBehavior:
              floatingBehavior ?? FloatingLabelBehavior.always,
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
              borderSide: const BorderSide(width: 1.0, color: Colors.blue))),
    );
  }
}
