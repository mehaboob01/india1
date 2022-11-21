import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/theme_manager.dart';

class HomeScreenOverlay extends StatefulWidget {
  const HomeScreenOverlay({super.key, required this.fromScreen});
  final String fromScreen;
  @override
  State<HomeScreenOverlay> createState() => _HomeScreenOverlayState();
}

class _HomeScreenOverlayState extends State<HomeScreenOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showOverlay() async {
    OverlayState? overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(builder: (context) {
      return widget.fromScreen == 'splash'
          ? Material(
              color: AppColors.blackColor.withOpacity(0.7),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent,
                  ),
                  Positioned(
                    top: 40,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        closeOverlay();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeTransition(
                        opacity: _animation,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.55,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(AppImages.homeScreenPopUpBg))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome to',
                                style: AppStyle.shortHeading.copyWith(
                                    height: 1.2, fontSize: Dimens.font_24sp),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cashback',
                                    style: AppStyle.shortHeading.copyWith(
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                        letterSpacing: 1.2,
                                        fontSize: Dimens.font_24sp),
                                  ),
                                  Text(
                                    ' by ',
                                    style: AppStyle.shortHeading.copyWith(
                                        fontWeight: FontWeight.w600,
                                        height: 1.2,
                                        fontSize: Dimens.font_20sp),
                                  ),
                                  Text(
                                    'India1',
                                    style: AppStyle.shortHeading.copyWith(
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                        letterSpacing: 1.2,
                                        fontSize: Dimens.font_24sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Text(
                                'You just won',
                                style: AppStyle.shortHeading
                                    .copyWith(fontSize: Dimens.font_20sp),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimens.padding_12dp),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(AppImages.goldenHexagonal),
                                    Positioned(
                                      top: 45,
                                      child: Text(
                                        '50',
                                        style: AppStyle.shortHeading.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 40),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Points',
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimens.font_24sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Material(
              color: AppColors.blackColor.withOpacity(0.7),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent,
                  ),
                  Positioned(
                    top: 40,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        closeOverlay();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeTransition(
                        opacity: _animation,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  AppImages.golden_hexagon_partyThing),
                              Text(
                                'Complete your profile',
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w700,
                                    // height: 1.2,
                                    // letterSpacing: 1.2,
                                    color: Color(0xffF2642C),
                                    fontSize: Dimens.font_24sp),
                              ),
                              // Text(
                              //   'Program',
                              //   style: AppStyle.shortHeading.copyWith(
                              //       fontWeight: FontWeight.w600,
                              //       height: 1.2,

                              //       fontSize: Dimens.font_20sp),
                              // ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Text(
                                'You have a chance to',
                                style: AppStyle.shortHeading.copyWith(
                                    height: 1.2,
                                    color: AppColors.blackColor,
                                    fontSize: Dimens.font_20sp),
                              ),
                              Text(
                                'earn upto',
                                style: AppStyle.shortHeading.copyWith(
                                    fontSize: Dimens.font_20sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blackColor),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimens.padding_12dp),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(AppImages.goldenHexagonal),
                                    Positioned(
                                      top: 45,
                                      child: Text(
                                        '50',
                                        style: AppStyle.shortHeading.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 40),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Points',
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackColor,
                                    fontSize: Dimens.font_24sp),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment(0, 3),
                                        colors: [
                                          AppColors.orangeGradient1,
                                          AppColors.orangeGradient2,
                                        ])),
                                child: Center(
                                  child: Text(
                                    'Let\'s do it',
                                    style: AppStyle.shortHeading.copyWith(
                                        fontSize: Dimens.font_16sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
    _animationController.addListener(() {
      overlayState!.setState(() {});
    });
    overlayState!.insert(_overlayEntry);
    _animationController.forward();
    // await Future.delayed(const Duration(seconds: 10))
    //     .whenComplete(() => animationController!.reverse())
    //     .whenComplete(() => closeOverlay());
  }

// close overlay function ----------------------------------
  void closeOverlay() {
    _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) => _showOverlay());
    return SizedBox.shrink();
  }
}
