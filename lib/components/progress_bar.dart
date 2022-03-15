import 'package:flutter/material.dart';
import 'package:fyp/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final String progress;
  final double percent;

  const ProgressBar({
    Key? key,
    required this.percent,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: 350,
      lineHeight: 20,
      percent: percent, //calculate and pass in passed on goal progress
      center: Text(progress, style: kSubTextStyle),
      backgroundColor: Colors.grey[100],
      progressColor: kCream,
      barRadius: const Radius.circular(40),
    );
  }
}
