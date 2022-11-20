import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Text(
                  "Loan application submitted!",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: Dimens.font_24sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "The team will get back to you.",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: Dimens.font_20sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}