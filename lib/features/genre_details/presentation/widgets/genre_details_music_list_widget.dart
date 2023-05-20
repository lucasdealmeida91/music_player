// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_details/presentation/controller/genre_detail_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/circular_progress_indicator_widget.dart';
import 'package:music_app/shared/model/music_model.dart';
import 'package:music_app/shared/widgets/app_music_error_widget.dart';
import 'package:music_app/shared/widgets/img_and_title_row_widget.dart';
import 'package:music_app/shared/widgets/text_widget.dart';

class GenreDetailsMusicListWidget extends StatelessWidget {
  final String genreSearchString;
  const GenreDetailsMusicListWidget({
    Key? key,
    required this.genreSearchString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genreDetailsController = Get.find<GenreDetailController>();
    final musicPlayerController = Get.find<MusicPlayerController>();
    return Obx(
      () {
        return SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(
                height: 8,
              ),
              if (genreDetailsController.getIsLoading)
                const CircularProgressIndicatorWidget(),
              if (!genreDetailsController.getIsLoading &&
                  genreDetailsController.getError != null)
                AppMusicErrorWidget(
                  error: genreDetailsController.getError!,
                  onTryAgain: () => genreDetailsController
                      .loadGenreDetails(genreSearchString),
                ),
              if (!genreDetailsController.getIsLoading &&
                  genreDetailsController.getError == null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget.title('Músicas'),
                      const SizedBox(
                        height: 12,
                      ),
                      ...genreDetailsController.genreDetails?.listMusic
                              .asMap()
                              .map((int index, MusicModel music) =>
                                  MapEntry(index, Builder(
                                    builder: (builderContext) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              musicPlayerController
                                                  .playSelectedMusic(
                                                      context, index);
                                            },
                                            child: ImgAndTitleRowWidget(
                                              title: music.title,
                                              heroTag: index.toString(),
                                              img: music.img,
                                              titleColor: _getMusicTitleColor(
                                                  music,
                                                  musicPlayerController
                                                      .getCurrentPlayingMusic),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      );
                                    },
                                  )))
                              .values
                              .toList() ??
                          []
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

Color _getMusicTitleColor(
    MusicModel currentMusicInList, MusicModel? currentPlayingMusic) {
  if (currentMusicInList.title == currentPlayingMusic?.title) {
    return MusicAppColors.tertiaryColor;
  } else {
    return MusicAppColors.secondColor;
  }
}
