import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/profile_info/data/model/dietician_detail_model.dart';
import 'package:respyr_dietitian/features/profile_info/data/repository/dietician_repository.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmi.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmr.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';

class FakeDietitianRepository implements DietitianRepository {
  @override
  Future<DietitianDetailModel?> fetchDietitian(String id) async {
    return null;
  }
}

void main() {
  late ProfileCubit cubit;

  setUp(() {
    cubit = ProfileCubit(
      CalculateBMI(),
      CalculateBMR(),
      FakeDietitianRepository(),
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  test('BMI and BMR are null initially', () {
    expect(cubit.getBMI(), isNull);
    expect(cubit.getBMR(), isNull);
  });

  test('BMI and BMR are calculated when height, weight, gender, and age are set', () {
    cubit.updateHeight(180.0); // ✅ double
    cubit.updateWeight(75.0);  // ✅ double
    cubit.updateGender("male");
    cubit.updateAge(25);       // ✅ int

    final bmi = cubit.getBMI();
    final bmr = cubit.getBMR();

    print("👉 Calculated BMI=$bmi, BMR=$bmr");
  
    expect(bmi, isNotNull);
    expect(bmr, isNotNull);
    expect(bmi!.toStringAsFixed(1), equals("23.1")); // 75 / (1.8 * 1.8)
  });
}
