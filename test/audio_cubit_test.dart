import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/core/audio/audio_cubit.dart';
import 'package:respyr_dietitian/core/audio/audio_state.dart';

import 'FakeAudioHelper.dart';

void main() {
  group('AudioCubit', () {
    late FakeAudioHelper fakeHelper;
    late AudioCubit audioCubit;

    setUp(() {
      fakeHelper = FakeAudioHelper();
      audioCubit = AudioCubit(audioCubit: fakeHelper); // ✅ use correct param name
    });

    tearDown(() {
      audioCubit.close();
    });

    test('initial state should be not muted and not playing', () {
      expect(
        audioCubit.state,
        const AudioState(isMuted: false, isPlaying: false),
      );
    });

    test('toggleMute updates state correctly', () async {
      await audioCubit.toggleMute();
      expect(audioCubit.state.isMuted, true);

      await audioCubit.toggleMute();
      expect(audioCubit.state.isMuted, false);
    });

    test('playInhale sets isPlaying true', () async {
      await audioCubit.playInhale();
      expect(audioCubit.state.isPlaying, true);
    });

    test('stop sets isPlaying false', () async {
      await audioCubit.playInhale(); // first play
      await audioCubit.stop();       // then stop
      expect(audioCubit.state.isPlaying, false);
    });
  });
}
