import 'package:bmi_calculator/data/bmi_calculator.dart';
import 'package:bmi_calculator/vars/globals.dart';
import 'package:flutter/material.dart';

class BmiMessageBox extends StatefulWidget {
  final double bmi;
  final double height;
  final bool isMetric;
  const BmiMessageBox(this.bmi, this.height, this.isMetric, {super.key});

  @override
  State<StatefulWidget> createState() => BmiMessageBoxState();
}

class BmiMessageBoxState extends State<BmiMessageBox> {
  @override
  Widget build(BuildContext context) {
    BmiCalculator calculator = BmiCalculator();
    final String header = calculator.getBmiMessageHeader(widget.bmi);
    final String subtitle = calculator.getBmiMessageSubtitle(widget.bmi);
    final String text = calculator.getBmiMessageText(widget.bmi);
    final String idealWeight = widget.bmi == DEFAULT_BMI
        ? ""
        : calculator.getIdealWeight(widget.height, widget.isMetric);

    return Column(
      children: [
        // ----------------- Header ----------------- //
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DEFALT_PADDING_SIZE,
          ),
          child: Text(
            header,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),

        // ----------------- Subtitle BMI Range ----------------- //
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DEFALT_PADDING_SIZE,
          ),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(fontSize: 16),
          ),
        ),

        SizedBox(height: 6),

        // ----------------- Ideal Weight ----------------- //
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DEFALT_PADDING_SIZE,
          ),
          child: Text(
            idealWeight,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),

        // ----------------- Main text ----------------- //
        Padding(
          padding: const EdgeInsets.all(DEFALT_PADDING_SIZE),
          child: Text(
            text,
            softWrap: true,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
