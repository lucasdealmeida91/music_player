import 'package:get/get.dart';
import 'package:music_app/core/services/api_services.dart';
import 'package:music_app/features/genre_list/data/repository/genre_list_repository.dart';
import 'package:music_app/features/genre_list/presentation/controller/genre_list_controller.dart';

class GenreListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GenreListController(
        GenreListRepository(apiServices: Get.find<ApiServices>())));
  }
}
