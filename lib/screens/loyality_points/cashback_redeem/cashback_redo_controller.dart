import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class CashBackRedoController extends GetxController {
  final RxList<bool> isSelectedBoolList =
      <bool>[true, false].obs; // bank and vpa toggle
  final sliderTextEditingCtrl = TextEditingController();
  final bankNameCtrl = TextEditingController(); // slider text controller
  final accountFormKey = GlobalKey<FormBuilderState>(); // account form key
  final accountCardSelectedIndex = (-1).obs; // account card selected or not
  final accountButtonEnabled =
      false.obs; // account submit button enabled or not
  final bankAccountDropDownTapped = false.obs; // account dropdown ontap
  final bankTypeDropDownTapped = false.obs; // account type dropdown ontap
  final redeemPointsSliderValue = 0.0.obs; // slider value
  final redeemPointsMinValue = 0.0.obs; // slider minimum value
  final accountNumberAutoValidate = false.obs; // account number auto validate
  final bankname = ''.obs; // drop down bank name
  Rx<FocusNode> accountFocus = FocusNode().obs;
  @override
  void onClose() {
    sliderTextEditingCtrl.clear();
    super.onClose();
  }
}
