import 'package:bowling_score_calculator/data/exceptions/invalid_roll_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bowling_state.dart';

class BowlingCubit extends Cubit<BowlingState> {
  BowlingCubit() : super(InitialBowlingState());

  final List<int> rolls = [];

  Future<void> rollBall(int rollScore) async {
    emit(CalculatingScoreState());
    try {
      // Check if score is valid before trying to calculate. Throws an error if score is invalid.
      validateRoll(rollScore);

      rolls.add(rollScore);

      int totalScore = _calculateScore();

      emit(ScoreCalculatedState(totalScore: totalScore));
    } on InvalidRollException catch (e, stk) {
      print("Error: $e, $stk");
      emit(ErrorCalculatingScoreState(errorMessage: e.toString()));
    } catch (e, stk) {
      print("Error: $e, $stk");
      emit(ErrorCalculatingScoreState(errorMessage: e.toString()));
    }
  }

  int _calculateScore() {
    int score = 0;
    int rollIndex = 0;

    for (int frame = 0; frame < 10; frame++) {
      if (_isStrike(rollIndex)) {
        if (rolls.length > rollIndex + 1 && rolls.length > rollIndex + 2) {
          score +=
              rolls[rollIndex] + rolls[rollIndex + 1] + rolls[rollIndex + 2];
          rollIndex++;
        }
      } else if (_isSpare(rollIndex)) {
        if (rolls.length > rollIndex + 1 && rolls.length > rollIndex + 2) {
          score +=
              rolls[rollIndex] + rolls[rollIndex + 1] + rolls[rollIndex + 2];
          rollIndex += 2;
        }
      } else {
        if (rolls.length > rollIndex + 1) {
          score += rolls[rollIndex] + rolls[rollIndex + 1];
          rollIndex += 2;
        }
      }
    }

    return score;
  }

  bool _isSpare(rollIndex) {
    // if rolls does not have enough length to check if spare, return false
    if (rolls.length <= rollIndex + 1) return false;

    return (rolls[rollIndex] + rolls[rollIndex + 1]) == 10;
  }

  bool _isStrike(rollIndex) {
    // if rolls does not have enough length to check if strike, return false
    if (rolls.length <= rollIndex) return false;
    return rolls[rollIndex] == 10;
  }

  void validateRoll(int rollScore) {
    if (rollScore < 0) {
      throw InvalidRollException(
          displayMessage: "Roll can't have negative value!");
    } else if (rollScore > 10) {
      throw InvalidRollException(
          displayMessage: "Roll value can't be more than 10!");
    }
    // else, roll is valid
  }
}
