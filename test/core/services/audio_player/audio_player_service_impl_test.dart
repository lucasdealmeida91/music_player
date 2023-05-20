import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/core/services/audio_player/audio_player_service_impl.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late MockAudioPlayer mockAudioPlayer;
  late AudioPlayerServiceImpl audioPlayerServiceImpl;

  setUp(
    () {
      mockAudioPlayer = MockAudioPlayer();
      audioPlayerServiceImpl = AudioPlayerServiceImpl(mockAudioPlayer);
    },
  );

  test(
    'should get current music position',
    () async {
      when(() => mockAudioPlayer.getCurrentPosition())
          .thenAnswer((_) => Future.value(const Duration(seconds: 10)));

      final position = await audioPlayerServiceImpl.getCurrentPosition;

      verify(() => mockAudioPlayer.getCurrentPosition()).called(1);
      expect(position, equals(10));
    },
  );

  test(
    'should get audio complete stream',
    () {
      final mockStreamCtrl = StreamController<Duration>();

      when(() => mockAudioPlayer.onPositionChanged)
          .thenAnswer((_) => mockStreamCtrl.stream);

      final positionStream = audioPlayerServiceImpl.getPositionStream();

      verify(() => mockAudioPlayer.onPositionChanged).called(1);

      expect(positionStream, equals(mockStreamCtrl.stream));
    },
  );

  group(
    'Pause Music',
    () {
      test(
        'should succefully pause music',
        () async {
          when(() => mockAudioPlayer.pause()).thenAnswer((_) => Future.value());
          await audioPlayerServiceImpl.pauseMusic();
          verify(() => mockAudioPlayer.pause()).called(1);
        },
      );
      test(
        'should error on  pause music',
        () async {
          when(() => mockAudioPlayer.pause()).thenThrow(Exception());
          final futurePause = audioPlayerServiceImpl.pauseMusic();
          verify(() => mockAudioPlayer.pause()).called(1);
          expect(futurePause, throwsA(isA<AudioPlayerException>()));
        },
      );
    },
  );
}
