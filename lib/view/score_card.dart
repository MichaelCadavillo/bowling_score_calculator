import 'package:bowling_score_calculator/bloc/bowling_cubit.dart';
import 'package:bowling_score_calculator/utility/bowling_utils.dart';
import 'package:bowling_score_calculator/utility/list_util.dart';
import 'package:bowling_score_calculator/utility/screen_utils_helper.dart';
import 'package:bowling_score_calculator/view/widgets/frame_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCard extends StatefulWidget {
  const ScoreCard({Key? key}) : super(key: key);

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  List<int> rolls = [];
  int totalScore = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BowlingCubit, BowlingState>(builder: (context, state) {
      if (state is CalculatingScoreState) {
        // Show loading
      } else if (state is ScoreCalculatedState) {
        totalScore = state.totalScore;
        rolls.clear();
        rolls.addAll(BlocProvider.of<BowlingCubit>(context).rollsForUI);
      } else if (state is SuccessResetScoreState) {
        rolls.clear();
        totalScore = 0;
      }
      return Column(
        children: [
          SizedBox(
            width: wp(100),
            height: 100,
            child: ListView.builder(
                itemCount: 19,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  int totalScoreForFrame = 0;
                  if (ListUtil.isNotEmpty(BlocProvider.of<BowlingCubit>(context)
                          .scorePerFrame) &&
                      BlocProvider.of<BowlingCubit>(context)
                              .scorePerFrame
                              .length >
                          index ~/ 2) {
                    totalScoreForFrame = BlocProvider.of<BowlingCubit>(context)
                        .scorePerFrame[index ~/ 2];
                  }

                  // Check if last frame
                  if (index == 18) {
                    if (rolls.length > index) {
                      // Remove the placeholder (-1) for the last frame.
                      List<int> lastFrame = rolls.sublist(index);
                      rolls.removeRange(index, rolls.length);
                      lastFrame.removeWhere((roll) => roll == -1);
                      rolls.addAll(lastFrame);
                    }

                    return FrameView(
                      rollScore1: (rolls.length > index) ? rolls[index] : null,
                      rollScore2:
                          (rolls.length > index + 1) ? rolls[index + 1] : null,
                      rollScore3:
                          (rolls.length > index + 2) ? rolls[index + 2] : null,
                      isLastFrame: true,
                      totalScore: totalScore,
                    );
                  }

                  // Split rolls by frame
                  if (index % 2 == 0) {
                    return FrameView(
                      rollScore1: (rolls.length > index) ? rolls[index] : null,
                      rollScore2:
                          (rolls.length > index + 1) ? rolls[index + 1] : null,
                      totalScore: totalScoreForFrame,
                    );
                  }

                  return Container();
                }),
          ),
          SizedBox(height: hp(5)),
          const Text("Total Score:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
          Text(
            "$totalScore",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: hp(10),
          )
        ],
      );
    });
  }
}
