import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/loyality_points/cashback_redeem/cb_manager.dart';
import '../screens/loyality_points/redeem_points/rp_manager.dart';
import 'common_redeem_card.dart';



class CommonToggleCard extends StatelessWidget {

   CommonToggleCard({
    Key? key,
    required this.getController,
    required this.redeemCardList,
    required this.isSelectedlist,
  }) : super(key: key);

  final CashBackController getController;
  final List<RedeemCard> redeemCardList;
  final List<bool> isSelectedlist;
  CashBackManager cashBackManager = Get.put(CashBackManager());


  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        fillColor: Colors.transparent,
        renderBorder: false,
        splashColor: Colors.transparent,
        isSelected: isSelectedlist,
        onPressed: (index){

          getController.changeSelection(index, isSelectedlist);
          cashBackManager.onInit();


        },

        children: redeemCardList);
  }
}
