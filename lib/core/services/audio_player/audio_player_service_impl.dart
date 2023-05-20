// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_app/core/error/exceptions.dart';

import './audio_player_service.dart';

class AudioPlayerServiceImpl extends GetxService implements AudioPlayerService {
  final AudioPlayer audioPlayer;
  AudioPlayerServiceImpl(
    this.audioPlayer,
  );
  @override
  Future<int> get getCurrentPosition async {
    try {
      final position = await audioPlayer.getCurrentPosition();
      return position?.inSeconds ?? 0;
    } catch (error, stackTrace) {
      const message = 'erro ao pegar posicao da muscica';
      log(
        message,
        error: error,
        stackTrace: stackTrace,
      );
      throw AudioPlayerException(message: message);
    }
  }

  @override
  Stream<Duration> getPositionStream() {
    return audioPlayer.onPositionChanged;
  }

  @override
  Stream<void> onAudioComplete() {
    return audioPlayer.onPlayerComplete;
  }

  @override
  Future<void> pauseMusic() {
    return callAudioPlayerServiceTryAndTryCatchFunction(
        () => audioPlayer.pause(), 'erro ao pausar a muscica');
  }

  @override
  Future<void> playMusic(String audioUrlAsset) {
    return callAudioPlayerServiceTryAndTryCatchFunction(
        () => audioPlayer.play(AssetSource(audioUrlAsset)),
        'erro ao carregar a muscica');
  }

  Future<void> callAudioPlayerServiceTryAndTryCatchFunction(
    Future<void> Function() tryFunction,
    String audioPlayerExceptionMessage,
  ) async {
    try {
      await tryFunction();
    } catch (error, stackTrace) {
      final message = audioPlayerExceptionMessage;
      log(
        message,
        error: error,
        stackTrace: stackTrace,
      );
      throw AudioPlayerException(message: message);
    }
  }

  @override
  Future<void> resumeMusic() {
    return callAudioPlayerServiceTryAndTryCatchFunction(
        () => audioPlayer.resume(), 'erro ao continuar a muscica');
  }

  @override
  Future<void> seek(int seconds) {
    return callAudioPlayerServiceTryAndTryCatchFunction(() {
      final seekTo = Duration(seconds: seconds);
      return audioPlayer.seek(seekTo);
    }, 'erro ao trocar duracao da muscica');
  }

  @override
  Future<void> stopMusic() {
    return callAudioPlayerServiceTryAndTryCatchFunction(
        () => audioPlayer.stop(), 'erro ao parar a muscica');
  }

  @override
  void onClose() {
    audioPlayer
      ..stop()
      ..dispose();
    super.onClose();
  }
}
