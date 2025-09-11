import 'package:bmi_calculator/data/bmi_calculator.dart';
import 'package:bmi_calculator/data/bmi_error.dart';
import 'package:bmi_calculator/vars/globals.dart';
import 'package:bmi_calculator/widgets/bmi_bar.dart';
import 'package:bmi_calculator/widgets/bmi_message_box.dart';
import 'package:bmi_calculator/widgets/bmi_number.dart';
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
      child: GestureDetector(
        //  THIS IS HOW YOU UNFOCUS THE KEYBOARD
        onTap: () {
          {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: MESSAGE_MAX_WIDTH),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WeightSelector(weightCallback),
                      HeightSelector(heightCallback),
                    ],
                  ),
                ),
                const Divider(height: 64),
                BmiBar(bmi),
                const SizedBox(height: 16),
                BmiNumber(bmi: bmi),
                const Divider(height: 32),
                const SizedBox(height: 8),
                BmiMessageBox(bmi, height, isWeightMetric),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
