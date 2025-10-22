import 'package:flutter_test/flutter_test.dart';

class Age {
  final int value;

  Age(this.value) {
    if (value <= 0 || value > 120) {
      throw ArgumentError('Age must be between 1 and 120');
    }
  }

  bool get isAdult => value >= 18;

  @override
  String toString() => 'Age: $value';
}

void main() {
  group('Age Class Tests', () {
    test('Valid age should create Age object', () {
      final age = Age(25);
      print('Created Age object with value: ${age.value}');
      expect(age.value, 25);
      expect(age.isAdult, true);
      print('isAdult: ${age.isAdult}');
    });

    test('Age less than 1 should throw ArgumentError', () {
      print('Testing age 0 and -5 for ArgumentError');
      expect(() => Age(0), throwsArgumentError);
      expect(() => Age(-5), throwsArgumentError);
    });

    test('Age greater than 120 should throw ArgumentError', () {
      print('Testing age 150 for ArgumentError');
      expect(() => Age(150), throwsArgumentError);
    });

    test('Check isAdult for age under 18', () {
      final age = Age(15);
      print('Age: ${age.value}, isAdult: ${age.isAdult}');
      expect(age.isAdult, false);
    });

    test('toString returns correct string', () {
      final age = Age(30);
      print('toString output: ${age.toString()}');
      expect(age.toString(), 'Age: 30');
    });
  });
}
