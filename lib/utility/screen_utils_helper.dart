import 'package:bowling_score_calculator/utility/screen_utils.dart';
import 'package:get_it/get_it.dart';

Function hp = GetIt.I.get<ScreenUtils>().hp;
Function wp = GetIt.I.get<ScreenUtils>().wp;
bool isTablet = GetIt.I.get<ScreenUtils>().isDeviceTablet();
