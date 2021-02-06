class HttpException implements Exception {
  final String message;
  // ignore: sort_constructors_first
  HttpException(this.message);
  @override
  String toString() {
    return message;
  }
}
