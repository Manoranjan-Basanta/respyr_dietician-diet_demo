import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/profile_info/data/model/dietician_detail_model.dart';

import 'dietician_repository_test.dart' show FakeDietitianRepository;

void main() {
  group('FakeDietitianRepository', () {
    test('returns DietitianDetailModel when success is true', () async {
      final repo = FakeDietitianRepository(
        fakeResponse: '''
        {
          "success": true,
          "data": {
            "id": "1",
            "name": "Dt. Manoranjan",
            "email": "Manoranjan@diet.com"
          }
        }
        ''',
      );

      final result = await repo.fetchDietitian("test123");

      // Debug prints
      print("✅ Got result: $result");
      print("🧑 Name: ${result?.name}");
      print("📧 Email: ${result?.email}");
      print("🆔 ID: ${result?.id}");

      expect(result, isA<DietitianDetailModel>());
      expect(result?.name, equals("Dt. Manoranjan"));
      expect(result?.email, equals("Manoranjan@diet.com"));
      expect(result?.id, equals("1"));
    });

    test('returns null when success is false', () async {
      final repo = FakeDietitianRepository(
        fakeResponse: '''
        {
          "success": false
        }
        ''',
      );

      final result = await repo.fetchDietitian("test123");

      // Debug prints
      print("❌ Got null result because success=false: $result");

      expect(result, isNull);
    });

    test('returns null when statusCode != 200', () async {
      final repo = FakeDietitianRepository(
        fakeResponse: '{}',
        statusCode: 500,
      );

      final result = await repo.fetchDietitian("test123");

      // Debug prints
      print("❌ Got null result because statusCode != 200: $result");

      expect(result, isNull);
    });
  });
}
