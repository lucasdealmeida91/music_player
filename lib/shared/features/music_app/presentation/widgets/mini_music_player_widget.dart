import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/music_player_controls/play_pause_button_widget.dart';
import 'package:music_app/shared/widgets/image_widget.dart';
import 'package:music_app/shared/widgets/text_widget.dart';

class MiniMusicPlayerWidget extends StatelessWidget {
  const MiniMusicPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musicPlayerController = Get.find<MusicPlayerController>();
    return GestureDetector(
      onTap: () => musicPlayerController.showMusicPlayer(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MusicAppColors.primaryColor,
              MusicAppColors.tertiaryColor.withOpacity(0.5),
            ],
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 8,
              ),
              child: Obx(() { 
                      return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      ImageWidget(
                                        widht: 50,
                                        height: 50,
                                        img:
                                            musicPlayerController.getCurrentPlayingMusic?.img,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: TextWidget.normal(
                                          musicPlayerController
                                                  .getCurrentPlayingMusic?.title ??
                                              'Musica',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                PlayPauseButtonWidget(
                                  musicUrl: musicPlayerController.getCurrentPlayingMusic?.url,
                                  playPauseButtonSize: PlayPauseButtonSize.small,
                                ),
                              ],
                            );
                  }
                )
            ),
            StreamBuilder(
              stream: musicPlayerController.getCurrentPositionStream,
              builder: (context, AsyncSnapshot<Duration> snapshot) {
                final currentPositionInSeconds = snapshot.data?.inSeconds ??
                    musicPlayerController.currentMusicDuration.value;

                return LinearProgressIndicator(
                  value: (currentPositionInSeconds /
                          (musicPlayerController
                                  .getCurrentPlayingMusic?.duration ??
                              0))
                      .clamp(0, 1),
                  backgroundColor: Colors.grey.shade600,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MusicAppColors.secondColor),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
