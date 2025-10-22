import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/account_setting_screen/presentation/cubit/account_setting_state.dart';

void main() {
  group('AccountSettingState', () {
    const initialState = AccountSettingState(
      email: "ex@gmail.com",
      name: "default",
      mobileNumber: "+9876543210",
    );

    test('initial state values should be correct', () {
      print("🧪 Testing initial state values");
      print("➡️ State: $initialState");

      expect(initialState.email, "ex@gmail.com");
      expect(initialState.name, "default");
      expect(initialState.mobileNumber, "+9876543210");
      expect(initialState.isLoading, false);

      print("✅ Initial state test passed");
    });

    test('copyWith should update name', () {
      final updated = initialState.copyWith(name: "John Doe");

      print("🧪 Testing copyWith for name");
      print("➡️ Updated: $updated");

      expect(updated.name, "John Doe");
      expect(updated.email, initialState.email);
      expect(updated.mobileNumber, initialState.mobileNumber);
      expect(updated.isLoading, initialState.isLoading);

      print("✅ copyWith name test passed");
    });

    test('copyWith should update mobileNumber', () {
      final updated = initialState.copyWith(mobileNumber: "+1234567890");

      print("🧪 Testing copyWith for mobileNumber");
      print("➡️ Updated: $updated");

      expect(updated.mobileNumber, "+1234567890");
      expect(updated.name, initialState.name);

      print("✅ copyWith mobileNumber test passed");
    });

    test('copyWith should update email', () {
      final updated = initialState.copyWith(email: "john@example.com");

      print("🧪 Testing copyWith for email");
      print("➡️ Updated: $updated");

      expect(updated.email, "john@example.com");
      expect(updated.name, initialState.name);

      print("✅ copyWith email test passed");
    });

    test('copyWith should update isLoading', () {
      final updated = initialState.copyWith(isLoading: true);

      print("🧪 Testing copyWith for isLoading");
      print("➡️ Updated: $updated");

      expect(updated.isLoading, true);
      expect(updated.name, initialState.name);

      print("✅ copyWith isLoading test passed");
    });

    test('two states with same values should be equal', () {
      const state1 = AccountSettingState(
        email: "ex@gmail.com",
        name: "default",
        mobileNumber: "+9876543210",
      );
      const state2 = AccountSettingState(
        email: "ex@gmail.com",
        name: "default",
        mobileNumber: "+9876543210",
      );

      print("🧪 Testing equality of two identical states");
      print("➡️ state1: $state1");
      print("➡️ state2: $state2");

      expect(state1, equals(state2));
      print("✅ Equality test passed");
    });
  });
}
