import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/account_setting_screen/presentation/cubit/otp_state.dart';

void main() {
  group('OtpState', () {
    test('supports value equality', () {
      final state1 = OtpState();
      final state2 = OtpState();

      expect(state1, equals(state2));
      print("✅ OtpState equality test passed: $state1 == $state2");
    });

    test('has correct default values', () {
      const state = OtpState();

      expect(state.otp, '');
      expect(state.isLoading, false);
      expect(state.isVerified, false);
      expect(state.resendSeconds, 0);
      expect(state.error, '');

      print("✅ Default values are correct: $state");
    });

    test('copyWith updates values correctly', () {
      const state = OtpState();

      final updated = state.copyWith(
        otp: '123456',
        isLoading: true,
        isVerified: true,
        resendSeconds: 30,
        error: 'Invalid OTP',
      );

      expect(updated.otp, '123456');
      expect(updated.isLoading, true);
      expect(updated.isVerified, true);
      expect(updated.resendSeconds, 30);
      expect(updated.error, 'Invalid OTP');

      print("✅ copyWith updated values correctly: $updated");
    });

    test('copyWith keeps old values when not provided', () {
      const state = OtpState(
        otp: '111111',
        isLoading: true,
        isVerified: false,
        resendSeconds: 10,
        error: 'Some error',
      );

      final updated = state.copyWith();

      expect(updated.otp, '111111');
      expect(updated.isLoading, true);
      expect(updated.isVerified, false);
      expect(updated.resendSeconds, 10);
      expect(updated.error, 'Some error');

      print("✅ copyWith keeps old values when not provided: $updated");
    });
  });
}
