// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:respyr_dietitian/features/result_screen/data/models/result_model.dart';
// import 'package:respyr_dietitian/features/result_screen/presentation/cubit/result_state.dart';
// import 'package:respyr_dietitian/features/test_result_screen/presentation/cubit/test_result_cubit.dart';
// import 'package:respyr_dietitian/features/test_result_screen/presentation/cubit/test_result_state.dart';
// import 'package:respyr_dietitian/features/test_result_screen/presentation/widgets/organ_tab_selector.dart';

// class MockTestResultCubit extends Mock implements TestResultCubit {}

// void main() {
//   late MockTestResultCubit mockCubit;

//   setUp(() {
//     mockCubit = MockTestResultCubit();
//   });

//   group('🧩 OrganTabSelector Widget Test', () {
//     testWidgets('renders all organ icons correctly', (WidgetTester tester) async {
//       print('➡️ Starting test: renders all organ icons correctly');

//       when(() => mockCubit.state)
//           .thenReturn(ResultLoaded(ResultModel.dummy(), selectedTab: 'Gut') as TestResultState);

//       await tester.pumpWidget(
//         MaterialApp(
//           home: BlocProvider<TestResultCubit>.value(
//             value: mockCubit,
//             child: const Scaffold(body: OrganTabSelector()),
//           ),
//         ),
//       );

//       print('✅ Widget rendered. Checking visible organs...');

//       // "Gut" should be selected, others hidden
//       expect(find.text('Gut'), findsOneWidget);
//       expect(find.text('Liver'), findsNothing);
//       expect(find.text('Fat'), findsNothing);

//       print('✅ Gut is selected and visible, others hidden.\n');
//     });

//     testWidgets('calls changeTab when an organ is tapped', (WidgetTester tester) async {
//       print('➡️ Starting test: calls changeTab when organ tapped');

//       when(() => mockCubit.state)
//           .thenReturn(ResultLoaded(ResultModel.dummy(), selectedTab: 'Gut') as TestResultState);
//       when(() => mockCubit.changeTab(any())).thenReturn(null);

//       await tester.pumpWidget(
//         MaterialApp(
//           home: BlocProvider<TestResultCubit>.value(
//             value: mockCubit,
//             child: const Scaffold(body: OrganTabSelector()),
//           ),
//         ),
//       );

//       print('🖱️ Tapping on the Liver tab...');
//       await tester.tap(find.byType(GestureDetector).at(1));
//       await tester.pumpAndSettle();

//       verify(() => mockCubit.changeTab('Liver')).called(1);
//       print('✅ changeTab("Liver") called successfully.\n');
//     });

//     testWidgets('selected tab changes color and text visibility',
//         (WidgetTester tester) async {
//       print('➡️ Starting test: selected tab color & visibility check');

//       // Initial state Gut
//       when(() => mockCubit.state)
//           .thenReturn(ResultLoaded(ResultModel.dummy(), selectedTab: 'Gut') as TestResultState);

//       await tester.pumpWidget(
//         MaterialApp(
//           home: BlocProvider<TestResultCubit>.value(
//             value: mockCubit,
//             child: const Scaffold(body: OrganTabSelector()),
//           ),
//         ),
//       );

//       print('🔹 Initially selected tab: Gut');
//       expect(find.text('Gut'), findsOneWidget);

//       // Change state to Liver
//       when(() => mockCubit.state)
//           .thenReturn(ResultLoaded(ResultModel.dummy(), selectedTab: 'Liver') as TestResultState);
//       await tester.pump();

//       print('🔹 After state change, selected tab: Liver');
//       expect(find.text('Liver'), findsOneWidget);
//       expect(find.text('Gut'), findsNothing);

//       print('✅ Tab visibility updated correctly.\n');
//     });
//   });
// }
