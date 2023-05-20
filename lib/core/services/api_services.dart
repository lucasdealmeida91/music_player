import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/shared/model/genre_detail_model.dart';
import 'package:music_app/shared/model/genre_model.dart';

class ApiServices extends DioForNative {
  ApiServices([super.baseOptions]);
  Future<List<GenreModel>> getGenres() async {
    try {
      const endPoint = '/genres';
      final response = await get(endPoint);
      return response.data
          .map<GenreModel>((genre) => GenreModel.fromMap(genre))
          .toList();
    } on DioError catch (dioError, stackTrace) {
      log(
        'Erro ao fazer get dos generos musicais',
        error: dioError,
        stackTrace: stackTrace,
      );
      throw ApiExceptions(
        message: '',
        statusCode: dioError.response?.statusCode,
      );
    } catch (error, stackTrace) {
      log(
        'Erro ao buscar generos musicais',
        error: error,
        stackTrace: stackTrace,
      );
      throw GenreException();
    }
  }

  Future<GenreDetailModel> getGenresDetails({required String genre}) async {
    try {
      final endPoint = '/genres/$genre';
      final response = await get(endPoint);
      return GenreDetailModel.fromMap(response.data);
    } on DioError catch (dioError, stackTrace) {
      log(
        'Erro ao fazer get dos detalhes do genero musical',
        error: dioError,
        stackTrace: stackTrace,
      );
      throw ApiExceptions(
        message: 'Erro ao fazer get dos detalhes do genero musical',
        statusCode: dioError.response?.statusCode,
      );
    } catch (error, stackTrace) {
      log(
        'Erro ao buscar detalhes do genero',
        error: error,
        stackTrace: stackTrace,
      );
      throw GenreException();
    }
  }
}
