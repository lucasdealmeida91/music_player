// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/core/extensions/media_query_extensions.dart';
import 'package:music_app/core/mixin/snack_bar_mixin.dart';
import 'package:music_app/core/services/audio_player/audio_player_service.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/music_player_widget.dart';
import 'package:music_app/shared/model/music_model.dart';

class MusicPlayerController with SnackBarMixin {
  final AudioPlayerService _audioPlayerService;
  MusicPlayerController({
    required AudioPlayerService audioPlayerService,
  }) : _audioPlayerService = audioPlayerService {
    _audioCompleteStreamSubscription =
        _audioPlayerService.onAudioComplete().listen((event) {
      skipTrack();
    });
  }
  StreamSubscription? _audioCompleteStreamSubscription;
  final RxBool isPlaying = false.obs;
  final RxInt currentMusicDuration = 0.obs;
  final RxnInt currentMusicIndexPlaying = RxnInt();
  int? get getCurrentMusicIndexPlaying => currentMusicIndexPlaying.value;
  final RxList<MusicModel> _playlistPlaying = <MusicModel>[].obs;
  List<MusicModel> get getPlaylistPlaying => _playlistPlaying;
  final List<MusicModel> selectedPlaylist = [];
  Stream<Duration> get getCurrentPositionStream =>
      _audioPlayerService.getPositionStream();
  Future<void> seek(int seekToDurationInSeconds) =>
      _audioPlayerService.seek(seekToDurationInSeconds);
  void loadPlaylist(
      List<MusicModel> newPlaylist, List<MusicModel> playlistToChange) {
    playlistToChange
      ..clear()
      ..addAll(newPlaylist);
  }

  Future<void> onCallMusicPlayerTryAndCatchFunction(
      Future<void> Function() tryFunction) async {
    try {
      await tryFunction();
    } on AudioPlayerException catch (error) {
      showErrorSnackBar(error.message);
    }
  }

  Future<void> playMusic(String url) async {
    onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = true;
      await _audioPlayerService.playMusic(url);
    });
  }

  Future<void> stopMusic() async {
    onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = false;
      await _audioPlayerService.stopMusic();
    });
  }

  Future<void> loadMusic() async {
    onCallMusicPlayerTryAndCatchFunction(() async {
      loadPlaylist(selectedPlaylist, _playlistPlaying);
      await stopMusic();

      await playMusic(_playlistPlaying[getCurrentMusicIndexPlaying ?? 0].url);
    });
  }

  Future<void> pauseMusic() async {
    onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = false;

      await _audioPlayerService.pauseMusic();
    });
  }

  Future<void> skipTrack() async {
    if (getCurrentMusicIndexPlaying != null) {
      if (getCurrentMusicIndexPlaying! < _playlistPlaying.length - 1) {
        currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! + 1;
      } else {
        currentMusicIndexPlaying.value = 0;
      }
      await loadMusic();
    }
  }

  MusicModel? get getCurrentPlayingMusic {
    if (getCurrentMusicIndexPlaying != null) {
      return _playlistPlaying[getCurrentMusicIndexPlaying!];
    }
    return null;
  }

  Future<void> backTrack() async {
    if (getCurrentMusicIndexPlaying != null &&
        getCurrentMusicIndexPlaying! > 0) {
      currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! - 1;
    } else {
      currentMusicIndexPlaying.value = _playlistPlaying.length - 1;
    }
    await loadMusic();
  }

  void dispose() {
    _audioCompleteStreamSubscription?.cancel();
  }

  Future<void> loadCurrentMusicDuration() async {
    if (isPlaying.value) {
      currentMusicDuration.value = await _audioPlayerService.getCurrentPosition;
    }
  }

  void playSelectedMusic(BuildContext context, int musicIndex) async {
    currentMusicIndexPlaying.value = musicIndex;
    await loadMusic();
    // ignore: use_build_context_synchronously
    showMusicPlayer(context);
  }

  Future<void> showMusicPlayer(BuildContext context) async {
    loadCurrentMusicDuration();
    showBottomSheet(
        context: context,
        builder: (context) => Obx(
              () => MusicPlayerWidget(
                  music: _playlistPlaying[getCurrentMusicIndexPlaying ?? 0]),
            ),
        constraints: BoxConstraints(
          maxHeight: context.getHeight - context.getPaddingTop,
        ),
        backgroundColor: Colors.transparent,
        enableDrag: true,
        );
  }
}
