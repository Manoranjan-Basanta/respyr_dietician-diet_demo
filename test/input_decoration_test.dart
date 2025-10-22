import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:respyr_dietitian/common/widgets/text_input_decoration.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('buildInputDecoration', () {
    test('returns correct InputDecoration with hintText and prefixIcon', () {
      const hintText = 'Enter your name';
      const prefixPath = 'assets/icons/user.svg';

      final decoration = buildInputDecoration(
        hintText: hintText,
        prefixIcon: prefixPath,
      );

      print('--- Decoration Details ---');
      print('Hint Text: ${decoration.hintText}');
      print('Filled: ${decoration.filled}');
      print('Fill Color: ${decoration.fillColor}');
      print('Prefix Icon: ${decoration.prefixIcon}');
      print('Hint Style: ${decoration.hintStyle}');
      print('Border: ${decoration.border}');
      print('---------------------------');

      expect(decoration.hintText, equals(hintText));
      expect(decoration.filled, isTrue);
      expect(decoration.fillColor, const Color(0xFFF8F8F8));
      expect(decoration.errorText, isNull);
    });

    test('applies errorText correctly', () {
      const errorText = 'Invalid input';

      final decoration = buildInputDecoration(
        hintText: 'Enter value',
        errorText: errorText,
      );

      print('Error Text: ${decoration.errorText}');
      print('Error Style: ${decoration.errorStyle}');

      expect(decoration.errorText, equals(errorText));
      expect(decoration.errorStyle!.color, const Color(0xFFDF2F32));
    });

    test('uses no border when readOnly is true', () {
      final decoration = buildInputDecoration(
        hintText: 'Read-only field',
        readOnly: true,
      );

      print('ReadOnly Enabled Border: ${decoration.enabledBorder}');
      print('ReadOnly Focused Border: ${decoration.focusedBorder}');

      expect(decoration.enabledBorder!.borderSide.style, BorderStyle.none);
      expect(decoration.focusedBorder!.borderSide.style, BorderStyle.none);
    });

    test('uses normal border when readOnly is false', () {
      final decoration = buildInputDecoration(
        hintText: 'Editable field',
        readOnly: false,
      );

      print('Normal Enabled Border Color: ${decoration.enabledBorder!.borderSide.color}');
      print('Normal Focused Border Color: ${decoration.focusedBorder!.borderSide.color}');

      expect(decoration.enabledBorder!.borderSide.color, const Color(0xFFF0F0F0));
      expect(decoration.focusedBorder!.borderSide.color, const Color(0xFFF0F0F0));
    });
  });
}
