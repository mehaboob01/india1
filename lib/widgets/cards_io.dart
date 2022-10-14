import 'package:flutter/material.dart';

import '../constant/theme_manager.dart';

class CardScreen extends StatelessWidget {

  String? imageLocation;
  CardScreen(this.imageLocation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(

      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.2,


      child: Row(

        children: [
          Spacer(),
          Image.asset(
            imageLocation!,
            fit: BoxFit.fitHeight,
            width: MediaQuery.of(context).size.width*0.6,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
        decoration: BoxDecoration(

            gradient: new LinearGradient(
              end: Alignment.bottomRight,
              colors: [AppColors.cardBg1, AppColors.cardBg2],
            ),
            borderRadius: BorderRadius.all(
             Radius.circular(12)
            ),

            // radius of 10
            //color: AppColors.primary // green as background color
        )

    );
  }

}