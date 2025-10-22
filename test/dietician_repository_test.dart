import 'dart:convert';
import 'package:respyr_dietitian/features/profile_info/data/model/dietician_detail_model.dart';
import 'package:respyr_dietitian/features/profile_info/data/repository/dietician_repository.dart';

class FakeDietitianRepository extends DietitianRepository {
  final String fakeResponse;
  final int statusCode;

  FakeDietitianRepository({
    required this.fakeResponse,
    this.statusCode = 200,
  });

  @override
  Future<DietitianDetailModel?> fetchDietitian(String identifier) async {
    print("🧪 Fake fetchDietitian called with identifier: $identifier");

    if (statusCode != 200) {
      print("❌ Returning null (statusCode=$statusCode)");
      return null;
    }

    final jsonResponse = json.decode(fakeResponse);
    if (jsonResponse['success'] == true) {
      final model = DietitianDetailModel.fromJson(jsonResponse);
      print("✅ Fake Response Model: $model");
      print("🧑 Name: ${model.name}");
      print("📧 Email: ${model.email}");
      return model;
    }
    print("❌ Returning null (success=false)");
    return null;
  }
}
