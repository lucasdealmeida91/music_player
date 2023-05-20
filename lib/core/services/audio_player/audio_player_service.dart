abstract class AudioPlayerService {
Future<void>seek(int seconds);
Stream<Duration> getPositionStream();
Future<int>get getCurrentPosition;
Future<void> playMusic(String audioUrlAsset);
Future<void> pauseMusic();
Future<void> resumeMusic();
Future<void> stopMusic();
Stream<void> onAudioComplete();
}