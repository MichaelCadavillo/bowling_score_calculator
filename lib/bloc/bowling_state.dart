part of 'bowling_cubit.dart';

abstract class BowlingState extends Equatable {
  const BowlingState({this.score = 0});

  final int score;

  @override
  List<Object?> get props => [score];
}

class InitialBowlingState extends BowlingState {}

// Calculate score States
class CalculatingScoreState extends BowlingState {}

class ScoreCalculatedState extends BowlingState {
  final int calculatedScore;

  const ScoreCalculatedState({required this.calculatedScore});
}

class ErrorCalculatingScoreState extends BowlingState {
  final String errorMessage;

  const ErrorCalculatingScoreState({required this.errorMessage});
}
