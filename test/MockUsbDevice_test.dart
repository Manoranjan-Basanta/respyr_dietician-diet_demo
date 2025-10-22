import 'dart:async';
import 'dart:typed_data';

import 'package:mocktail/mocktail.dart';
import 'package:usb_serial/usb_serial.dart';

class MockUsbDevice extends Mock implements UsbDevice {}

class MockUsbPort extends Mock implements UsbPort {
  final _controller = StreamController<Uint8List>.broadcast();

  @override
  Stream<Uint8List> get inputStream => _controller.stream;

  void addIncomingData(String data) {
    _controller.add(Uint8List.fromList(data.codeUnits));
  }

  void closeStream() {
    _controller.close();
  }
}

