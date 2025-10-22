import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:respyr_dietitian/common/widgets/internet_connectivity_handler.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('dev.fluttercommunity.plus/connectivity');
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Reset mocks before each test
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('renders child when internet is available',
      (WidgetTester tester) async {
    // Simulate wifi connection (1 = wifi)
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      if (call.method == 'check') return 1;
      return null;
    });

    await tester.pumpWidget(
      MaterialApp(
        home: InternetConnectivityHandler(
          child: const Text('Online Child'),
          isBody: true,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Online Child'), findsOneWidget);
    expect(find.text('No Internet Connection'), findsNothing);
  });

  testWidgets('shows in-body no internet widget when isBody=true',
      (WidgetTester tester) async {
    // Simulate no internet (0 = none)
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      if (call.method == 'check') return 0;
      return null;
    });

    await tester.pumpWidget(
      MaterialApp(
        home: InternetConnectivityHandler(
          child: const Text('Child'),
          isBody: true,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('No Internet Connection'), findsOneWidget);
  });

  testWidgets('shows dialog when no internet and isBody=false',
      (WidgetTester tester) async {
    // Simulate no internet (0 = none)
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      if (call.method == 'check') return 0;
      return null;
    });

    await tester.pumpWidget(
      MaterialApp(
        home: InternetConnectivityHandler(
          child: const Text('Child'),
          isBody: false,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(
      find.text(
          'No internet connection detected. Please check your connection and try again.'),
      findsOneWidget,
    );
  });

  testWidgets('calls onConnectivityChanged when connection changes',
      (WidgetTester tester) async {
    bool? callbackValue;

    // First return wifi, then no internet
    int callCount = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      if (call.method == 'check') {
        if (callCount == 0) {
          callCount++;
          return 1; // wifi
        } else {
          return 0; // none
        }
      }
      return null;
    });

    await tester.pumpWidget(
      MaterialApp(
        home: InternetConnectivityHandler(
          child: const Text('Child'),
          isBody: true,
          onConnectivityChanged: (hasInternet) {
            callbackValue = hasInternet;
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    // First time wifi → callback true
    expect(callbackValue, true);

    // Trigger second check (simulate connection loss)
    await tester.pumpWidget(
      MaterialApp(
        home: InternetConnectivityHandler(
          child: const Text('Child'),
          isBody: true,
          onConnectivityChanged: (hasInternet) {
            callbackValue = hasInternet;
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Now should be false
    expect(callbackValue, false);
  });
}
