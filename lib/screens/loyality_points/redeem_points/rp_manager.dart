import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../loyality_manager.dart';

class CashBackController extends GetxController {
  final size = Get.size;
  final carouselCtrl = CarouselController();
  final index = 0.obs;
  final tdimer = 0.obs;
  final redeemPointBankSliderTextEditingCtrl = TextEditingController().obs;
  final redeemPointUpiVpaSliderTextEditingCtrl = TextEditingController().obs;
  final loyaltyBankAccountTextEditingCtrl = TextEditingController().obs;
  final loyaltyUpiTextEditingCtrl = TextEditingController().obs;
  final editaccountformKey = GlobalKey<FormBuilderState>();
  final editUpformKey = GlobalKey<FormBuilderState>();
  final loyaltyBankAccountreEnteredTextEditingCtrl =
      TextEditingController().obs;
  final loyaltyBankAccountIFSCTextEditingCtrl = TextEditingController().obs;
  final upiFormKey = GlobalKey<FormBuilderState>();
  final bankAccountformKey = GlobalKey<FormState>();
  final bankAccontSelected = ''.obs;
  final bankAccountType = ''.obs;
  var sliderMaxValue = 0.obs;
  Rx<double> sliderMaxValueDouble = 0.0.obs;


  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());


  @override
  void onInit() {
    super.onInit();
    _loyaltyManager.callLoyaltyDashboardApi();
    sliderMaxValue.value = _loyaltyManager.redeemablePoints.toInt();

    print(sliderMaxValue);
    print("sliderMaxValue");
    sliderMaxValueDouble.value = sliderMaxValue.value.toDouble();

    print(sliderMaxValueDouble);
    print("sliderMaxValue double");






  }



  final GlobalKey<FormBuilderState> bankAccountKey =
      GlobalKey<FormBuilderState>();

  final upiSubmitEnable = false.obs;
  final upiAddEnable = false.obs;
  final bankAccountSubmitEnable = false.obs;

  void onDispose() {
    redeemPointBankSliderTextEditingCtrl.close();
    redeemPointUpiVpaSliderTextEditingCtrl.close();
    loyaltyBankAccountTextEditingCtrl.close();
    loyaltyBankAccountIFSCTextEditingCtrl.close();
    loyaltyBankAccountreEnteredTextEditingCtrl.close();

    super.dispose();
  }

  void changeSelection(int index, List isSelectedlist) {
    for (int i = 0; i < isSelectedlist.length; i++) {
      if (i == index) {
        isSelectedlist[i] = true;
      } else {
        isSelectedlist[i] = false;
      }
    }
  }

  // validate textfield
  bool validateValue(String value) {
    if (value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // dropdown change
  String? updateDropDownvalue(String? value, String? initialValue) {
    initialValue = value;
    debugPrint(initialValue);
    return initialValue;
  }

  // textform enable or disable button
  bool getCtrlString(RxList<String> list) {
    return list.first.isNotEmpty ? true : false;
  }
}
