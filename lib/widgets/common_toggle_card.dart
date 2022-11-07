import 'package:flutter/material.dart';

import '../screens/loyality_points/redeem_points/rp_manager.dart';
import 'common_redeem_card.dart';



class CommonToggleCard extends StatelessWidget {
  const CommonToggleCard({
    Key? key,
    required this.getController,
    required this.redeemCardList,
    required this.isSelectedlist,
  }) : super(key: key);

  final CashBackController getController;
  final List<RedeemCard> redeemCardList;
  final List<bool> isSelectedlist;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        fillColor: Colors.transparent,
        renderBorder: false,
        splashColor: Colors.transparent,
        isSelected: isSelectedlist,
        onPressed: (index) =>
            getController.changeSelection(index, isSelectedlist),
        children: redeemCardList);
  }
}
