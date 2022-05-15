import 'package:bowling_score_calculator/bloc/bowling_cubit.dart';
import 'package:bowling_score_calculator/view/score_buttons_view.dart';
import 'package:bowling_score_calculator/view/score_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Bowling Score Calculator"),
          ),
          body: BlocProvider<BowlingCubit>(
            create: (BuildContext context) => BowlingCubit(),
            child: Column(
              children: [
                const ScoreCard(),
                const Spacer(),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: const ScoreButtonsView()),
                const SizedBox(height: 100)
              ],
            ),
          )),
    );
  }
}
