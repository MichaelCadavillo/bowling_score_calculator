import 'package:bowling_score_calculator/data/exceptions/frame_out_of_range_exception.dart';
import 'package:bowling_score_calculator/data/exceptions/invalid_roll_exception.dart';
import 'package:bowling_score_calculator/utility/bowling_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bowling_state.dart';

class BowlingCubit extends Cubit<BowlingState> {
  BowlingCubit() : super(InitialBowlingState());

  final List<int> rolls = [];
  final List<int> rollsForUI = [];

  Future<void> rollBall(int rollScore) async {
    emit(CalculatingScoreState());
    try {
      // Check if the game is valid before trying to calculate. Throws an exception if game is invalid.
      if (BowlingUtils.isGameValid(rolls, rollScore)) {
        rolls.add(rollScore);
        rollsForUI.clear();
        rollsForUI.addAll(_getRollsForUI(rolls));

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

  /// Used to reset the game
  Future<void> resetGame() async {
    emit(ResettingScoreState());
    rolls.clear();
    rollsForUI.clear();
    emit(SuccessResetScoreState());
  }

  /// Main logic for calculating the score of the game
  int _calculateScore() {
    int score = 0;
    int rollIndex = 0;

    for (int frame = 0; frame < 10; frame++) {
      if (BowlingUtils.isStrike(rolls, rollIndex)) {
        // Checks if the next two rolls already exists to calculate score.
        if (rolls.length > rollIndex + 1 && rolls.length > rollIndex + 2) {
          score +=
              rolls[rollIndex] + rolls[rollIndex + 1] + rolls[rollIndex + 2];
          rollIndex++;
        }
      } else if (BowlingUtils.isSpare(rolls, rollIndex)) {
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

  /// Returns the List of rolls with blank spaces (-1) before Strike rolls in preparation for showing to the UI
  List<int> _getRollsForUI(List<int> rolls) {
    List<int> updatedRolls = [...rolls];
    int numOfStrikes = rolls.where((rolls) => rolls == 10).length;
    int prevIndex = 0;

    // Add -1 identifier if the roll was a strike.
    for (int i = 0; i < numOfStrikes; i++) {
      if (updatedRolls.indexOf(10, prevIndex) == 0 ||
          updatedRolls.indexOf(10, prevIndex) - 1 >= 0 &&
              updatedRolls[updatedRolls.indexOf(10, prevIndex) - 1] != -1) {
        updatedRolls.insert(updatedRolls.indexOf(10, prevIndex), -1);
      }
      prevIndex = updatedRolls.indexOf(10, prevIndex) + 1;
    }

    return updatedRolls;
  }
}
