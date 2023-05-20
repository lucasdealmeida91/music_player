// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiExceptions implements Exception {
  final String message;
  final int? statusCode;
  ApiExceptions({
    required this.message,
    this.statusCode,
  });
}

class GenreException implements Exception {
  final String message;
  GenreException({
     this.message = 'Ocorreu um erro por favor tente novamente',
  });
}
class AudioPlayerException implements Exception {
  final String message;
  AudioPlayerException({
   required  this.message,
  });
}