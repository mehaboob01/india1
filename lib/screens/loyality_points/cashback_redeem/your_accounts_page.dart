import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';
import '../../../constant/theme_manager.dart';
import '../../../widgets/common_radio_card.dart';


class UserAccountPage extends StatelessWidget {
 // const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _accountCard()[0];
  }

  List<Widget> _accountCard() {
    return [
      Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.cardScreenBg),
            borderRadius: BorderRadius.circular(2.0.wp),
          ),
          child: CommonRadioCard(
            radioCardType: RadioCardType.bankAccount,
            bankAccountName: CardModel().accountModel[0]['name'],
            bankAccountIFSC: CardModel().accountModel[0]['IFSC'],
            bankAccountNumber: CardModel().accountModel[0]['accountNumber'].toString(),
            bankAccountType: CardModel().accountModel[0]['type'],
            isSelected: false,
            cardWidth: double.maxFinite,
          ))
    ];
  }
}

class UserUpiId extends StatelessWidget {
  //const UserUpiId({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: _upiCard(),
      )),
    );
  }

  List<Widget> _upiCard() {
    return [
      Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.cardScreenBg),
            borderRadius: BorderRadius.circular(2.0.wp),
          ),
          child: CommonRadioCard(
            radioCardType: RadioCardType.upi,
            upiId: CardModel().upiModel[0]['upiId'],
            isSelected: false,
            cardWidth: double.maxFinite,
          ))
    ];
  }
}

// Text(
//           'or',
//           style: AppStyle.shortHeading.copyWith(
//               color: const Color(0xff2d2d2d), fontWeight: FontWeight.w600),
//         )

class RowHeadingWithunderLineSubHeading extends StatelessWidget {
  const RowHeadingWithunderLineSubHeading(
      { required this.heading, required this.subHeading});
  final String heading;
  final String subHeading;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: AppStyle.shortHeading.copyWith(
              color: const Color(0xff2d2d2d), fontWeight: FontWeight.w600),
        ),
        Text(
          subHeading,
          style: AppStyle.shortHeading.copyWith(
              color: AppColors.backGroundgradient1,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
