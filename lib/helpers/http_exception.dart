class HttpExceptions implements Exception {
  final String message;
  var data;
  HttpExceptions(this.message, {this.data});

  @override
  String toString() {
    return message;
  }
}
