import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:respyr_dietitian/common/widgets/profile_avatar.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_cubit.dart';
import 'package:respyr_dietitian/features/profile_info/presentation/cubit/profile_state.dart';

class MockProfileCubit extends Mock implements ProfileCubit {}

void main() {
  late MockProfileCubit mockCubit;

  setUp(() {
    mockCubit = MockProfileCubit();
  });

  testWidgets('✅ displays network image when dietitianImageUrl is available',
      (WidgetTester tester) async {
    print('--- Running test: Network Image Case ---');

    // Arrange
    final state = ProfileState(
      profileImage: null,
      dietitianImageUrl: 'https://example.com/image.jpg',
    );

    when(() => mockCubit.state).thenReturn(state);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProfileCubit>.value(
          value: mockCubit,
          child: const ProfileAvatar(),
        ),
      ),
    );

    print('Checking if CircleAvatar exists...');
    expect(find.byType(CircleAvatar), findsOneWidget);

    final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
    final image = avatar.backgroundImage as NetworkImage;

    print('NetworkImage URL: ${image.url}');
    expect(image.url, equals(state.dietitianImageUrl));

    print('✅ Network image test passed!');
  });

  testWidgets('✅ displays local memory image when profileImage is available',
      (WidgetTester tester) async {
    print('--- Running test: Local Memory Image Case ---');

    // Arrange
    final fakeBytes = Uint8List.fromList([0, 1, 2, 3]);
    final state = ProfileState(
      profileImage: fakeBytes,
      dietitianImageUrl: '',
    );

    when(() => mockCubit.state).thenReturn(state);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProfileCubit>.value(
          value: mockCubit,
          child: const ProfileAvatar(),
        ),
      ),
    );

    print('Checking for CircleAvatar...');
    final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
    expect(avatar.backgroundImage, isA<MemoryImage>());
    print('Memory image found successfully.');

    print('✅ Local memory image test passed!');
  });

  testWidgets('✅ displays fallback SVG when no image is available',
      (WidgetTester tester) async {
    print('--- Running test: Fallback SVG Case ---');

    // Arrange
    final state = ProfileState(
      profileImage: null,
      dietitianImageUrl: '',
    );

    when(() => mockCubit.state).thenReturn(state);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProfileCubit>.value(
          value: mockCubit,
          child: const ProfileAvatar(),
        ),
      ),
    );

    print('Checking fallback SVG...');
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);

    print('✅ Fallback SVG test passed!');
  });
}
