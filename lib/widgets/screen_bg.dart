
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constant/theme_manager.dart';



class BgScreen extends StatelessWidget {

  String? imageLocation;
   BgScreen(this.imageLocation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.white,
        child: Image.asset(
          imageLocation!,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      );
    }

}

class LoginBgScreen extends StatelessWidget {

  String? imageLocation;
  LoginBgScreen(this.imageLocation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.5,
      color: AppColors.white,
      child: Image.asset(
        imageLocation!,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

}

