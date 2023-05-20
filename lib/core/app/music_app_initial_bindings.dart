import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:music_app/core/services/api_services.dart';
import 'package:music_app/core/services/audio_player/audio_player_service_impl.dart';
import 'package:music_app/core/services/dot_env_service.dart';
import 'package:music_app/shared/features/music_app/presentation/controller/music_player_controller.dart';

class MusicAppInitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ApiServices(
        BaseOptions(
          baseUrl: DotEnvService.getApiBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ),
    );
    Get.put(
      AudioPlayerServiceImpl(
        AudioPlayer(),
      ),
    );
    Get.lazyPut(
      () => MusicPlayerController(
        audioPlayerService: AudioPlayerServiceImpl(
          AudioPlayer(),
        ),
      ),
    );
  }
}
