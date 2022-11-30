import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/helpers/version_validator.dart';

class Updateavailable extends StatelessWidget {
  Updateavailable({super.key});
  VersionValidator _versionValidator = Get.put(VersionValidator());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Update is available, please update the application before continuing",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          ElevatedButton(
              onPressed: () {
                _versionValidator.launchUrl(Uri.parse("Play Store URL"));
              },
              child: Text("Update now"))
        ],
      ),
    );
  }
}
