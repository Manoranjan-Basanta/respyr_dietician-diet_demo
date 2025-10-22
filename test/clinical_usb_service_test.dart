import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:respyr_dietitian/core/services/usb_communication_service.dart';
import 'package:usb_serial/usb_serial.dart';

import 'MockUsbDevice_test.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Required for widget binding

  late UsbCommunicationService service;
  late MockUsbDevice mockDevice;
  late MockUsbPort mockPort;

  setUp(() {
    registerFallbackValue(Uint8List(0)); // Dummy fallback for mocktail

    service = UsbCommunicationService();
    mockDevice = MockUsbDevice(); 
    mockPort = MockUsbPort();

    when(() => mockDevice.create(any(), any())).thenAnswer((_) async => mockPort);
    when(() => mockPort.open()).thenAnswer((_) async {
      print('✅ USB Port opened'); // Print connection status
      return true;
    });
    when(() => mockPort.setDTR(true)).thenAnswer((_) async {});
    when(() => mockPort.setRTS(true)).thenAnswer((_) async {});
    when(() => mockPort.setPortParameters(any(), any(), any(), any()))
        .thenAnswer((_) async {});
    when(() => mockPort.write(any())).thenAnswer((invocation) async {
      final data = invocation.positionalArguments.first as Uint8List;
      print('📤 Command sent: ${String.fromCharCodes(data)}'); // Print sent command
    });
    when(() => mockPort.close()).thenAnswer((_) async {
      print('❌ USB Port closed');
      return true;
    });
  });

  test('✅ connectToDevice returns true on successful connection', () async {
    final result = await service.connectToDevice(mockDevice);
    print('🔌 Connection status: ${result ? "Connected" : "Failed"}');
    expect(result, isTrue);
    expect(service.isConnected, isTrue);
  });

  test('📤 sendData sends correct string with CRLF', () async {
    await service.connectToDevice(mockDevice);

    const command = '!';
    await service.sendData(command);

    verify(() => mockPort.write(Uint8List.fromList('$command\r\n'.codeUnits)))
        .called(1);
  });

  test('📥 receives and streams data', () async {
    final receivedData = <String>[];

    service.setUsbSerialListener(
      onDataReceived: (data) {
        print('📦 Data received: $data'); // Print received data
        receivedData.add(data);
      },
    );

    await service.connectToDevice(mockDevice);

    mockPort.addIncomingData("RESPYR 1.0\r\n");
    await Future.delayed(Duration(milliseconds: 100)); // Allow stream to emit

    expect(receivedData.contains("TEST1"), isTrue);
  });
}
