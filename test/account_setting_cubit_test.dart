import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/account_setting_screen/presentation/cubit/account_setting_cubit.dart';
import 'package:respyr_dietitian/features/account_setting_screen/presentation/cubit/account_setting_state.dart';

void main() {
  group('AccountSettingCubit', () {
    late AccountSettingCubit cubit;

    setUp(() {
      cubit = AccountSettingCubit();
      print("🟢 setUp: Created AccountSettingCubit with initial state: ${cubit.state}");
    });

    tearDown(() {
      cubit.close();
      print("🔴 tearDown: Closed AccountSettingCubit");
    });

    test('initial state should have default values', () {
      print("🧪 Running test: initial state should have default values");
      print("➡️ State: ${cubit.state}");
      expect(
        cubit.state,
        const AccountSettingState(
          email: "ex@gmail.com",
          name: "default",
          mobileNumber: "+9876543210",
        ),
      );
      print("✅ Initial state test passed");
    });

    test('updateName should update the name', () {
      print("🧪 Running test: updateName should update the name");
      cubit.updateName("John Doe");
      print("➡️ Updated state: ${cubit.state}");
      expect(cubit.state.name, "John Doe");
      print("✅ updateName test passed rsth");
    });

    test('updateMobileNumber should update the number', () {
      print("🧪 Running test: updateMobileNumber should update the number");
      cubit.updateMobileNumber("+1234567890");
      print("➡️ Updated state: ${cubit.state}");
      expect(cubit.state.mobileNumber, "+1234567890");
      print("✅ updateMobileNumber test passed");
    });

    test('updateEmail should update the email', () {
      print("🧪 Running test: updateEmail should update the email");
      cubit.updateEmail("john@example.com");
      print("➡️ Updated state: ${cubit.state}");
      expect(cubit.state.email, "john@example.com");
      print("✅ updateEmail test passed");
    });

    test('changePassword should print Navigate to OTP Screen', () {
      print("🧪 Running test: changePassword should print Navigate to OTP Screen");
      expect(
        () => cubit.changePassword(),
        prints(contains("Navigate to OTP Screen")),
      );
      print("✅ changePassword test passed");
    });
  });
}
