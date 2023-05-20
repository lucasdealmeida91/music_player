// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/music_player_controls/play_pause_button_widget.dart';

class MusicPlayerControlsWidget extends StatelessWidget {
  final String musicPath;
  MusicPlayerControlsWidget({
    Key? key,
    required this.musicPath,
  }) : super(key: key);
  final musicPlayerController = Get.find<MusicPlayerController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 70,
          onPressed: () => musicPlayerController.backTrack(),
          icon: Icon(
            Icons.skip_previous,
            color: MusicAppColors.secondColor,
          ),
          padding: const EdgeInsets.all(0),
        ),
        const SizedBox(
          width: 40,
        ),
        PlayPauseButtonWidget(
          playPauseButtonSize: PlayPauseButtonSize.normal,
          musicUrl: musicPath,
        ),
        const SizedBox(
          width: 40,
        ),
        IconButton(
          iconSize: 70,
          onPressed: () => musicPlayerController.skipTrack(),
          icon: Icon(
            Icons.skip_next,
            color: MusicAppColors.secondColor,
          ),
          padding: const EdgeInsets.all(0),
        )
      ],
    );
  }
}
