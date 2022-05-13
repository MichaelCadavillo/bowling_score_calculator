class InvalidRollException implements Exception {
  final String? displayMessage;

  InvalidRollException({this.displayMessage});

  @override
  String toString() {
    return "InvalidRollException: $displayMessage";
  }
}
