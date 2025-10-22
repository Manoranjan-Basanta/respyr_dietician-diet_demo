import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respyr_dietitian/common/widgets/audio_helper.dart';
import 'package:respyr_dietitian/core/audio/audio_state.dart';

class AudioCubitTest extends Cubit<AudioState> {
  final AudioHelper _audioHelper;

  AudioCubitTest({AudioHelper? audioHelper})
      : _audioHelper = audioHelper ?? AudioHelper(),
        super(const AudioState());

  // ... same methods as before
}
