// test/result_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/result_screen/data/models/result_model.dart';

void main() {
  group('ResultModel', () {
    test('fromJson parses valid data correctly', () {
      final json = {
        "data": [
          {
            "bmi": "22.5",
            "bmr": "1500",
            "dttm": "1747910241",
            "gut_absorptive": "80",
            "gut_fermentative": "85",
            "fat_metabolism": "70",
            "glucose": "90",
            "hepatic": "75",
            "detox": "88"
          }
        ]
      };

      final result = ResultModel.fromJson(json);

      expect(result.bmi, 22.5);
      expect(result.bmr, 1500.0);
      expect(result.dttm, 1747910241);
      expect(result.gutAbsorptiveScore, 80.0);
      expect(result.gutFermentativeScore, 85.0);
      expect(result.fatMetabolismScore, 70.0);
      expect(result.glucoseMetabolismScore, 90.0);
      expect(result.hepaticScore, 75.0);
      expect(result.detoxScore, 88.0);
      print('result: $result');
    });

    test('fromJson handles missing values with defaults', () {
      final json = {
        "data": [
          {
            "bmi": null,
            "bmr": null,
            "dttm": null,
            "gut_absorptive": null,
            "gut_fermentative": null,
            "fat_metabolism": null,
            "glucose": null,
            "hepatic": null,
            "detox": null
          }
        ]
      };

      final result = ResultModel.fromJson(json);

      expect(result.bmi, 0.0);
      expect(result.bmr, 0.0);
      expect(result.dttm, 0);
      expect(result.gutAbsorptiveScore, 97.0);
      expect(result.gutFermentativeScore, 95.0);
      expect(result.fatMetabolismScore, 91.0);
      expect(result.glucoseMetabolismScore, 92.0);
      expect(result.hepaticScore, 85.0);
      expect(result.detoxScore, 89.0);
      print('result with defaults: $result');
    });

    test('dummy factory creates valid dummy data', () {
      final result = ResultModel.dummy();

      expect(result.bmi, 25.0);
      expect(result.bmr, 1827.0);
      expect(result.gutAbsorptiveScore, 75.0);
      expect(result.gutFermentativeScore, 90.0);
      expect(result.fatMetabolismScore, 51.0);
      expect(result.glucoseMetabolismScore, 43.0);
      expect(result.hepaticScore, 74.0);
      expect(result.detoxScore, 89.0);
      print('dummy result: $result');
    });
  });
}
