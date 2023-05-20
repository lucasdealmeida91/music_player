abstract class Failures {}

class GetGenreListFailure extends Failures {
  final String message;
  GetGenreListFailure(this.message);
}

class GetGenreDetailsFailure extends Failures {
  final String message;
  GetGenreDetailsFailure(this.message);
}
