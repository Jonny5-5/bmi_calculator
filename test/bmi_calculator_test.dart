import 'package:bmi_calculator/data/bmi_calculator.dart';
import 'package:bmi_calculator/data/bmi_error.dart';
import 'package:bmi_calculator/vars/globals.dart'; // Import BMI_ERROR
import 'package:bmi_calculator/vars/strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BmiCalculator', () {
    final calculator = BmiCalculator();

    // Test cases for getBmi
    group('getBmi', () {
      test('should return correct BMI for valid inputs', () {
        expect(
            calculator.getBmi(70, 1.75), closeTo(22.86, 0.01)); // 70kg, 1.75m
        expect(
            calculator.getBmi(50, 1.60), closeTo(19.53, 0.01)); // 50kg, 1.60m
        expect(
            calculator.getBmi(100, 2.00), closeTo(25.00, 0.01)); // 100kg, 2.00m
      });

      test('should throw BmiException for zero weight', () {
        expect(() => calculator.getBmi(0, 1.75), throwsA(isA<BmiException>()));
      });

      test('should throw BmiException for zero height', () {
        expect(() => calculator.getBmi(70, 0), throwsA(isA<BmiException>()));
      });

      test('should throw BmiException for negative weight', () {
        expect(
            () => calculator.getBmi(-70, 1.75), throwsA(isA<BmiException>()));
      });

      test('should throw BmiException for negative height', () {
        expect(
            () => calculator.getBmi(70, -1.75), throwsA(isA<BmiException>()));
      });

      test('should throw BmiException for BMI_ERROR weight', () {
        expect(() => calculator.getBmi(BMI_ERROR, 1.75),
            throwsA(isA<BmiException>()));
      });

      test('should throw BmiException for BMI_ERROR height', () {
        expect(() => calculator.getBmi(70, BMI_ERROR),
            throwsA(isA<BmiException>()));
      });
    });

    // Test cases for getCategory
    group('getCategory', () {
      test('should return correct BmiCategory for given BMI values', () {
        expect(calculator.getCategory(15.0), BmiCategory.veryUnder);
        expect(calculator.getCategory(16.5), BmiCategory.veryUnder);
        expect(calculator.getCategory(17.0), BmiCategory.under);
        expect(calculator.getCategory(18.49), BmiCategory.under);
        expect(calculator.getCategory(18.5), BmiCategory.normal);
        expect(calculator.getCategory(22.0), BmiCategory.normal);
        expect(calculator.getCategory(24.9), BmiCategory.normal);
        expect(calculator.getCategory(25.0), BmiCategory.over);
        expect(calculator.getCategory(29.9), BmiCategory.over);
        expect(calculator.getCategory(30.0), BmiCategory.obese1);
        expect(calculator.getCategory(34.9), BmiCategory.obese1);
        expect(calculator.getCategory(35.0), BmiCategory.obese2);
        expect(calculator.getCategory(39.9), BmiCategory.obese2);
        expect(calculator.getCategory(40.0), BmiCategory.obese3);
        expect(calculator.getCategory(50.0), BmiCategory.obese3);
      });
    });

    // Example test cases for unit conversions (can be expanded)
    group('unit conversions', () {
      test('metersToFeet should convert correctly', () {
        expect(calculator.metersToFeet(1), closeTo(3.28, 0.01));
        expect(calculator.metersToFeet(1.75), closeTo(5.74, 0.01));
      });

      test('feetToMeters should convert correctly', () {
        expect(calculator.feetToMeters(3.28084), closeTo(1.0, 0.01));
        expect(calculator.feetToMeters(5.74147), closeTo(1.75, 0.01));
      });

      test('kgToLb should convert correctly', () {
        expect(calculator.kgToLb(1), closeTo(2.20, 0.01));
        expect(calculator.kgToLb(70), closeTo(154.32, 0.01));
      });

      test('lbToKg should convert correctly', () {
        expect(calculator.lbToKg(2.20462), closeTo(1.0, 0.01));
        expect(calculator.lbToKg(154.323), closeTo(70.0, 0.01));
      });
    });

    group('getBmiMessageHeader', () {
      test('should return correct header for each BMI category', () {
        expect(calculator.getBmiMessageHeader(15.0),
            VERY_UNDER_MESSAGE_HEADER_SF);
        expect(calculator.getBmiMessageHeader(17.0),
            UNDER_WEIGHT_MESSAGE_HEADER_SF);
        expect(calculator.getBmiMessageHeader(22.0),
            NORMAL_WEIGHT_MESSAGE_HEADER_SF);
        expect(
            calculator.getBmiMessageHeader(27.0), OVER_WEIGHT_MESSAGE_HEADER_SF);
        expect(
            calculator.getBmiMessageHeader(32.0), OBESE1_WEIGHT_MESSAGE_HEADER_SF);
        expect(
            calculator.getBmiMessageHeader(37.0), OBESE2_WEIGHT_MESSAGE_HEADER_SF);
        expect(
            calculator.getBmiMessageHeader(42.0), OBESE3_WEIGHT_MESSAGE_HEADER_SF);
        expect(calculator.getBmiMessageHeader(DEFAULT_BMI),
            DEFAULT_WEIGHT_MESSAGE_HEADER);
      });
    });

    group('getBmiMessageSubtitle', () {
      test('should return correct subtitle for each BMI category', () {
        expect(calculator.getBmiMessageSubtitle(15.0),
            VERY_UNDER_MESSAGE_SUBTITLE_SF);
        expect(calculator.getBmiMessageSubtitle(17.0),
            UNDER_WEIGHT_MESSAGE_SUBTITLE_SF);
        expect(calculator.getBmiMessageSubtitle(22.0),
            NORMAL_WEIGHT_MESSAGE_SUBTITLE_SF);
        expect(calculator.getBmiMessageSubtitle(27.0),
            OVER_WEIGHT_MESSAGE_SUBTITLE_SF);
        expect(calculator.getBmiMessageSubtitle(32.0),
            OBESE1_WEIGHT_MESSAGE_SUBTITLE_SF);
        expect(calculator.getBmiMessageSubtitle(37.0),
            OBESE2_WEIGHT_MESSAGE_SUBTITLE_SF);
        expect(calculator.getBmiMessageSubtitle(42.0),
            OBESE3_WEIGHT_MESSAGE_SUBTITLE_SF);
        expect(calculator.getBmiMessageSubtitle(DEFAULT_BMI),
            DEFAULT_WEIGHT_MESSAGE_SUBTITLE);
      });
    });

    group('getBmiMessageText', () {
      test('should return correct text for each BMI category', () {
        expect(
            calculator.getBmiMessageText(15.0), VERY_UNDER_MESSAGE_TEXT_SF);
        expect(
            calculator.getBmiMessageText(17.0), UNDER_WEIGHT_MESSAGE_TEXT_SF);
        expect(
            calculator.getBmiMessageText(22.0), NORMAL_WEIGHT_MESSAGE_TEXT_SF);
        expect(calculator.getBmiMessageText(27.0), OVER_WEIGHT_MESSAGE_TEXT_SF);
        expect(
            calculator.getBmiMessageText(32.0), OBESE1_WEIGHT_MESSAGE_TEXT_SF);
        expect(
            calculator.getBmiMessageText(37.0), OBESE2_WEIGHT_MESSAGE_TEXT_SF);
        expect(
            calculator.getBmiMessageText(42.0), OBESE3_WEIGHT_MESSAGE_TEXT_SF);
        expect(calculator.getBmiMessageText(DEFAULT_BMI),
            DEFAULT_WEIGHT_MESSAGE_TEXT);
      });
    });

    group('getIdealWeight', () {
      test(
          'should return correct ideal weight range for metric units (height in meters)',
          () {
        // For a height of 1.75m
        // low = 18.5 * 1.75 * 1.75 = 56.6
        // high = 24.9 * 1.75 * 1.75 = 76.3
        expect(calculator.getIdealWeight(1.75, true),
            '$IDEAL_WEIGHT_MESSAGE 56.7$WEIGHT_METRIC_TEXT - 76.3$WEIGHT_METRIC_TEXT');
      });

      test(
          'should return correct ideal weight range for imperial units (height in meters)',
          () {
        // For a height of 1.75m (5.74 ft)
        // low (kg) = 56.7, low (lb) = 124.9
        // high (kg) = 76.3, high (lb) = 168.1
        expect(calculator.getIdealWeight(1.75, false),
            '$IDEAL_WEIGHT_MESSAGE 124.9$WEIGHT_IMPER_TEXT - 168.1$WEIGHT_IMPER_TEXT');
      });
    });
  });
}
