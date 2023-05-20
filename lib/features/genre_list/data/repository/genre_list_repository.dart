import 'package:dartz/dartz.dart';
import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/services/api_services.dart';
import 'package:music_app/shared/model/genre_model.dart';

class GenreListRepository {
  final ApiServices _apiService;

  GenreListRepository({
    required ApiServices apiServices,
  }) : _apiService = apiServices;

  Future<Either<Failures, List<GenreModel>>> getGenreList() async {
    try {
      final genres = await _apiService.getGenres();
      return Right(genres);
    } on ApiExceptions catch (apiException) {
      return left(GetGenreListFailure(apiException.message));
    } on GenreException catch (generalException) {
      return Left(GetGenreListFailure(generalException.message));
    }
  }
}
