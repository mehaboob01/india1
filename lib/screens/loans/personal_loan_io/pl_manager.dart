import 'package:get/get.dart';

import 'choose_amount_io.dart';

class  PlManager extends GetxController {


  Rx<double> sliderValue = 100000.0.obs;
  Rx<double> minValue = 100000.0.obs;
  Rx<double> maxValue = 2000000.0.obs;

  var currentScreen = Steps.LOAN_AMOUNT.index.obs;

  List<String> titleList = [
    "Loan amount",
    "Personal",
    "Residential",
    "Occupation",
  ];
  List<String> bikeLoanTitleList = [
    "Loan amount",
    "Personal",
    "Residential",
  ];

  void updateScreen(screenIndex)
  {
    currentScreen.value = screenIndex;

  }







}

