import 'package:bloc_test/bloc_test.dart';
import 'package:bowling_score_calculator/bloc/bowling_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('Bowling Cubit', () {
    blocTest("emits nothing when BowlingCubit is initialized",
        build: () => BowlingCubit(), expect: () => []);

    blocTest("Test invalid roll (Negative roll value)",
        build: () => BowlingCubit(),
        act: (bloc) => (bloc as BowlingCubit).rollBall(-1),
        expect: () => [
              CalculatingScoreState(),
              const ErrorCalculatingScoreState(
                  errorMessage:
                      "InvalidRollException: Roll can't have negative value!")
            ]);

    blocTest("Test invalid roll (Big roll value)",
        build: () => BowlingCubit(),
        act: (bloc) => (bloc as BowlingCubit).rollBall(25),
        expect: () => [
              CalculatingScoreState(),
              const ErrorCalculatingScoreState(
                  errorMessage:
                      "InvalidRollException: Roll value can't be more than 10!")
            ]);

    blocTest("Test Strike calculation (Turkey scenario)",
        build: () => BowlingCubit(),
        act: (bloc) {
          if (bloc is BowlingCubit) {
            bloc.rollBall(10);
            bloc.rollBall(10);
            bloc.rollBall(10);
          }
        },
        expect: () => [
              CalculatingScoreState(),
              const ScoreCalculatedState(),
              CalculatingScoreState(),
              const ScoreCalculatedState(),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 30)
            ]);

    blocTest("Test Spare calculation",
        build: () => BowlingCubit(),
        act: (bloc) {
          if (bloc is BowlingCubit) {
            bloc.rollBall(5);
            bloc.rollBall(5);
            bloc.rollBall(3);
          }
        },
        expect: () => [
              CalculatingScoreState(),
              const ScoreCalculatedState(),
              CalculatingScoreState(),
              const ScoreCalculatedState(),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 13)
            ]);

    blocTest("Test Standard frame calculation",
        build: () => BowlingCubit(),
        act: (bloc) {
          if (bloc is BowlingCubit) {
            bloc.rollBall(5);
            bloc.rollBall(3);
          }
        },
        expect: () => [
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 0),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 8),
            ]);
  });
}
