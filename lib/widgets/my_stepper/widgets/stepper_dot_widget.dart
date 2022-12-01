import 'package:flutter/material.dart';

class StepperDot extends StatelessWidget {
  /// Default stepper dot
  const StepperDot({
    Key? key,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
    required this.activeBarColor,
  }) : super(key: key);

  /// Index at which the item is present
  final int index;

  /// Total length of the list provided
  final int totalLength;

  /// Active index which needs to be highlighted and before that
  final int activeIndex;

  /// My Active color
  final Color activeBarColor;

  @override
  Widget build(BuildContext context) {
    final color = (index <= activeIndex) ? activeBarColor : Colors.grey;
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: (index <= activeIndex)
          ? index == activeIndex
              ? Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: color,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: activeBarColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                )
          : Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
    );
  }
}
