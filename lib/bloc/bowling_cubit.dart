import 'package:bowling_score_calculator/exceptions/invalid_roll_exception.dart';
import 'package:bowling_score_calculator/utility/string_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bowling_state.dart';

class BowlingCubit extends Cubit<BowlingState> {
  BowlingCubit() : super(InitialBowlingState());

  Future<void> calculateScore(int roll) async {
    emit(CalculatingScoreState());
    try {
      // Check if roll is valid before trying to calculate
      if (roll < 0) {
        throw InvalidRollException(
            displayMessage: "Roll can't have negative value!");
      } else if (roll > 10) {
        throw InvalidRollException(
            displayMessage: "Roll value can't be more than 10!");
      }

      
      emit(ScoreCalculatedState(calculatedScore: 0));
    } on InvalidRollException catch (e, stk) {
      print("Error: $e, $stk");
      emit(ErrorCalculatingScoreState(errorMessage: e.toString()));
    } catch (e, stk) {
      print("Error: $e, $stk");
      emit(ErrorCalculatingScoreState(errorMessage: e.toString()));
    }
  }
}
