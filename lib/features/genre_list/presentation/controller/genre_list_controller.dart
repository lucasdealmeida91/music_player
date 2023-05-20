import 'package:get/get.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/mixin/screen_loading_and_error_mixin.dart';
import 'package:music_app/features/genre_list/data/repository/genre_list_repository.dart';
import 'package:music_app/shared/model/genre_model.dart';

class GenreListController extends GetxController
    with ScreenLoadingAndErrorMixin {
  final GenreListRepository _genreListRepository;
  GenreListController(
    GenreListRepository genreListRepository,
  ) : _genreListRepository = genreListRepository;

  final RxList<GenreModel> genres = <GenreModel>[].obs;
  @override
  void onInit() {
    getGenreList();
    super.onInit();
  }

  Future<void> getGenreList() async {
    setLoadingToTrue();
    setError(null);
    final getGenreResponse = await _genreListRepository.getGenreList();
    getGenreResponse.fold((Failures failureResponse) {
      if (failureResponse is GetGenreListFailure) {
        setError(failureResponse.message);
      }
    }, (List<GenreModel> genreResponse) {
      genres.value = genreResponse;
    });
    setLoadingToFalse();
  }
}
