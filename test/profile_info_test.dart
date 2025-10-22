import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmi.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmr.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_state.dart';

import 'gender_selection_test.dart';

void main() {
  late ProfileCubit cubit;

  setUp(() {
    cubit = ProfileCubit( CalculateBMI(),
      CalculateBMR(),
      FakeDietitianRepository(),); 
  });

  tearDown(() {
    cubit.close();
  });

  test('updateName should change state name', () {
    cubit.updateName('John Doe');
    expect(cubit.state.name, 'John Doe');
    print('Name updated to: ${cubit.state.name}');
  });

  test('updateEmail should change state email', () {
    cubit.updateEmail('test@example.com');
    expect(cubit.state.email, 'test@example.com');
    print('Name updated to: ${cubit.state.email}');

  });

  test('updateLocation should change state location', () {
    cubit.updateLocation('South Indian');
    expect(cubit.state.location, 'South Indian');
    print('Name updated to: ${cubit.state.location}');

  });
}
