import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respyr_dietitian/features/profile_info/data/model/dietician_detail_model.dart';
import 'package:respyr_dietitian/features/profile_info/data/repository/dietician_repository.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmi.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmr.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/pages/profile_info_screen.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_state.dart';



/// ✅ Fake repository that satisfies the interface
class FakeDietitianRepository implements DietitianRepository {
  @override
  Future<DietitianDetailModel?> fetchDietitian(String id) async {  
 print("FakeDietitianRepository.fetchDietitian called with id=$id");

    // For testing we just return null or a dummy model

    return null;
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
   print("✅ Cubit created with initial state: ${cubit.state}");

  });

  tearDown(() {
    cubit.close();
  });

  testWidgets('ProfileInfoScreen form input updates cubit',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const ProfileInfoScreen(stepCompleted: 0),
        ),
      ),
    );

    // Act
    final nameField = find.byType(TextFormField).at(0);
    final emailField = find.byType(TextFormField).at(1);

    await tester.enterText(nameField, 'John Doe');
    await tester.enterText(emailField, 'test@example.com');
    await tester.pump();
    print("👉 Entered name=${cubit.state.name}, email=${cubit.state.email}");
    

    // Assert
    expect(cubit.state.name, 'John Doe');
    expect(cubit.state.email, 'test@example.com');
    print("✅ Assertions passed for form input updates");

  });

  testWidgets('Shows validation error if name is too short',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const ProfileInfoScreen(stepCompleted: 0),
        ),
        
      ),
      
    );
    print("✅ ProfileInfoScreen pumped for validation test");


    final nameField = find.byType(TextFormField).at(0);
    await tester.enterText(nameField, 'Jo');
    await tester.tap(find.byType(TextFormField).at(1)); // unfocus to trigger validation
    await tester.pump();
    print("⚠️ Validation error displayed as expected");


    expect(find.text('Name must be at least 3 characters long'), findsOneWidget);
  });
  print("✅ Assertions passed for validation error");

}
