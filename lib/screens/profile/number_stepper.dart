import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  final List<String> title;
  final Function callback;

  NumberStepper({
    Key? key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
    required this.title,
    required this.callback,
  })  : assert(curStep > 0 == true &&
            curStep <= totalSteps + 1 &&
            title.length == totalSteps),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        left: 24.0,
        right: 24.0,
      ),
      width: this.width,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: _steps(),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: _title(),
            ),
          ],
        ),
      ),
    );
  }

  getCircleColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = Colors.white;
    else
      color = Colors.white;
    return color;
  }

  getBorderColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = currentStepColor;
    else
      color = inactiveColor;

    return color;
  }

  getLineColor(i) {
    return AppColors.borderColor;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        InkWell(
          onTap: () {
            callback(i);
          },
          child: Container(
            width: 25.0,
            height: 25.0,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: getInnerElementOfStepper(i),
            decoration: new BoxDecoration(
              color: circleColor,
              borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
              border: new Border.all(
                color: borderColor,
                width: 1.0,
              ),
            ),
          ),
        ),
      );

      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              margin: EdgeInsets.symmetric(horizontal: 8),
              color: lineColor,
            ),
          ),
        );
      }
    }

    return list;
  }

  List<Widget> _title() {
    var list = <Widget>[];

    for (int i = 0; i < totalSteps; i++) {
      bool showBold = (i + 1 < curStep || i + 1 == curStep);
      list.add(
        Text(
          "${title[i]}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: showBold ? AppColors.lightBlack : AppColors.borderColor,
            fontSize: Dimens.font_14sp,
          ),
        ),
      );

      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 < curStep) {
      return Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      );
    } else if (index + 1 == curStep) {
      return Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
          border: new Border.all(
            color: currentStepColor,
            width: 1.0,
          ),
        ),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
            color: currentStepColor,
          ),
          margin: EdgeInsets.all(2.5),
        ),
      );
    } else
      return Container();
  }
}
