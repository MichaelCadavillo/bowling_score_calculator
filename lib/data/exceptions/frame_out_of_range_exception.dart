class FrameOutOfRangeException implements Exception {
  final String? displayMessage;

  FrameOutOfRangeException({this.displayMessage});

  @override
  String toString() {
    return "FrameOutOfRangeException: $displayMessage";
  }
}
