class GameAlreadyFinishedException implements Exception {
  final String? displayMessage;

  GameAlreadyFinishedException({this.displayMessage});

  @override
  String toString() {
    return "GameAlreadyFinishedException: $displayMessage";
  }
}
