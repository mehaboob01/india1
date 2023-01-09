import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';

class UseAppPasswordIO extends StatefulWidget {
  const UseAppPasswordIO({Key? key}) : super(key: key);

  @override
  State<UseAppPasswordIO> createState() => _UseAppPasswordIOState();
}

class _UseAppPasswordIOState extends State<UseAppPasswordIO> {
  late SharedPreferences prefs;
  String userPswdTitle = "";
  String actualPassword = "";

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      if (prefs.getString("useAppPassword") != null) {
        userPswdTitle = "Enter password";
        actualPassword = prefs.getString("useAppPassword")!;
      } else {
        userPswdTitle = "Choose your password";
      }
    });
    super.initState();
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  text(userPswdTitle),
                  TextField(
                    onChanged: (val) {
                      if ((userPswdTitle.contains("Choose your password"))) {
                        actualPassword = val;
                      } else if (val.contains(actualPassword)) {
                        Get.offAllNamed(MRouter.homeScreen);
                      }
                    },
                  ),
                  (userPswdTitle.contains("Choose your password"))
                      ? ElevatedButton(
                          onPressed: () {
                            prefs.setString("useAppPassword", actualPassword);
                            Get.offAllNamed(MRouter.homeScreen);
                          },
                          child: text("Set password"))
                      : Container()
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
