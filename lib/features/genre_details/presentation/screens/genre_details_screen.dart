import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_details/presentation/widgets/genre_details_app_bar_widget.dart';
import 'package:music_app/features/genre_details/presentation/widgets/genre_details_music_list_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/mini_music_player_widget.dart';
import 'package:music_app/shared/model/genre_model.dart';

class GenreDetailsScreen extends StatelessWidget {
  static const routeName = '/genre-detail';
  const GenreDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musicPlayerController = Get.find<MusicPlayerController>();
    final genre = Get.arguments as GenreModel;
    return Scaffold(
      backgroundColor: MusicAppColors.primaryColor,
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  GenreDetailsAppBarWidget(genre: genre),
                  GenreDetailsMusicListWidget(
                    genreSearchString: genre.searchString,
                  ),
                ],
              ),
            ),
            if (musicPlayerController.getPlaylistPlaying.isNotEmpty)
              const MiniMusicPlayerWidget()
          ],
        );
      }),
    );
  }
}
