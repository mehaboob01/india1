import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/theme_manager.dart';

class CustomDropDown extends StatelessWidget {
  var item;
  var onChanged;
  var hint;
  var label;
  var value;

  CustomDropDown({
    Key? key,
    this.item,
    this.value,
    this.hint,
    this.label,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: item,
      onChanged: onChanged,
      value: value,
      hint: text(hint, style: TextStyle(color: AppColors.white)),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      decoration: inputDecoration(
        // label: label,
        hint: hint,
      ),
    );
  }

  InputDecoration inputDecoration({
    // required String label,
    String? prefix,
    required String hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      isDense: true,
      iconColor: AppColors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.backGroundgradient2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.backGroundgradient2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      // labelText: '$label',
      errorStyle: GoogleFonts.roboto(
        fontSize: Dimens.font_14sp,
        fontWeight: FontWeight.w500,
      ),

      prefixIcon: prefix == null || prefix == ''
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: text(
                prefix,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: Dimens.font_16sp,
                ),
              ),
            ),
      suffixIcon: suffix,
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIconConstraints: BoxConstraints(),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        fontSize: Dimens.font_16sp,
      ),
    );
  }
}
