import 'package:bmi_calculator/data/bmi_calculator.dart';
import 'package:bmi_calculator/data/bmi_error.dart';
import 'package:bmi_calculator/vars/globals.dart';
import 'package:bmi_calculator/widgets/bmi_bar.dart';
import 'package:bmi_calculator/widgets/bmi_message_box.dart';
import 'package:bmi_calculator/widgets/bmi_number.dart';
import 'package:bmi_calculator/widgets/bmi_title.dart';
import 'package:bmi_calculator/widgets/weight_selector.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/widgets/height_selector.dart';
import 'package:bmi_calculator/widgets/scaffold_container.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => BmiScreenState();
}

class BmiScreenState extends State<BmiScreen> {
  bool isWeightMetric = false;
  double bmi = DEFAULT_BMI;
  double height = BMI_ERROR;
  double weight = BMI_ERROR;
  BmiCalculator bmiCalculator = BmiCalculator();

  void heightCallback(double h, bool isMetric) {
    if (!isMetric) {
      height = bmiCalculator.feetToMeters(h);
    } else {
      height = h;
    }
    updateBmi();
  }

  void weightCallback(double w, bool isMetric) {
    isWeightMetric = isMetric;
    if (!isMetric) {
      weight = bmiCalculator.lbToKg(w);
    } else {
      weight = w;
    }
    updateBmi();
  }

  void updateBmi() {
    double newBmi;
    try {
      newBmi = bmiCalculator.getBmi(weight, height);
      newBmi = makeBmiPretty(newBmi);
      bmi = newBmi;
    } on BmiException catch (e) {
      bmi = DEFAULT_BMI;
      debugPrint("There was some kind of error! ${e.cause}");
    }
    // Update the widgets
    setState(() {});
  }

  double makeBmiPretty(double bmi) {
    // Round to one decimal point
    return (bmi * 10).round() / 10;
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldContainerBackground(
      showAppBar: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const BmiTitle(),
          BmiNumber(bmi: bmi),
          const SizedBox(height: BIGGER_PADDING_SIZE),
          Padding(
            padding: const EdgeInsets.only(
              left: BAR_PADDING_SIZE,
              right: BAR_PADDING_SIZE,
            ),
            child: BmiBar(bmi),
          ),
          const SizedBox(height: BIGGER_PADDING_SIZE),
          Container(
            constraints: const BoxConstraints(maxWidth: MESSAGE_MAX_WIDTH),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeightSelector(weightCallback),
                HeightSelector(heightCallback),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BIGGER_PADDING_SIZE),
            child: BmiMessageBox(bmi, height, isWeightMetric),
          ),
        ],
      ),
    );
  }
}
