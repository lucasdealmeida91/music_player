import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/features/genre_details/presentation/screens/genre_details_screen.dart';
import 'package:music_app/features/genre_list/presentation/controller/genre_list_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/mini_music_player_widget.dart';
import 'package:music_app/shared/widgets/img_and_title_row_widget.dart';
import 'package:music_app/shared/widgets/screen_widget.dart';

class GenreListScreen extends StatelessWidget {
  static const routeName = "/genre-list";
  const GenreListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genreListCtrl = Get.find<GenreListController>();
    final musicPlayerController = Get.find<MusicPlayerController>();

    return Obx(
      () => ScreenWidget(
        isLoading: genreListCtrl.getIsLoading,
        title: 'Lista de generos',
        error: genreListCtrl.getError,
        onTryAgain: () => genreListCtrl.getGenreList(),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final genre = genreListCtrl.genres[index];
                      return InkWell(
                        onTap: () => Get.toNamed(
                            '${GenreListScreen.routeName}${GenreDetailsScreen.routeName}',
                            arguments: genre),
                        child: ImgAndTitleRowWidget(
                          title: genre.title,
                          heroTag: genre.title,
                          img: genre.img,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 12,
                      );
                    },
                    itemCount: genreListCtrl.genres.length),
              ),
            ),
            if (musicPlayerController.getPlaylistPlaying.isNotEmpty)
              const MiniMusicPlayerWidget()
          ],
        ),
      ),
    );
  }
}
