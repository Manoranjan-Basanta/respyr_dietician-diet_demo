import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';
import 'package:respyr_dietitian/features/profile_info/data/model/dietician_detail_model.dart';

import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_state.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/pages/height_screen.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/widgets/profile_bottom_navigation.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/height_unit.dart';
import 'package:respyr_dietitian/features/profile_info/data/repository/dietician_repository.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmi.dart';
import 'package:respyr_dietitian/features/profile_info/domain/usecases/calculate_bmr.dart';

// Mock Cubit
class MockProfileCubit extends Mock implements ProfileCubit {}
class FakeProfileState extends Fake implements ProfileState {}

// Fake repository to satisfy constructor
class FakeDietitianRepository implements DietitianRepository {
  @override
  Future<DietitianDetailModel?> fetchDietitian(String id) async {
    // Return null or a fake DietitianDetailModel for testing
    return null;
  }
}
void main() {
  late ProfileCubit cubit;

  setUpAll(() {
    registerFallbackValue(FakeProfileState());
  });

  setUp(() {
    cubit = ProfileCubit(
      CalculateBMI(),
      CalculateBMR(),
      FakeDietitianRepository(),
    );

    // Stub the cubit stream and state
    when(() => cubit.state).thenReturn(const ProfileState(heightUnit: HeightUnit.cm));
    when(() => cubit.stream).thenAnswer((_) => Stream.value(const ProfileState(heightUnit: HeightUnit.cm)));
    when(() => cubit.updateHeight(any())).thenReturn(null);
    when(() => cubit.updateHeightFromFeet(any(), any())).thenReturn(null);
    when(() => cubit.updateHeightUnit(any())).thenReturn(null);
  });

  Future<void> _buildHeightScreen(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider<ProfileCubit>.value(
            value: cubit,
            child: const HeightScreen(stepCompleted: 1),
          ),
        ),
        GoRoute(
          path: '/weight',
          builder: (context, state) => const Scaffold(body: Text('WeightScreen')),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );
  }

  testWidgets('renders HeightScreen with TextFormField and Next button', (tester) async {
    await _buildHeightScreen(tester);

    expect(find.text("How tall are you?"), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ProfileBottomNavigation), findsOneWidget);
  });

  testWidgets('shows error when empty height entered', (tester) async {
    await _buildHeightScreen(tester);

    await tester.enterText(find.byType(TextFormField), '');
    await tester.pump();

    // Tap the Next button
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pump();

    expect(find.text('Please enter a valid height'), findsOneWidget); // Assuming validator shows this text
  });

  testWidgets('enters valid height and navigates to WeightScreen', (tester) async {
    await _buildHeightScreen(tester);

    await tester.enterText(find.byType(TextFormField), '170'); // cm
    await tester.pump();

    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    expect(find.text('WeightScreen'), findsOneWidget);
  });
}
