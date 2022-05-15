import 'package:bowling_score_calculator/data/exceptions/frame_out_of_range_exception.dart';
import 'package:bowling_score_calculator/data/exceptions/invalid_roll_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bowling_state.dart';

class BowlingCubit extends Cubit<BowlingState> {
  BowlingCubit() : super(InitialBowlingState());

  final List<int> rolls = [];

  Future<void> rollBall(int rollScore) async {
    emit(CalculatingScoreState());
    try {
      // Check if the game is valid before trying to calculate. Throws an exception if game is invalid.
      if (isGameValid(rollScore, rolls)) {
        rolls.add(rollScore);

        int totalScore = _calculateScore();

        emit(ScoreCalculatedState(totalScore: totalScore));
      } else {
        throw Exception("Game is Invalid!");
      }
    } on InvalidRollException catch (e, stk) {
      debugPrint("InvalidRollException: $e, $stk");
      emit(ErrorCalculatingScoreState(errorMessage: e.toString()));
    } on FrameOutOfRangeException catch (e, stk) {
      debugPrint("FrameOutOfRangeException: $e, $stk");
      emit(ErrorCalculatingScoreState(errorMessage: e.toString()));
    } catch (e, stk) {
      debugPrint("Error: $e, $stk");
      emit(ErrorCalculatingScoreState(errorMessage: e.toString()));
    }
  }

  Future<void> resetGame() async {
    emit(ResettingScoreState());
    rolls.clear();
    emit(SuccessResetScoreState());
  }

  int _calculateScore() {
    int score = 0;
    int rollIndex = 0;

    for (int frame = 0; frame < 10; frame++) {
      if (_isStrike(rollIndex)) {
        // Checks if the next two rolls already exists to calculate score.
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

    // If second roll from [rollIndex] is equal to 10, then it must be a spare.
    return (rolls[rollIndex] + rolls[rollIndex + 1]) == 10;
  }

  bool _isStrike(rollIndex) {
    // if rolls does not have enough length to check if strike, return false
    if (rolls.length <= rollIndex) return false;

    // If the roll is equal to 10, then it must be a strike.
    return rolls[rollIndex] == 10;
  }

  bool isGameValid(int rollScore, List<int> rolls) {
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
