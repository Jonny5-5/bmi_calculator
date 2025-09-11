import 'package:bmi_calculator/data/bmi_calculator.dart';
import 'package:bmi_calculator/vars/colors.dart';
import 'package:bmi_calculator/vars/strings.dart';
import 'package:flutter/material.dart';

final Map<BmiCategory, Color> _bmiCategoriesToColors = {
  BmiCategory.veryUnder: UNDER_BMI_COLOR,
  BmiCategory.under: UNDER_BMI_COLOR,
  BmiCategory.normal: NORM_BMI_COLOR,
  BmiCategory.over: OVER_BMI_COLOR,
  BmiCategory.obese1: OBESE1_BMI_COLOR,
  BmiCategory.obese2: OBESE2_BMI_COLOR,
  BmiCategory.obese3: OBESE2_BMI_COLOR,
};

class BmiNumber extends StatelessWidget {
  final double bmi;
  const BmiNumber({super.key, required this.bmi});

  @override
  Widget build(BuildContext context) {
    final category = BmiCalculator().getCategory(bmi);
    Color color = _bmiCategoriesToColors[category] ?? NORM_BMI_COLOR;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(flex: 2),
        Text(
          "$BMI_STRING:  ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "$bmi",
          style: TextStyle(fontSize: 40, color: color),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
