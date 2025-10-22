import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/profile_info/data/model/dietician_detail_model.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmi.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmr.dart';
import 'package:respyr_dietitian/features/profile_info/data/repository/dietician_repository.dart';

class FakeDietitianRepository implements DietitianRepository {
  @override
  Future<DietitianDetailModel?> fetchDietitian(String id) async {
    print("🔹 FakeDietitianRepository.fetchDietitian called with id: $id");
    return null; // return dummy DietitianDetailModel if needed
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
    print("✅ Cubit initialized");
  });

  test("should update age", () {
    cubit.updateAge(25);
    print("🔹 Age updated to: ${cubit.state.age}");
    expect(cubit.state.age, 25);
  });

  test("should update height", () {
    cubit.updateHeight(180);
    print("🔹 Height updated to: ${cubit.state.height}");
    expect(cubit.state.height, 180);
  });

  test("should calculate BMI correctly", () {
    cubit.updateWeight(75);
    cubit.updateHeight(180);

    final bmi = cubit.getBMI();
    print("🔹 Calculated BMI: $bmi");

    expect(bmi, closeTo(23.15, 0.01)); // ~23.15
  });

  test("should call fetchdietitianName()", () async {
    await cubit.fetchdietitianName("RespyrD01");
    print("🔹 State after fetchdietitianName: ${cubit.state}");
    expect(cubit.state.dietitianName, anyOf(["NotFound", "Error", ""]));
  });
}
