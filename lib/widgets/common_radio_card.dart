import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';
import 'common_divider.dart';



class CommonRadioCard extends StatefulWidget {
  CommonRadioCard(
      {
      required this.isSelected,
      this.isEditable = false,
      required this.cardWidth,
      required this.radioCardType,
      this.onEditPressed,
      this.onDeletePressed,
      this.upiId,
      this.rechargePlanAmount,
      this.rechargePlanData,
      this.rechargeDoneSim,
      this.rechargeDoneRedeemedDate,
      this.rechargeDoneRedeemedValue,
      this.bankAccountName,
      this.bankAccountIFSC,
      this.bankAccountType,
      this.rechargePlanValidity,
      this.rechargePlantalkTime,
      this.rechargeDonePhoneNumber,
      this.bankAccountNumber});
  bool isSelected;

  final double cardWidth;
  final bool? isEditable;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final RadioCardType radioCardType;
  final String? upiId,
      rechargePlanAmount,
      rechargePlanData,
      rechargeDoneSim,
      rechargeDoneRedeemedDate,
      rechargeDoneRedeemedValue,
      bankAccountName,
      bankAccountIFSC,
      bankAccountType,
       rechargePlanValidity,
      rechargePlantalkTime,
      rechargeDonePhoneNumber,
      bankAccountNumber;

  @override
  State<CommonRadioCard> createState() => _CommonRadioCardState();
}

