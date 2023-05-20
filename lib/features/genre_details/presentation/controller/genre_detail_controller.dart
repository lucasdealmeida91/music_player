// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:get/get.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/mixin/screen_loading_and_error_mixin.dart';
import 'package:music_app/features/genre_details/data/repositories/genre_details_repository.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';
import 'package:music_app/shared/model/genre_detail_model.dart';
import 'package:music_app/shared/model/genre_model.dart';
import 'package:music_app/shared/model/music_model.dart';

class GenreDetailController extends GetxController
    with ScreenLoadingAndErrorMixin {
  final GenreDetailsRepository _genreDetailsRepository;
  final MusicPlayerController _musicPlayerController;
  GenreDetailController({
    required GenreDetailsRepository genreDetailsRepository,
    required MusicPlayerController musicPlayerController,
  })  : _genreDetailsRepository = genreDetailsRepository,
        _musicPlayerController = musicPlayerController;

  GenreDetailModel? genreDetails;

  @override
  void onInit() {
    final genre = Get.arguments as GenreModel;
    loadGenreDetails(genre.searchString);
    super.onInit();
  }

  Future<void> loadGenreDetails(String genre) async {
    setLoadingToTrue();
    setError(null);
    final genreDetailsResponseEither =
        await _genreDetailsRepository.getGenreDetails(genre);

    genreDetailsResponseEither.fold((Failures failureResponse) {
      if (failureResponse is GetGenreDetailsFailure) {
        setError(failureResponse.message);
      }
    }, (GenreDetailModel genreDetailResponse) {
      genreDetails = genreDetailResponse;
      _musicPlayerController.loadPlaylist(genreDetailResponse.listMusic, _musicPlayerController.selectedPlaylist);
    });
    setLoadingToFalse();
  }

  MusicModel? getMusicByIndex(int index) => genreDetails?.listMusic[index];

  List<MusicModel>? get getMusic => genreDetails?.listMusic;
}
