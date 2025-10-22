import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/core/audio/audio_cubit.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late AudioCubit cubit;
  late MockAudioHelper mockHelper;

  setUp(() {
    mockHelper = MockAudioHelper();
    cubit = AudioCubit(audioHelper: mockHelper);
  });

  test('initial state is AudioState', () {
    expect(cubit.state, const AudioState());
  });

  test('toggleMute calls audioHelper.toggleMute', () async {
    when(() => mockHelper.toggleMute()).thenAnswer((_) async {});

    await cubit.toggleMute();

    verify(() => mockHelper.toggleMute()).called(1);
  });

  test('playInhaleAudio calls audioHelper.playInhaleAudio', () async {
    when(() => mockHelper.playInhaleAudio()).thenAnswer((_) async {});

    await cubit.playInhaleAudio();

    verify(() => mockHelper.playInhaleAudio()).called(1);
  });

  // Repeat similarly for other methods:
  // playExhaleAudio, playPlaceBreatheTube, playStartBreathTest, stopAudio
}
