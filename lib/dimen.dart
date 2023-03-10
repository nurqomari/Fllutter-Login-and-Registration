import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimens {
  /*space used for margin or padding*/
  static const double spaceXs = 8,
      spaceS = 16,
      spaceSM = 28,
      spaceM = 32,
      spaceL = 48,
      spaceXl = 64;
  static final double fontXs = 10,
      font8 = 8,
      font9 = 9,
      font11 = 11,
      fontS = 12,
      fontM = 14,
      font13 = 13,
      font15 = 15,
      fontMM = 16,
      font17 = 17,
      fontL = 20,
      fontXl = 24,
      font25 = 25,
      font10 = 10,
      font12 = 12,
      font14 = 14,
      font16 = 16,
      font18 = 18,
      font20 = 20,
      font24 = 24;

  static final double buttonHeightSlim = 0.05.sh, buttonHeightNormal = 0.06.sh;

  static final double buttonWidthNormal = 0.6.sw;

  static final double mQueryVerticalXs = 0.01,
      mQueryVerticalS = 0.03,
      mQueryVerticalM = 0.05,
      mQueryVerticalL = 0.08,
      mQueryVerticalXl = 0.1;

  static final double appBarVerticalSpace = 10;

  static screenHeight(context, {spaceMultiplier}) {
    return MediaQuery.of(context).size.height * (spaceMultiplier ?? 1.0);
  }

  static screenWidth(context, {spaceMultiplier}) {
    return MediaQuery.of(context).size.width * (spaceMultiplier ?? 1.0);
  }
}
