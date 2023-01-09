import 'package:flutter/material.dart';
import '../../../constant/theme_manager.dart';
import '../../../widgets/common_radio_card.dart';

class UserAccountPage {
  List<Widget> get accountCard => _accountCard();
  List<Widget> get upiCard => _upiCard();

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
            bankAccountNumber:
                CardModel().accountModel[0]['accountNumber'].toString(),
            bankAccountType: CardModel().accountModel[0]['type'],
            isSelected: false,
            cardWidth: double.maxFinite,
          ))
    ];
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

class RowHeadingWithunderLineSubHeading extends StatelessWidget {
  const RowHeadingWithunderLineSubHeading(
      {required this.heading,
      required this.subHeading,
      required this.onPressedSubHeading});
  final String heading;
  final String subHeading;
  final VoidCallback onPressedSubHeading;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(
          heading,
          style: AppStyle.shortHeading.copyWith(
              color: const Color(0xff2d2d2d), fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: onPressedSubHeading,
          child: text(
            subHeading,
            style: AppStyle.shortHeading.copyWith(
                color: AppColors.blueColor,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
