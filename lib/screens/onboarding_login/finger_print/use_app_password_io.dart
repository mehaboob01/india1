import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/routes.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(userPswdTitle),
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
                      child: Text("Set password"))
                  : Container()
            ],
          ),
        ),
      )),
    );
  }
}
