import 'package:get/get.dart';

class  PlManager extends GetxController {



  var currentScreen = 0.obs;

  void updateScreen(screenIndex)
  {
    currentScreen.value = screenIndex;

  }







}

