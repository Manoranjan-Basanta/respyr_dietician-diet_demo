import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/account_setting_screen/presentation/cubit/change_password_cubit.dart';
import 'package:respyr_dietitian/features/account_setting_screen/presentation/cubit/change_password_state.dart';

void main() {
  group('ChangePasswordCubit', () {
    late ChangePasswordCubit cubit;

    setUp(() {
      cubit = ChangePasswordCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state should be default', () {
      print("🧪 Initial State: ${cubit.state}");
      expect(cubit.state, const ChangePasswordState());
    });

    test('updateNewPassword with weak password should fail validation', () {
      cubit.updateNewPassword("weak");
      final state = cubit.state;

      print("🧪 Weak password update: ${state.newPassword}");
      print("➡️ hasUppercase: ${state.hasUppercase}");
      print("➡️ hasNumber: ${state.hasNumber}");
      print("➡️ hasSpecialChar: ${state.hasSpecialChar}");
      print("➡️ hasMinLength: ${state.hasMinLength}");
      print("➡️ isSuccess: ${state.isSuccess}");

      expect(state.isSuccess, false);
      expect(state.hasUppercase, false);
      expect(state.hasNumber, false);
      expect(state.hasSpecialChar, false);
      expect(state.hasMinLength, false);
    });

    test('updateNewPassword with strong password should pass validation', () {
      cubit.updateNewPassword("Valid1@");
      final state = cubit.state;

      print("🧪 Strong password update: ${state.newPassword}");
      print("➡️ hasUppercase: ${state.hasUppercase}");
      print("➡️ hasNumber: ${state.hasNumber}");
      print("➡️ hasSpecialChar: ${state.hasSpecialChar}");
      print("➡️ hasMinLength: ${state.hasMinLength}");
      print("➡️ isSuccess: ${state.isSuccess}");

      expect(state.isSuccess, true);
      expect(state.hasUppercase, true);
      expect(state.hasNumber, true);
      expect(state.hasSpecialChar, true);
      expect(state.hasMinLength, true);
    });

    test('updateConfirmPassword should check passwordMatch correctly', () {
      cubit.updateNewPassword("Valid1@");
      cubit.updateConfirmPassword("Mismatch");

      print("🧪 Confirm password (mismatch): ${cubit.state.confirmPassword}");
      expect(cubit.state.passwordMatch, false);

      cubit.updateConfirmPassword("Valid1@");

      print("🧪 Confirm password (match): ${cubit.state.confirmPassword}");
      expect(cubit.state.passwordMatch, true);
    });

    test('submit should emit submittedSuccessfully only when valid', () {
      // Invalid flow
      cubit.updateNewPassword("weak");
      cubit.updateConfirmPassword("weak");
      cubit.submit();

      print("🧪 Submit with invalid password");
      expect(cubit.state.submittedSuccessfully, false);

      // Valid flow
      cubit.updateNewPassword("Valid1@");
      cubit.updateConfirmPassword("Valid1@");
      cubit.submit();

      print("🧪 Submit with valid password");
      expect(cubit.state.submittedSuccessfully, true);
    });
  });
}
