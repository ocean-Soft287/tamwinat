import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final int currentValue;

  ProgressIndicatorWidget({
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    double normalizedValue = (currentValue - minValue) / (maxValue - minValue);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(height:5),
        LinearPercentIndicator(
          width: 100,
          lineHeight: 20.0,
          percent: normalizedValue,
          backgroundColor: Colors.grey,
          progressColor: Colors.blue,
          center: Text(
            '${(normalizedValue * 10).toStringAsFixed(1)}',
            style: TextStyle(color: Colors.white),
          ),
          barRadius: Radius.circular(10),
        ),
      ],
    );
  }
}