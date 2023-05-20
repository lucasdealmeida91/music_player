// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/services/api_services.dart';
import 'package:music_app/shared/model/genre_detail_model.dart';

class GenreDetailsRepository {
  final ApiServices _apiServices;
  GenreDetailsRepository({
    required ApiServices apiServices,
  }) : _apiServices = apiServices;

  Future<Either<Failures, GenreDetailModel>> getGenreDetails(
      String genre) async {
    try {
      final genreDetails = await _apiServices.getGenresDetails(genre: genre);
      return Right(genreDetails);
    } on ApiExceptions catch (apiException) {
      return Left(GetGenreDetailsFailure(apiException.message));
    } on GenreException catch (generalException) {
      return Left(GetGenreDetailsFailure(generalException.message));
    }
  }
}
