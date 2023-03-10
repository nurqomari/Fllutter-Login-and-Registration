import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text.dart';

enum BackButtonStyle { withBackground, withoutBackground }

class CustomAppBar extends StatelessWidget {
  String label;
  var onPressed;
  BackButtonStyle backButtonStyle;
  bool invertColor;
  double marginLeft, marginTop;

  CustomAppBar(this.label, this.onPressed,
      {this.backButtonStyle = BackButtonStyle.withoutBackground,
      this.invertColor = false,
      this.marginLeft = 1,
      this.marginTop = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: marginTop ?? Dimens.spaceL, left: marginLeft ?? 0.06.sw),
            child: Ink(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onPressed,
                child: BackIcon(backButtonStyle, invertColor),
              ),
            ),
          ),
          SizedBox(
            height: label != null ? Dimens.appBarVerticalSpace : 0,
          ),
          Container(
            margin: EdgeInsets.only(
                top: Dimens.spaceXs, left: marginLeft ?? 0.06.sw),
            child: CustomText(
              text: label,
              fontSize: Dimens.font20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BackIcon extends StatelessWidget {
  final BackButtonStyle backButtonStyle;
  final bool invertColor;

  BackIcon(this.backButtonStyle, this.invertColor);

  @override
  Widget build(BuildContext context) {
    if (backButtonStyle == BackButtonStyle.withBackground) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            color: invertColor ? Color(0xff151515) : Color(0xffeaeaea)),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 9, right: 11),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: FaIcon(
            FontAwesomeIcons.play,
            size: 14,
            color: invertColor ? Colors.white : Colors.black,
          ),
        ),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: FaIcon(
          FontAwesomeIcons.play,
          size: 14,
          color: invertColor ? Colors.white : Colors.black,
        ),
      );
    }
    /*return Icon(
      Icons.arrow_back,
      color: invertColor ? Colors.white : Colors.black,
    );*/
  }
}
