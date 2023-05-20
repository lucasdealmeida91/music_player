// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';

enum PlayPauseButtonSize { small, normal }

class PlayPauseButtonWidget extends StatelessWidget {
  final String? musicUrl;
  final PlayPauseButtonSize _playPauseButtonSize;
  const PlayPauseButtonWidget({
    super.key,
    this.musicUrl,
    PlayPauseButtonSize? playPauseButtonSize,
  }) : _playPauseButtonSize = playPauseButtonSize ?? PlayPauseButtonSize.normal;

  @override
  Widget build(BuildContext context) {
    final musicPlayerController = Get.find<MusicPlayerController>();
    return Obx(
      () {
        return IconButton(
          iconSize:
              _playPauseButtonSize == PlayPauseButtonSize.normal ? 70 : 50,
          onPressed: () async {
            if (musicUrl != null) {
              if (musicPlayerController.isPlaying.value) {
                musicPlayerController.pauseMusic();
              } else {
                musicPlayerController.playMusic(musicUrl!);
              }
            }
          },
          icon: Icon(
            musicPlayerController.isPlaying.value
                ? Icons.pause_circle
                : Icons.play_circle,
                color: MusicAppColors.secondColor,
          ),
          padding: const EdgeInsets.all(0),
        );
      },
    );
  }
}
