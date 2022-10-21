import 'package:flutter/material.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'use_app_password_io.dart';

class FingerPrintIO extends StatefulWidget {
  const FingerPrintIO({Key? key}) : super(key: key);

  @override
  State<FingerPrintIO> createState() => _FingerPrintIOState();
}

class _FingerPrintIOState extends State<FingerPrintIO> {
  double widthIs = 0, heightIs = 0;
  bool verified = true;



  @override
  void initState() {
   authen();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
            width: widthIs,
            child: Stack(
              children: [

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(27),
                          topLeft: Radius.circular(27),

                        ),
                        color: AppColors.primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "India1 Authentication",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        const Text(
                          "Please login to access",
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          "India1 is using biometrics to authenticate",
                          style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                        ),
                        Icon(
                          Icons.fingerprint,
                          color: verified ? Colors.blue : Colors.red,
                          size: 54,
                        ),
                        (!verified)
                            ? GestureDetector(
                          onTap: () {
                            authen();
                            verified = true;
                            setState(() {
                              verified;
                            });
                          },
                          child: const Text(
                            "Finger print doesn't match. Click here to try again.",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )
                            : Container(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UseAppPasswordIO()),
                              );
                            },
                            child: const Text(
                              "Use app password",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> authen() async {
    LocalAuthentication.authenticate(
        localizedReason: "localizedReason",
        biometricOnly: false,
        stickyAuth: true)
        .then((value) {
      verified = value;
      setState(() {
        verified;
      });
      print(value);
      print("value2");
      print(value);
      print("value");
    });
  }
}
