import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';
class CommonDivider extends StatelessWidget {
  const CommonDivider(
      {
        this.horizontalPadding,
        required this.isvertical,
        this.verticalPadding});
  final EdgeInsetsGeometry? horizontalPadding, verticalPadding;
  final bool isvertical;
  @override
  Widget build(BuildContext context) {
    return isvertical == false
        ? Padding(
      padding:
      horizontalPadding ?? EdgeInsets.symmetric(horizontal: 6.0.wp),
      child: const Divider(color: Color(0xffdddddd), thickness: 1),
    )
        : Padding(
      padding: verticalPadding ?? EdgeInsets.symmetric(vertical: 1.0.hp),
      child: const VerticalDivider(
        color: Color(0xffdddddd),
        thickness: 1,
        width: 20.0,
      ),
    );
  }
}