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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          runSpacing: 5,
          children: [
            ScoreButton(
              label: '1',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(1);
              },
            ),
            ScoreButton(
              label: '2',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(2);
              },
            ),
            ScoreButton(
              label: '3',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(3);
              },
            ),
            ScoreButton(
              label: '4',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(4);
              },
            ),
            ScoreButton(
              label: '5',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(5);
              },
            ),
            ScoreButton(
              label: '6',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(6);
              },
            ),
            ScoreButton(
              label: '7',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(7);
              },
            ),
            ScoreButton(
              label: '8',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(8);
              },
            ),
            ScoreButton(
              label: '9',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(9);
              },
            ),
            ScoreButton(
              label: 'X',
              onTap: () {
                BlocProvider.of<BowlingCubit>(context).rollBall(10);
              },
            )
          ],
        ),
        SizedBox(height: hp(10)),
        ElevatedButton(
          onPressed: () => BlocProvider.of<BowlingCubit>(context).resetGame(),
          child: Text("Reset Game"),
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
  }
}
