import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/core/utils/validators.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/height_unit.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/weight_unit.dart';

void main() {
  group('Validators Tests', () {
    group('validateAge', () {
      test('returns error when input is empty', () {
        final result = Validators.validateAge('');
        print('validateAge("") => $result');
        expect(result, "Please enter your age");
      });

      test('returns error when input is not a number', () {
        final result = Validators.validateAge('abc');
        print('validateAge("abc") => $result');
        expect(result, "Please enter a valid number");
      });

      test('returns error when age < 18', () {
        final result = Validators.validateAge('15');
        print('validateAge("15") => $result');
        expect(result, "Age must be between 18 and 100");
      });

      test('returns error when age > 100', () {
        final result = Validators.validateAge('120');
        print('validateAge("120") => $result');
        expect(result, "Age must be between 18 and 100");
      });

      test('returns null for valid age', () {
        final result = Validators.validateAge('25');
        print('validateAge("25") => $result');
        expect(result, null);
      });
    });

    group('validateWeight', () {
      test('returns error when input is empty', () {
        final result = Validators.validateWeight('', WeightUnit.kg);
        print('validateWeight("", kg) => $result');
        expect(result, "Please enter your weight");
      });

      test('returns error when input is not a number', () {
        final result = Validators.validateWeight('abc', WeightUnit.kg);
        print('validateWeight("abc", kg) => $result');
        expect(result, "Please enter a valid number");
      });

      test('returns error when weight < 20 in kg', () {
        final result = Validators.validateWeight('10', WeightUnit.kg);
        print('validateWeight("10", kg) => $result');
        expect(result, "Weight in kg must be between 20 and 250");
      });

      test('returns error when weight > 250 in kg', () {
        final result = Validators.validateWeight('300', WeightUnit.kg);
        print('validateWeight("300", kg) => $result');
        expect(result, "Weight in kg must be between 20 and 250");
      });

      test('returns null for valid weight in kg', () {
        final result = Validators.validateWeight('70', WeightUnit.kg);
        print('validateWeight("70", kg) => $result');
        expect(result, null);
      });

      test('returns error when weight < 44 in lbs', () {
        final result = Validators.validateWeight('30', WeightUnit.lbs);
        print('validateWeight("30", lbs) => $result');
        expect(result, "Weight in lbs must be between 44 and 550");
      });

      test('returns null for valid weight in lbs', () {
        final result = Validators.validateWeight('150', WeightUnit.lbs);
        print('validateWeight("150", lbs) => $result');
        expect(result, null);
      });
    });

    group('validateHeight', () {
      test('returns error when input is empty', () {
        final result = Validators.validateHeight('', HeightUnit.cm);
        print('validateHeight("", cm) => $result');
        expect(result, "Please enter your height");
      });

      test('returns error for invalid cm value', () {
        final result = Validators.validateHeight('abc', HeightUnit.cm);
        print('validateHeight("abc", cm) => $result');
        expect(result, "Please enter a valid number");
      });

      test('returns error when height < 50 cm', () {
        final result = Validators.validateHeight('40', HeightUnit.cm);
        print('validateHeight("40", cm) => $result');
        expect(result, "Height in cm must be between 50 and 280");
      });

      test('returns null for valid cm height', () {
        final result = Validators.validateHeight('170', HeightUnit.cm);
        print('validateHeight("170", cm) => $result');
        expect(result, null);
      });

      test('returns error for invalid feet format', () {
        final result = Validators.validateHeight('5.10.2', HeightUnit.feet);
        print('validateHeight("5.10.2", ft) => $result');
        expect(result, "Please enter height in feet.inches format (e.g. 5.10)");
      });

      test('returns error for feet < 1', () {
        final result = Validators.validateHeight('0.5', HeightUnit.feet);
        print('validateHeight("0.5", ft) => $result');
        expect(result, "Feet must be between 1 and 9");
      });

      test('returns error for inches > 11', () {
        final result = Validators.validateHeight('5.12', HeightUnit.feet);
        print('validateHeight("5.12", ft) => $result');
        expect(result, "Inches must be between 0 and 11");
      });

      test('returns null for valid feet.inches height', () {
        final result = Validators.validateHeight('5.10', HeightUnit.feet);
        print('validateHeight("5.10", ft) => $result');
        expect(result, null);
      });
    });

    group('validateDietitianId', () {
      test('returns error when input is empty', () {
        final result = Validators.validateDietitianId('');
        print('validateDietitianId("") => $result');
        expect(result, "Please enter your Dietitian ID");
      });

      test('returns error when ID too short', () {
        final result = Validators.validateDietitianId('ab');
        print('validateDietitianId("ab") => $result');
        expect(result, "ID must be greater than 3 characters long");
      });

      test('returns null for valid ID', () {
        final result = Validators.validateDietitianId('ABC123');
        print('validateDietitianId("ABC123") => $result');
        expect(result, null);
      });
    });
  });
}
