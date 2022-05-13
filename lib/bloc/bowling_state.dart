part of 'bowling_cubit.dart';

abstract class BowlingState extends Equatable {
  const BowlingState();

  @override
  List<Object?> get props => [];
}

class InitialBowlingState extends BowlingState {}

// Calculate score States
class CalculatingScoreState extends BowlingState {}

class ScoreCalculatedState extends BowlingState {
  final int totalScore;
  const ScoreCalculatedState({this.totalScore = 0});

  @override
  List<Object?> get props => [totalScore];
}

class ErrorCalculatingScoreState extends BowlingState {
  final String errorMessage;

  const ErrorCalculatingScoreState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
