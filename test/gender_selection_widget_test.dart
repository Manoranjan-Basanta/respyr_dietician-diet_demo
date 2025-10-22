import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/profile_info/data/model/dietician_detail_model.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmi.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmr.dart';
import 'package:respyr_dietitian/features/profile_info/data/repository/dietician_repository.dart';

// ✅ Fake repository that always returns a dummy dietitian
class FakeDietitianRepository implements DietitianRepository {
  @override
  Future<DietitianDetailModel?> fetchDietitian(String id) async {
    print("🔹 FakeDietitianRepository.fetchDietitian called with id: $id");

    if (id == "RespyrD01") {
      return DietitianDetailModel(
        dietitianId: "RespyrD01",
        name: "CLINICALRESPYR101",
        email: "test@respyr.com",
        location: "India",
        logoUrl: "https://dummyimage.com/logo.png",
        phoneNo: "1234567890", id: '',
      );
    }
    return null; // if unknown id
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

  test("should fetch dietitian details", () async {
    await cubit.fetchdietitianName("RespyrD01");

    print("🔹 State after fetchdietitianName: ${cubit.state}");

    expect(cubit.state.dietitianId, "RespyrD01");
    expect(cubit.state.dietitianName, "CLINICALRESPYR101");
    expect(cubit.state.email, "test@respyr.com");
  });
}
