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
      width: isLastFrame ? 75 : 50,
      child: Column(
        children: [
          // Column for Rolls
          Row(children: [
            Container(
                width: 25,
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(color: Colors.blueAccent),
                  top: BorderSide(color: Colors.blueAccent),
                )),
                padding: const EdgeInsets.all(3.0),
                child: Text(
                    rollScore1 == 10 ? "X" : rollScore1?.toString() ?? '')),
            Container(
                width: 25,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                padding: const EdgeInsets.all(3.0),
                child: Text(
                    rollScore2 == 10 ? "X" : rollScore2?.toString() ?? '')),
            if (isLastFrame)
              Container(
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
                width: isLastFrame ? 75 : 50,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.blueAccent),
                        right: BorderSide(color: Colors.blueAccent),
                        bottom: BorderSide(color: Colors.blueAccent))),
                padding: const EdgeInsets.all(3.0),
                child: Text(totalScore?.toString() ?? '')),
          ]),
        ],
      ),
    );
  }
}
