import 'package:bowling_score_calculator/bloc/bowling_cubit.dart';
import 'package:bowling_score_calculator/view/widgets/frame_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCard extends StatefulWidget {
  const ScoreCard({Key? key}) : super(key: key);

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BowlingCubit, BowlingState>(builder: (context, state) {
      List<int> rolls = [];
      if (state is CalculatingScoreState) {
        // Show loading
      } else if (state is ScoreCalculatedState) {
        state.totalScore;
        rolls.addAll(BlocProvider.of<BowlingCubit>(context).rolls);
      }
      print("ROLLS: ${rolls}");
      return Row(
        children: List<Widget>.generate(
            10,
            (index) => FrameView(
                  rollScore1: (rolls.length > index) ? rolls[index] : null,
                  rollScore2:
                      (rolls.length > index + 1) ? rolls[index + 1] : null,
                  totalScore: 10,
                )),
      );
      // itemCount: 10,
      // itemBuilder: (context, index) {
      //   return FrameView(
      //     rollScore1: 1,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   );
      // });
      // return Row(children: [
      //   FrameView(
      //     rollScore1: 1,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 2,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 3,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 3,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 3,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 3,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 3,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 3,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 3,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      //   FrameView(
      //     rollScore1: 3,
      //     rollScore2: 9,
      //     totalScore: 10,
      //   ),
      // ]);
    });
  }
}
