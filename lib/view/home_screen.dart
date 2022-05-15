import 'package:bowling_score_calculator/bloc/bowling_cubit.dart';
import 'package:bowling_score_calculator/utility/screen_utils.dart';
import 'package:bowling_score_calculator/utility/screen_utils_helper.dart';
import 'package:bowling_score_calculator/view/score_buttons_view.dart';
import 'package:bowling_score_calculator/view/score_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    // Initialize ScreenUtils MediaQuery data
    if (!GetIt.I.isRegistered<ScreenUtils>()) {
      initMediaQuery(mediaQueryData: MediaQuery.of(context));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BowlingCubit>(
      create: (BuildContext context) => BowlingCubit(),
      child: Column(
        children: [
          const ScoreCard(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: const ScoreButtonsView()),
          SizedBox(height: hp(15))
        ],
      ),
    );
  }
}

void initMediaQuery({required MediaQueryData mediaQueryData}) {
  // Initializes ScreenUtils MediaQuery data to be used for responsiveness throughout the app
  ScreenUtils screenUtils = ScreenUtils(mediaQueryData);
  GetIt.I.registerFactory<ScreenUtils>(() => screenUtils);
}