class _CommonRadioCardState extends State<CommonRadioCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0.wp),
      child: Stack(
        children: [
          Container(
              width: widget.cardWidth, //42.0.wp,
              //30.0.wp,
              padding:
                  EdgeInsets.symmetric(vertical: 3.0.hp, horizontal: 4.0.wp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0.wp),
                  gradient: widget.isSelected
                      ?  LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                              AppColors.backGroundgradient1,
                              AppColors.backGroundgradient2
                            ])
                      : null,
                  color: widget.isSelected ? null : const Color(0xfff8f9fb)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // card type upi -------------------------------------------------------------
                  if (widget.radioCardType == RadioCardType.upi)
                    CardModel().upiModel.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.upiId ??
                                    'enter your UpiId', //CardModel().upiModel[0]['upiId'],
                                style: AppStyle.shortHeading.copyWith(
                                  fontSize: 14.0.sp,
                                  height: 1.2.sp,
                                  fontWeight: FontWeight.w600,
                                  color: widget.isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 1.0.hp),
                              widget.isEditable == true
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(top: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonButton(
                                              onpressed:
                                                  widget.onDeletePressed ??
                                                      () {},
                                              isdelete: true),
                                          CommonButton(
                                              onpressed:
                                                  widget.onEditPressed ??
                                                      () {},
                                              isdelete: false)
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
                  // card type recharge plan ------------------------------------------------------------
                  if (widget.radioCardType == RadioCardType.rechargePlan)
                    CardModel().rechargePlanModel.isNotEmpty
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.0.wp),
                                child: rupeeIcon(
                                  // label: CardModel()
                                  //     .rechargePlanModel[0]['amount']
                                  //     .toString(),
                                  label: widget.rechargePlanAmount ??
                                      'Recharge amount',
                                  textColor: widget.isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16.0.sp,
                                  boldfont: true,
                                  color: widget.isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 1.0.hp),
                              const CommonDivider(
                                isvertical: false,
                                horizontalPadding: EdgeInsets.zero,
                              ),
                              SizedBox(height: 2.0.hp),
                              IntrinsicHeight(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Validity : ${widget.rechargePlanValidity} days', //${CardModel().rechargePlanModel[0]['validity'].toString()}
                                      style: AppStyle.shortHeading.copyWith(
                                        fontSize: 14.0.sp,
                                        color: widget.isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                   Divider(thickness: 1,),
                                    SizedBox(height: 2,),
                                    CardModel().rechargePlanModel[0]
                                                ['data'] !=
                                            null
                                        ? Text(
                                            'Enjoy ${widget.rechargePlanData} data', //${CardModel().rechargePlanModel[0]['data']}
                                            style: AppStyle.shortHeading
                                                .copyWith(
                                              fontSize: 14.0.sp,
                                              color: widget.isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                'Talktime : ',
                                                style: AppStyle.shortHeading
                                                    .copyWith(
                                                  fontSize: 14.0.sp,
                                                  color: widget.isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              rupeeIcon(
                                                  color: widget.isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  textColor: widget.isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 14.0.sp,
                                                  label:
                                                      '${widget.rechargePlantalkTime}' // '${CardModel().rechargePlanModel[0]['talktime']}',
                                                  )
                                            ],
                                          ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
                  //  card type is recharge done --------------------------------------------------------
                  if (widget.radioCardType == RadioCardType.rechargedone)
                    CardModel().rechargeDoneModel.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.0.wp),
                                child: Text(
                                  '+91 ${widget.rechargeDonePhoneNumber}', //${CardModel().rechargeDoneModel[0]['number']}
                                  style: AppStyle.shortHeading.copyWith(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w600,
                                    color: widget.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.0.hp),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Text(
                                      '${widget.rechargeDoneSim}', //${CardModel().rechargeDoneModel[0]['sim']}
                                      style: AppStyle.shortHeading.copyWith(
                                        fontSize: 14.0.sp,
                                        color: widget.isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 4.0.wp),
                                    const CommonDivider(
                                        isvertical: true,
                                        verticalPadding: EdgeInsets.zero),
                                    SizedBox(width: 4.0.wp),
                                    Text(
                                      'Karnataka',
                                      style: AppStyle.shortHeading.copyWith(
                                        fontSize: 14.0.sp,
                                        color: widget.isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.0.hp),
                              Row(children: [
                                Text(
                                  'Redeemed ',
                                  style: AppStyle.shortHeading.copyWith(
                                    fontSize: 12.0.sp,
                                    color: widget.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                rupeeIcon(
                                    boldfont: true,
                                    color: widget.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    textColor: widget.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12.0.sp,
                                    label:
                                        '${widget.rechargeDoneRedeemedValue}' // '${CardModel().rechargeDoneModel[0]['redeemed']}',
                                    ),
                                Text(
                                  ' on ${widget.rechargeDoneRedeemedDate}', //${CardModel().rechargeDoneModel[0]['date']}
                                  style: AppStyle.shortHeading.copyWith(
                                    fontSize: 12.0.sp,
                                    color: widget.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ])
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),

                  // card type is bank account ---------------------------------------------------
                  if (widget.radioCardType == RadioCardType.bankAccount)
                    CardModel().accountModel.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.0.wp),
                                child: Text(
                                  '${widget.bankAccountName}', //'${CardModel().accountModel[0]['name']}',
                                  style: AppStyle.shortHeading.copyWith(
                                    fontSize: Dimens.font_18sp,
                                    fontWeight: FontWeight.w600,
                                    color: widget.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.0.hp),
                              // account number row ------------------
                              Row(
                                children: [
                                  Text(
                                    'Account Number :',
                                    style: AppStyle.shortHeading.copyWith(
                                      fontSize: 12.0.sp,
                                      color: widget.isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 2.0.wp),
                                  Text(
                                    '${widget.bankAccountNumber}', //'${CardModel().accountModel[0]['accountNumber']}',
                                    style: AppStyle.shortHeading.copyWith(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w600,
                                      color: widget.isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // IFSC Code --------------------------------------
                              SizedBox(height: 2.0.hp),
                              Row(
                                children: [
                                  Text(
                                    'IFSC code :',
                                    style: AppStyle.shortHeading.copyWith(
                                      fontSize: 12.0.sp,
                                      color: widget.isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 2.0.wp),
                                  Text(
                                    '${widget.bankAccountIFSC}', //'${CardModel().accountModel[0]['IFSC']}',
                                    style: AppStyle.shortHeading.copyWith(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w600,
                                      color: widget.isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // bank accout type -------------------------------
                              SizedBox(height: 2.0.hp),
                              Row(
                                children: [
                                  Text(
                                    'Account type :',
                                    style: AppStyle.shortHeading.copyWith(
                                      fontSize: 12.0.sp,
                                      color: widget.isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 2.0.wp),
                                  Text(
                                    '${widget.bankAccountType}', //'${CardModel().accountModel[0]['type']}',
                                    style: AppStyle.shortHeading.copyWith(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w600,
                                      color: widget.isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),

                              widget.isEditable == true
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(top: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonButton(
                                              onpressed:
                                                  widget.onDeletePressed ??
                                                      () {},
                                              isdelete: true),
                                          CommonButton(
                                              onpressed:
                                                  widget.onEditPressed ??
                                                      () {},
                                              isdelete: false)
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
                  // SizedBox(
                  //     width: 10.0.wp,
                  //     height: 10.0.wp,
                  //     //color: Colors.red,
                  //     child: imageSvg != null
                  //         ? SvgPicture.asset(
                  //             imageSvg!,
                  //             color: isSelected
                  //                 ? Colors.white
                  //                 : AppColors.backGroundgradient1,
                  //           )
                  //         : Image.asset(
                  //             imagePng!,
                  //             color: isSelected
                  //                 ? Colors.white
                  //                 : AppColors.backGroundgradient1,
                  //           )),
                  // SizedBox(
                  //   width: 15.0.wp,
                  //   height: 4.0.wp,
                  //   //color: Colors.blue,
                  //   child: Image.asset(
                  //     AppImages.cardImageshadow,
                  //     fit: BoxFit.fill,
                  //     color: isSelected ? Colors.white : null,
                  //   ),
                  // ),
                  // Text(
                  //   label,
                  //   style: AppStyle.shortHeading.copyWith(
                  //     fontSize: 12.0.sp,
                  //     height: 1.2.sp,
                  //     color: isSelected ? Colors.white : Colors.black,
                  //   ),
                  // )
                ],
              )),
          widget.isEditable == true
              ? const SizedBox.shrink()
              : widget.isSelected
                  ? Positioned(
                      top: widget.radioCardType == RadioCardType.upi
                          ? 3.0.hp
                          : widget.radioCardType == RadioCardType.rechargePlan
                              ? 3.0.hp
                              : 1.0.hp,
                      right: 2.0.wp,
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    )
                  : Positioned(
                      top: widget.radioCardType == RadioCardType.upi
                          ? 3.0.hp
                          : widget.radioCardType == RadioCardType.rechargePlan
                              ? 3.0.hp
                              : 1.0.hp,
                      right: 2.0.wp,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: AppColors.backGroundgradient1)),
                      ))
        ],
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  const CommonButton(
      { required this.onpressed, required this.isdelete});
  final VoidCallback onpressed;
  final bool isdelete;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        width: size.width * 0.4,
        height: 5.0.hp,
        decoration: BoxDecoration(
            gradient: isdelete
                ? null
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                        Color(0xffFFEE48),
                        Color(0xffFFAD04),
                        Color(0xffFFAD04)
                      ]),
            color: isdelete ? Colors.white : null,
            border: isdelete
                ? Border.all(width: 1, color: AppColors.backGroundgradient1)
                : null,
            borderRadius: BorderRadius.circular(2.0.wp)),
        child: Center(
          child: Text(
            isdelete ? 'Delete' : 'Edit',
            style: AppStyle.shortHeading.copyWith(
              fontSize: 12.0.sp,
              color: isdelete ? AppColors.backGroundgradient1 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

enum RadioCardType { rechargePlan, rechargedone, bankAccount, upi }

class CardModel {
  List<Map<String, dynamic>> accountModel = [
    {
      'name': 'Axis bank',
      'accountNumber': 1234567891011,
      'IFSC': 'IFSC-B001',
      'type': 'Savings account'
    }
  ];

  List<Map<String, dynamic>> rechargeDoneModel = [
    {
      'number': 1234567890,
      'sim': 'Airtel',
      'redeemed': 40,
      'date': '12th Oct 2022'
    }
  ];

  List<Map<String, dynamic>> rechargePlanModel = [
    {
      'amount': 49,
      'sim': 'Airtel',
      'validity': 15,
      'talktime': 44,
      'data': '4 GB'
    }
  ];

  List<Map<String, dynamic>> upiModel = [
    {
      'upiId': '9876543210@okicici',
    }
  ];
}
