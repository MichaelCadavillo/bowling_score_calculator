import 'package:bloc_test/bloc_test.dart';
import 'package:bowling_score_calculator/bloc/bowling_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('Bowling Cubit', () {
    blocTest("emits nothing when BowlingCubit is initialized",
        build: () => BowlingCubit(), expect: () => []);

    blocTest("Test invalid roll (Negative roll score value)",
        build: () => BowlingCubit(),
        act: (bloc) => (bloc as BowlingCubit).rollBall(-1),
        expect: () => [
              CalculatingScoreState(),
              const ErrorCalculatingScoreState(
                  errorMessage:
                      "InvalidRollException: Roll can't have negative value!")
            ]);

    blocTest("Test invalid roll (Big roll score value)",
        build: () => BowlingCubit(),
        act: (bloc) => (bloc as BowlingCubit).rollBall(25),
        expect: () => [
              CalculatingScoreState(),
              const ErrorCalculatingScoreState(
                  errorMessage:
                      "InvalidRollException: Score can't be more than 10 per Roll!")
            ]);

    blocTest("Test Invalid roll (Invalid roll value)",
        build: () => BowlingCubit(),
        act: (bloc) {
          if (bloc is BowlingCubit) {
            bloc.rollBall(7);

            bloc.fetchApplicableButtons();

            // Try rolling 7 pins again (Should throw an exception as there are only 3 pins left)
            bloc.rollBall(7);
          }
        },
        expect: () => [
              CalculatingScoreState(),
              const ScoreCalculatedState(),
              UpdatingApplicableRollsState(),
              const UpdatedApplicableRollsState(rollValues: [0, 1, 2, 3]),
              CalculatingScoreState(),
              const ErrorCalculatingScoreState(
                  errorMessage: "InvalidRollException: Roll is invalid!")
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

    blocTest("Test All Strike Game (Max possible score)",
        build: () => BowlingCubit(),
        act: (bloc) {
          if (bloc is BowlingCubit) {
            // Frame 1
            bloc.rollBall(10);

            // Frame 2
            bloc.rollBall(10);

            // Frame 3
            bloc.rollBall(10);

            // Frame 4
            bloc.rollBall(10);

            // Frame 5
            bloc.rollBall(10);

            // Frame 6
            bloc.rollBall(10);

            // Frame 7
            bloc.rollBall(10);

            // Frame 8
            bloc.rollBall(10);

            // Frame 9
            bloc.rollBall(10);

            // Frame 10
            bloc.rollBall(10);
            bloc.rollBall(10);
            bloc.rollBall(10);
          }
        },
        expect: () => [
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 0),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 0),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 30),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 60),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 90),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 120),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 150),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 180),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 210),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 240),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 270),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 300),
            ]);

    blocTest("Test try rollBall even if game is already finished",
        build: () => BowlingCubit(),
        act: (bloc) {
          if (bloc is BowlingCubit) {
            // Frame 1
            bloc.rollBall(10);

            // Frame 2
            bloc.rollBall(10);

            // Frame 3
            bloc.rollBall(10);

            // Frame 4
            bloc.rollBall(10);

            // Frame 5
            bloc.rollBall(10);

            // Frame 6
            bloc.rollBall(10);

            // Frame 7
            bloc.rollBall(10);

            // Frame 8
            bloc.rollBall(10);

            // Frame 9
            bloc.rollBall(10);

            // Frame 10
            bloc.rollBall(10);
            bloc.rollBall(10);
            bloc.rollBall(10);

            // Additional roll, should throw an exception
            bloc.rollBall(10);
          }
        },
        expect: () => [
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 0),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 0),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 30),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 60),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 90),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 120),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 150),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 180),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 210),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 240),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 270),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 300),
              CalculatingScoreState(),
              const ErrorCalculatingScoreState(
                  errorMessage:
                      "GameAlreadyFinishedException: The game has already been finished! Please start a new game.")
            ]);

    blocTest("Test Reset Game",
        build: () => BowlingCubit(),
        act: (bloc) {
          if (bloc is BowlingCubit) {
            bloc.rollBall(5);
            bloc.rollBall(2);
            bloc.rollBall(3);
            bloc.rollBall(3);
            bloc.rollBall(10);

            bloc.resetGame();
          }
        },
        expect: () => [
              CalculatingScoreState(),
              const ScoreCalculatedState(),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 7),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 7),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 13),
              CalculatingScoreState(),
              const ScoreCalculatedState(totalScore: 13),
              ResettingScoreState(),
              SuccessResetScoreState(),
            ]);
  });
}
