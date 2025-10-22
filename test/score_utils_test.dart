import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/core/utils/score_utils.dart';

void main() {
  group('getScoreLevel', () {
    test('returns Poor for score between 0–60', () {
      final result = getScoreLevel(45);
      print('Score: 45 → Label: ${result.label}, Color: ${result.color}');
      expect(result.label, 'Poor');
      expect(result.color, const Color(0xFFEA5455));
    });

    test('returns Fair for score between 61–79', () {
      final result = getScoreLevel(70);
      print('Score: 70 → Label: ${result.label}, Color: ${result.color}');
      expect(result.label, 'Fair');
      expect(result.color, const Color(0xFFFFC412));
    });

    test('returns Good for score between 80–100', () {
      final result = getScoreLevel(95);
      print('Score: 95 → Label: ${result.label}, Color: ${result.color}');
      expect(result.label, 'Good');
      expect(result.color, const Color(0xFF3EAF58));
    });

    test('returns Invalid for out-of-range values', () {
      final result = getScoreLevel(120);
      print('Score: 120 → Label: ${result.label}, Color: ${result.color}');
      expect(result.label, 'Invalid');
      expect(result.color, Colors.grey);
    });
  });

  group('ScoreColorHelper', () {
    test('returns correct single color', () {
      final goodColor = ScoreColorHelper.getScoreColor(90);
      final fairColor = ScoreColorHelper.getScoreColor(75);
      final poorColor = ScoreColorHelper.getScoreColor(50);

      print('Good score color: $goodColor');
      print('Fair score color: $fairColor');
      print('Poor score color: $poorColor');

      expect(goodColor, const Color(0xFF3EAF58));
      expect(fairColor, const Color(0xFFFFC412));
      expect(poorColor, const Color(0xFFEA5455));
    });

    test('returns correct linear gradient colors', () {
      final goodGradient = ScoreColorHelper.getLinearScoreColor(90);
      final fairGradient = ScoreColorHelper.getLinearScoreColor(75);
      final poorGradient = ScoreColorHelper.getLinearScoreColor(40);

      print('Good gradient: $goodGradient');
      print('Fair gradient: $fairGradient');
      print('Poor gradient: $poorGradient');

      expect(goodGradient, [const Color(0xFF3FAF58), const Color(0xFF009245)]);
      expect(fairGradient, [const Color(0xFFFFC412), const Color(0xFFE3AC06)]);
      expect(poorGradient, [const Color(0xFFEA5455), const Color(0xFFC1272D)]);
    });
  });
}
