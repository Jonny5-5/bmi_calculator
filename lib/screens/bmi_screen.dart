import 'package:bmi_calculator/data/bmi_calculator.dart';
import 'package:bmi_calculator/data/bmi_error.dart';
import 'package:bmi_calculator/vars/globals.dart';
import 'package:bmi_calculator/vars/strings.dart';
import 'package:bmi_calculator/widgets/bmi_bar.dart';
import 'package:bmi_calculator/widgets/message_box.dart';
import 'package:bmi_calculator/widgets/weight_selector.dart';
import 'package:flutter/material.dart';

import '../widgets/height_selector.dart';
import '../widgets/scaffold_container.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => BmiScreenState();
}

class BmiScreenState extends State<BmiScreen> {
  double bmi = 20.0;
  double height = BMI_ERROR;
  double weight = BMI_ERROR;
  BmiCalculator bmiCalculator = BmiCalculator();
  String bmiMessage = DEFAULT_WEIGHT_MESSAGE;

  void heightCallback(double h, bool isMetric) {
    if (!isMetric) {
      height = bmiCalculator.feetToMeters(h);
    } else {
      height = h;
    }
    updateBmi();
  }

  void weightCallback(double w, bool isMetric) {
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
      bmiMessage = bmiCalculator.getBmiMessage(bmi);
    } on BmiException catch (e) {
      bmiMessage = INPUT_ERROR_MESSAGE;
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
          const SizedBox(height: 20),
          Text(
            "BMI",
            style: TextStyle(
              color: MINT_GREEN,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$bmi",
            style: const TextStyle(
              color: TEXT_LIGHT,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: BIGGER_PADDING_SIZE),
          Padding(
            padding: const EdgeInsets.all(DEFALT_PADDING_SIZE),
            child: BmiBar(bmi),
          ),
          const SizedBox(height: BIGGER_PADDING_SIZE),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeightSelector(weightCallback),
              HeightSelector(heightCallback),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(BIGGER_PADDING_SIZE),
            child: MessageBox(bmiMessage),
          ),
        ],
      ),
    );
  }
}