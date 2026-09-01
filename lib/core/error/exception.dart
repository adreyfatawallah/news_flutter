class ServerException implements Exception {
  final String error;

  ServerException(this.error);

  @override
  String toString() {
    return 'ServerException: $error';
  }
}

class LocalException implements Exception {
  final String error;

  LocalException(this.error);

  @override
  String toString() {
    return 'LocalException: $error';
  }
}
