import 'package:bowling_score_calculator/utility/screen_utils_helper.dart';
import 'package:flutter/material.dart';

class FrameView extends StatelessWidget {
  const FrameView(
      {Key? key,
      this.rollScore1,
      this.rollScore2,
      this.rollScore3,
      this.totalScore,
      this.isLastFrame = false})
      : super(key: key);

  final int? rollScore1;
  final int? rollScore2;
  final int? rollScore3;
  final bool isLastFrame;
  final int? totalScore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: isLastFrame ? 75 : 50,
      child: Column(
        children: [
          // Column for Rolls
          Row(children: [
            // Roll 1
            Container(
                height: 25,
                width: 25,
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(color: Colors.blueAccent),
                  top: BorderSide(color: Colors.blueAccent),
                )),
                padding: const EdgeInsets.all(3.0),
                child: Text((() {
                  if (rollScore1 == -1) {
                    return '';
                  } else if (rollScore1 == 10) {
                    return 'X';
                  } else {
                    return rollScore1?.toString() ?? '';
                  }
                }()))),
            // Roll 2
            Container(
                height: 25,
                width: 25,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                padding: const EdgeInsets.all(3.0),
                child: Text((() {
                  if (rollScore2 == 10) {
                    return 'X';
                  } else if (rollScore1 != null &&
                      rollScore2 != null &&
                      rollScore1! + rollScore2! == 10) {
                    return '/';
                  } else {
                    return rollScore2?.toString() ?? '';
                  }
                }()))),

            if (isLastFrame)
              // Roll 3
              Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                      rollScore3 == 10 ? "X" : rollScore3?.toString() ?? '')),
          ]),
          // Row for Total Score
          Row(children: [
            Container(
                height: 25,
                width: isLastFrame ? 75 : 50,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.blueAccent),
                        right: BorderSide(color: Colors.blueAccent),
                        bottom: BorderSide(color: Colors.blueAccent))),
                padding: const EdgeInsets.all(3.0),
                child: Text(
                    (rollScore1 != null) ? totalScore?.toString() ?? '' : '')),
          ]),
        ],
      ),
    );
  }
}
