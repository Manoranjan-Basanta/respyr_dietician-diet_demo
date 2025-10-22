import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_state.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/pages/age_screen.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/widgets/profile_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

// Mock ProfileCubit
class MockProfileCubit extends Mock implements ProfileCubit {}
class FakeProfileState extends Fake implements ProfileState {}

void main() {
  late ProfileCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeProfileState());
  });

  setUp(() {
    mockCubit = MockProfileCubit();
    when(() => mockCubit.state).thenReturn(const ProfileState());
    when(() => mockCubit.validateAgeInput(any())).thenReturn(null);
    when(() => mockCubit.updateAge(any())).thenReturn(null);
    when(() => mockCubit.stream)
        .thenAnswer((_) => Stream.value(const ProfileState())); // ✅ provide stream
  });

  Future<void> _buildAgeScreen(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider<ProfileCubit>.value(
            value: mockCubit,
            child: const AgeScreen(stepCompleted: 1),
          ),
        ),
        GoRoute(
          path: '/height',
          builder: (context, state) =>
              const Scaffold(body: Text('HeightScreen')),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  testWidgets('renders AgeScreen with TextFormField and Next button',
      (tester) async {
    await _buildAgeScreen(tester);

    expect(find.text("What’s your Age?"), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ProfileBottomNavigation), findsOneWidget);
  });

  testWidgets('shows error when empty age entered', (tester) async {
    when(() => mockCubit.validateAgeInput(''))
        .thenReturn('Age cannot be empty');

    await _buildAgeScreen(tester);

    await tester.enterText(find.byType(TextFormField), '');
    await tester.pump();

    // Tap the Next button using Key
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pump();

    expect(find.text('Age cannot be empty'), findsOneWidget);
  });

  testWidgets('enters valid age and navigates to HeightScreen', (tester) async {
    when(() => mockCubit.validateAgeInput('25')).thenReturn(null);

    await _buildAgeScreen(tester);

    await tester.enterText(find.byType(TextFormField), '25');
    await tester.pump();

    // Tap the Next button using Key
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    // Verify navigation to height screen
    expect(find.text('HeightScreen'), findsOneWidget);
  });
}
