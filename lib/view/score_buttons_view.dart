import 'package:bowling_score_calculator/bloc/bowling_cubit.dart';
import 'package:bowling_score_calculator/utility/screen_utils_helper.dart';
import 'package:bowling_score_calculator/view/widgets/score_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreButtonsView extends StatefulWidget {
  const ScoreButtonsView({Key? key}) : super(key: key);

  @override
  State<ScoreButtonsView> createState() => _ScoreButtonsViewState();
}

class _ScoreButtonsViewState extends State<ScoreButtonsView> {
  List<int> rollButtons = [];

  @override
  void initState() {
    BlocProvider.of<BowlingCubit>(context).fetchApplicableButtons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BowlingCubit, BowlingState>(builder: (context, state) {
      if (state is UpdatingApplicableRollsState) {
        // Show loading
      } else if (state is UpdatedApplicableRollsState) {
        rollButtons.clear();
        rollButtons.addAll(state.rollValues);
      } else if (state is ScoreCalculatedState) {
        BlocProvider.of<BowlingCubit>(context).fetchApplicableButtons();
      } else if (state is SuccessResetScoreState) {
        BlocProvider.of<BowlingCubit>(context).fetchApplicableButtons();
      }
      return Column(
        children: [
          Wrap(
              runSpacing: 5,
              children: List<Widget>.generate(
                rollButtons.length,
                (index) => ScoreButton(
                  label: rollButtons[index] == 10
                      ? 'X'
                      : rollButtons[index].toString(),
                  onTap: () {
                    BlocProvider.of<BowlingCubit>(context)
                        .rollBall(rollButtons[index]);
                  },
                ),
              )),
          SizedBox(height: hp(10)),
          ElevatedButton(
            onPressed: () => BlocProvider.of<BowlingCubit>(context).resetGame(),
            child: const Text("Reset Game"),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
