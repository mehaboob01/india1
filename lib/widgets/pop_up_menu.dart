import 'package:flutter/material.dart';

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(

      offset: Offset(-8, 44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
