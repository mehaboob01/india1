import 'package:flutter/material.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';
import 'package:get/get.dart';

import '../../../constant/routes.dart';

class FingerPrintIO extends StatefulWidget {
  const FingerPrintIO({Key? key}) : super(key: key);

  @override
  State<FingerPrintIO> createState() => _FingerPrintIOState();
}

class _FingerPrintIOState extends State<FingerPrintIO> {
  double widthIs = 0, heightIs = 0;

  @override
  void initState() {
    LocalAuthentication.authenticateWithBiometrics(
      localizedReason: 'Please authenticate to show account balance',
      useErrorDialogs: false,
    ).then((value) {
      print("value");
      print(value);
      if (value) {
        Get.offAllNamed(MRouter.homeScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: widthIs,
            child: Column(
              children: [Icon(Icons.fingerprint)],
            ),
          ),
        ),
      ),
    );
  }
}
