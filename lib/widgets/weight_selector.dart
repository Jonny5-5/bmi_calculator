// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:bmi_calculator/vars/globals.dart';
import 'package:bmi_calculator/vars/strings.dart';
import 'package:bmi_calculator/vars/colors.dart';

class WeightSelector extends StatefulWidget {
  final Function(double, bool) callback;
  const WeightSelector(this.callback, {super.key});

  @override
  State<StatefulWidget> createState() => WeightSelectorState();
}

class WeightSelectorState extends State<WeightSelector> {
  bool isMetric = false;
  int toggleIndex = 0;
  final int IMPER_INDEX = 0;
  final int METRIC_INDEX = 1;
  List<String> labels = [WEIGHT_IMPER_TEXT, WEIGHT_METRIC_TEXT];
  TextEditingController controller = TextEditingController();

  void textChanged(String s) {
    double weight = double.tryParse(s) ?? BMI_ERROR;
    widget.callback(weight, isMetric);
  }

  void onSwitch(int? value) {
    debugPrint("Switch index is $value");
    isMetric = (value == METRIC_INDEX);
    textChanged(controller.text);
    setState(() {
      toggleIndex = value ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          WEIGHT_TEXT,
          style: TextStyle(fontSize: 40),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  height: TEXT_INPUT_HEIGHT,
                  width: TEXT_INPUT_WIDTH,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText:
                          isMetric ? WEIGHT_LABEL_METRIC : WEIGHT_LABEL_IMPER,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: textChanged,
                    onSubmitted: textChanged,
                  ),
                ),
                const SizedBox(
                  height: TEXT_INPUT_HEIGHT,
                  width: TEXT_INPUT_WIDTH,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(DEFALT_PADDING_SIZE, 0, 0, 0),
              child: ToggleSwitch(
                minWidth: 48,
                isVertical: true,
                radiusStyle: true,
                initialLabelIndex: toggleIndex,
                inactiveBgColor: Theme.of(context).splashColor,
                activeBgColors: [
                  [MINT_GREEN],
                  [MINT_GREEN],
                ],
                activeFgColor: Colors.black,
                inactiveFgColor: Colors.black,
                labels: labels,
                onToggle: onSwitch,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
