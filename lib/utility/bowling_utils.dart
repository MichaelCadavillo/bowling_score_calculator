import 'package:bowling_score_calculator/data/exceptions/invalid_roll_exception.dart';

class BowlingUtils {
  static bool isSpare(List<int> rolls, int rollIndex) {
    // if rolls does not have enough length to check if spare, return false
    if (rolls.length <= rollIndex + 1) return false;

    // If second roll from [rollIndex] is equal to 10, then it must be a spare.
    return (rolls[rollIndex] + rolls[rollIndex + 1]) == 10;
  }

  static bool isStrike(List<int> rolls, int rollIndex) {
    // if rolls does not have enough length to check if strike, return false
    if (rolls.length <= rollIndex) return false;

    // If the roll is equal to 10, then it must be a strike.
    return rolls[rollIndex] == 10;
  }

  static bool isGameValid(List<int> rolls, int rollScore) {
    // // Check if frame is valid
    // if (rolls.length > 21) {
    //   throw FrameOutOfRangeException(
    //       displayMessage:
    //           "The game has already been finished! Please start a new game.");
    // }

    // Check if score from roll is valid.
    if (rollScore < 0) {
      throw InvalidRollException(
          displayMessage: "Roll can't have negative value!");
    } else if (rollScore > 10) {
      throw InvalidRollException(
          displayMessage: "Score can't be more than 10 per Roll!");
    }

    return true;
  }
}
