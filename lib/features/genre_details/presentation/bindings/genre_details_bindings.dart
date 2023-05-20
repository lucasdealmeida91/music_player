import 'package:get/get.dart';
import 'package:music_app/core/services/api_services.dart';
import 'package:music_app/features/genre_details/data/repositories/genre_details_repository.dart';
import 'package:music_app/features/genre_details/presentation/controller/genre_detail_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';

class GenreDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GenreDetailController(
        genreDetailsRepository:
            GenreDetailsRepository(apiServices: Get.find<ApiServices>()),
        musicPlayerController: Get.find<MusicPlayerController>(),
      ),
    );
  }
}
