// ignore_for_file: constant_identifier_names
import 'package:bmi_calculator/data/bmi_error.dart';
import 'package:bmi_calculator/vars/globals.dart';
import 'package:bmi_calculator/vars/strings.dart';

const INCHES_PER_FOOT = 12;
const CM_PER_METER = 100;

// Very underweight = < 16.5
// Underweight = 16.5 - 18.5
// Normal weight = 18.5 – 24.9
// Overweight = 25 – 29.9
// Obesity1 = 30 - 35
// Obesity2 = 35 - 40
// Obesity3 = BMI > 40
enum BmiCategory { veryUnder, under, normal, over, obese1, obese2, obese3 }

class BmiCalculator {
  // BMI = weight (kg)  / height^2 (meters)
  double getBmi(double weightKg, double heightM) {
    if (weightKg == BMI_ERROR || heightM == BMI_ERROR) {
      throw BmiException("At least one of the inputs was BMI_ERROR");
    }
    if (weightKg <= 0 || heightM <= 0) {
      throw BmiException("At least one of the inputs was less than or equal 0");
    }
    return weightKg / (heightM * heightM);
  }

  double metersToFeet(double meters) {
    return meters * 3.28084;
  }

  double feetToMeters(double feet) {
    return feet / 3.28084;
  }

  double kgToLb(double kg) {
    return kg * 2.20462;
  }

  double lbToKg(double lb) {
    return lb / 2.20462;
  }

  // See comment above
  BmiCategory getCategory(double bmi) {
    if (bmi <= 16.5) {
      return BmiCategory.veryUnder;
    } else if (bmi < 18.5) {
      return BmiCategory.under;
    } else if (bmi < 25) {
      return BmiCategory.normal;
    } else if (bmi < 30) {
      return BmiCategory.over;
    } else if (bmi < 35) {
      return BmiCategory.obese1;
    } else if (bmi < 40) {
      return BmiCategory.obese2;
    } else {
      return BmiCategory.obese3;
    }
  }

  String getBmiMessageHeader(double bmi) {
    if (bmi == DEFAULT_BMI) return DEFAULT_WEIGHT_MESSAGE_HEADER;
    BmiCategory category = getCategory(bmi);
    switch (category) {
      case BmiCategory.veryUnder:
        return VERY_UNDER_MESSAGE_HEADER_SF;
      case BmiCategory.under:
        return UNDER_WEIGHT_MESSAGE_HEADER_SF;
      case BmiCategory.normal:
        return NORMAL_WEIGHT_MESSAGE_HEADER_SF;
      case BmiCategory.over:
        return OVER_WEIGHT_MESSAGE_HEADER_SF;
      case BmiCategory.obese1:
        return OBESE1_WEIGHT_MESSAGE_HEADER_SF;
      case BmiCategory.obese2:
        return OBESE2_WEIGHT_MESSAGE_HEADER_SF;
      case BmiCategory.obese3:
        return OBESE3_WEIGHT_MESSAGE_HEADER_SF;
    }
  }

  String getBmiMessageSubtitle(double bmi) {
    if (bmi == DEFAULT_BMI) return DEFAULT_WEIGHT_MESSAGE_SUBTITLE;
    BmiCategory category = getCategory(bmi);
    switch (category) {
      case BmiCategory.veryUnder:
        return VERY_UNDER_MESSAGE_SUBTITLE_SF;
      case BmiCategory.under:
        return UNDER_WEIGHT_MESSAGE_SUBTITLE_SF;
      case BmiCategory.normal:
        return NORMAL_WEIGHT_MESSAGE_SUBTITLE_SF;
      case BmiCategory.over:
        return OVER_WEIGHT_MESSAGE_SUBTITLE_SF;
      case BmiCategory.obese1:
        return OBESE1_WEIGHT_MESSAGE_SUBTITLE_SF;
      case BmiCategory.obese2:
        return OBESE2_WEIGHT_MESSAGE_SUBTITLE_SF;
      case BmiCategory.obese3:
        return OBESE3_WEIGHT_MESSAGE_SUBTITLE_SF;
    }
  }

  String getBmiMessageText(double bmi) {
    if (bmi == DEFAULT_BMI) return DEFAULT_WEIGHT_MESSAGE_TEXT;
    BmiCategory category = getCategory(bmi);
    switch (category) {
      case BmiCategory.veryUnder:
        return VERY_UNDER_MESSAGE_TEXT_SF;
      case BmiCategory.under:
        return UNDER_WEIGHT_MESSAGE_TEXT_SF;
      case BmiCategory.normal:
        return NORMAL_WEIGHT_MESSAGE_TEXT_SF;
      case BmiCategory.over:
        return OVER_WEIGHT_MESSAGE_TEXT_SF;
      case BmiCategory.obese1:
        return OBESE1_WEIGHT_MESSAGE_TEXT_SF;
      case BmiCategory.obese2:
        return OBESE2_WEIGHT_MESSAGE_TEXT_SF;
      case BmiCategory.obese3:
        return OBESE3_WEIGHT_MESSAGE_TEXT_SF;
    }
  }

  double _roundOneDecimal(double d) {
    return (d * 10).round() / 10;
  }

  String getIdealWeight(double heightM, bool isWeightMetric) {
    // BMI = weight (kg)  / height^2 (meters)
    // So, I just need to reverse engineer the BMI into the ideal weight for normal range
    // Normal range is 18.5 - 24.9
    // fudge a little to make it always true
    const double BMI_NORM_LOW = 18.5;
    const double BMI_NORM_HIGH = 24.9;

    double low = BMI_NORM_LOW * heightM * heightM;
    double high = BMI_NORM_HIGH * heightM * heightM;
    String unit = WEIGHT_METRIC_TEXT;

    if (!isWeightMetric) {
      low = kgToLb(low);
      high = kgToLb(high);
      unit = WEIGHT_IMPER_TEXT;
    }
    low = _roundOneDecimal(low);
    high = _roundOneDecimal(high);
    return "$IDEAL_WEIGHT_MESSAGE $low$unit - $high$unit";
  }
}
