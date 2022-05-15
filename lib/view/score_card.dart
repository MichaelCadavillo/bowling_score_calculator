import 'package:bowling_score_calculator/bloc/bowling_cubit.dart';
import 'package:bowling_score_calculator/utility/bowling_utils.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BowlingCubit, BowlingState>(builder: (context, state) {
      List<int> rolls = [];
      int totalScore = 0;
      if (state is CalculatingScoreState) {
        // Show loading
      } else if (state is ScoreCalculatedState) {
        totalScore = state.totalScore;
        rolls.addAll(BlocProvider.of<BowlingCubit>(context).rolls);
      }
      print("ROLLS: ${rolls}");
      return Column(
        children: [
          SizedBox(
            width: wp(100),
            height: hp(10),
            child: ListView.builder(
                itemCount: 19,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // Check if last index
                  if (index == 18) {
                    return FrameView(
                      rollScore1: (rolls.length > index) ? rolls[index] : null,
                      rollScore2:
                          (rolls.length > index + 1) ? rolls[index + 1] : null,
                      rollScore3:
                          (rolls.length > index + 2) ? rolls[index + 2] : null,
                      isLastFrame: true,
                      totalScore: 10,
                    );
                  }

                  // Split rolls by frame
                  if (index % 2 == 0) {
                    // If roll was a strike, skip 
                    if (BowlingUtils.isStrike(rolls, index)) {
                      return FrameView(
                        rollScore1: null,
                        rollScore2:
                            (rolls.length > index) ? rolls[index] : null,
                        totalScore: 10,
                      );
                    }

                    return FrameView(
                      rollScore1: (rolls.length > index) ? rolls[index] : null,
                      rollScore2:
                          (rolls.length > index + 1) ? rolls[index + 1] : null,
                      totalScore: 10,
                    );
                  }

                  return Container();
                }),
          ),
          Text("Total Score:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
          Text(
            "$totalScore",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: hp(10),
          )
        ],
      );
    });
  }
}
