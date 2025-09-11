import 'package:bmi_calculator/data/bmi_calculator.dart';
import 'package:bmi_calculator/vars/globals.dart';
import 'package:bmi_calculator/vars/colors.dart';
import 'package:flutter/material.dart';

class ColorBar extends StatelessWidget {
  final double bmi;

  const ColorBar({
    super.key,
    required this.bmi,
  });

  // ignore: non_constant_identifier_names
  final double DEFAULT_SCALE = 1.0;

  Widget buildBox(int flex, Color color) {
    BmiCategory category = BmiCalculator().getCategory(bmi);
    double scale = DEFAULT_SCALE;
    if (category == BmiCategory.veryUnder && color == UNDER_BMI_COLOR ||
        category == BmiCategory.obese3 && color == OBESE2_BMI_COLOR ||
        category == BmiCategory.under && color == UNDER_BMI_COLOR ||
        category == BmiCategory.normal && color == NORM_BMI_COLOR ||
        category == BmiCategory.over && color == OVER_BMI_COLOR ||
        category == BmiCategory.obese1 && color == OBESE1_BMI_COLOR ||
        category == BmiCategory.obese2 && color == OBESE2_BMI_COLOR) {
      scale = ZOOM_IN_SCALE;
    }

    // The flex variable will change the width
    // I don't want the width to change as the bar moves though. Just height.
    // flex = (flex * scale).toInt();
    // var border = scale == DEFAULT_SCALE ? null : Border.all(color: Colors.black);

    var shadows = scale == DEFAULT_SCALE
        ? null
        : [const BoxShadow(blurRadius: BOX_BLUR_RADIUS, color: Colors.grey)];

    return Expanded(
      flex: flex,
      child: Container(
        height: BAR_HEIGHT * scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BOX_BORDER_RADIUS),
          border: Border.all(color: Colors.grey.shade300, width: 0.3),
          boxShadow: shadows,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          buildBox(RANGE_BMI_UNDER, UNDER_BMI_COLOR),
          buildBox(RANGE_BMI_NORM, NORM_BMI_COLOR),
          buildBox(RANGE_BMI_OVER, OVER_BMI_COLOR),
          buildBox(RANGE_BMI_OBESE1, OBESE1_BMI_COLOR),
          buildBox(RANGE_BMI_OBESE2, OBESE2_BMI_COLOR),
        ],
      ),
    );
  }
}
