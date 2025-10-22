import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/account_setting_screen/presentation/cubit/change_password_state.dart';

void main() {
  group('ChangePasswordState', () {
    const initialState = ChangePasswordState();

    test('initial state should have default values', () {
      
      print("🧪 Testing initial ChangePasswordState");
      print("➡️ State: $initialState");

      expect(initialState.newPassword, '');
      expect(initialState.confirmPassword, '');
      expect(initialState.isSuccess, false);
      expect(initialState.passwordMatch, true);
      expect(initialState.showErrors, false);
      expect(initialState.hasUppercase, false);
      expect(initialState.hasNumber, false);
      expect(initialState.hasSpecialChar, false);
      expect(initialState.hasMinLength, false);
      expect(initialState.submittedSuccessfully, false);

      print("✅ Initial state test passed");
    });

    test('copyWith should update newPassword', () {
      final updated = initialState.copyWith(newPassword: "MyNewPass123!");

      print("🧪 Testing copyWith newPassword");
      print("➡️ Updated: $updated");

      expect(updated.newPassword, "MyNewPass123!");
      expect(updated.confirmPassword, initialState.confirmPassword);
      print("✅ copyWith newPassword test passed");
    });

    test('copyWith should update confirmPassword', () {
      final updated = initialState.copyWith(confirmPassword: "ConfirmPass!");

      print("🧪 Testing copyWith confirmPassword");
      print("➡️ Updated: $updated");

      expect(updated.confirmPassword, "ConfirmPass!");
      expect(updated.newPassword, initialState.newPassword);
      print("✅ copyWith confirmPassword test passed");
    });

    test('copyWith should update boolean flags', () {
      final updated = initialState.copyWith(
        isSuccess: true,
        passwordMatch: false,
        showErrors: true,
        hasUppercase: true,
        hasNumber: true,
        hasSpecialChar: true,
        hasMinLength: true,
        submittedSuccessfully: true,
      );

      print("🧪 Testing copyWith with all boolean updates");
      print("➡️ Updated: $updated");

      expect(updated.isSuccess, true);
      expect(updated.passwordMatch, false);
      expect(updated.showErrors, true);
      expect(updated.hasUppercase, true);
      expect(updated.hasNumber, true);
      expect(updated.hasSpecialChar, true);
      expect(updated.hasMinLength, true);
      expect(updated.submittedSuccessfully, true);

      print("✅ copyWith boolean flags test passed");
    });

    test('two states with same values should be equal', () {
      const state1 = ChangePasswordState(newPassword: "Pass123!");
      const state2 = ChangePasswordState(newPassword: "Pass123!");

      print("🧪 Testing equality between states");
      print("➡️ state1: $state1");
      print("➡️ state2: $state2");

      expect(state1, equals(state2));
      print("✅ Equality test passed");
    });
  });
}
