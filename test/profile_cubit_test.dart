// import 'package:flutter_test/flutter_test.dart';
// import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';
// import 'package:respyr_dietitian/features/profile_info/data/repository/dietician_repository.dart';
// import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmi.dart';
// import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmr.dart';

// /// Fake repository for testing
// class FakeDietitianRepository implements DietitianRepository {
//   @override
//   Future fetchDietitian(String id) async => null;
// }

// /// Fake BMI calculator
// class FakeCalculateBMI extends CalculateBMI {
//   @override
//   double call(double weightKg, double heightCm) => 22.0;
// }

// /// Fake BMR calculator
// class FakeCalculateBMR extends CalculateBMR {
//   @override
//   double call({
//     required double weightKg,
//     required double heightCm,
//     required int age,
//     required String? gender,
//   }) {
//     return 1500.0;
//   }
// }

// void main() {
//   late ProfileCubit cubit;

//   setUp(() {
//     cubit = ProfileCubit(
//       FakeCalculateBMI(),
//       FakeCalculateBMR(),
//       FakeDietitianRepository(),
//     );
//   });

//   test('should return error when age is empty', () {
//     final result = cubit.validateAgeInput('');
//     expect(result, 'Age cannot be empty');
//   });

//   test('should return error when age is invalid', () {
//     final result = cubit.validateAgeInput('abc');
//     expect(result, 'Please enter a valid age');
//   });

//   test('should return error when age < 1', () {
//     final result = cubit.validateAgeInput('0');
//     expect(result, 'Age must be between 1 and 120');
//   });

//   test('should return error when age > 120', () {
//     final result = cubit.validateAgeInput('200');
//     expect(result, 'Age must be between 1 and 120');
//   });

//   test('should return null when age is valid', () {
//     final result = cubit.validateAgeInput('25');
//     expect(result, null);
//   });
// }
