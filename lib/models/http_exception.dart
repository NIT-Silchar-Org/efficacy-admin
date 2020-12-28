class HttpException implements Exception {
  HttpException(this.message);

  String message;

  @override
  String toString() {
    return message;
    // return super.toString();//this will return "Instance of HttpException".
  }
}
