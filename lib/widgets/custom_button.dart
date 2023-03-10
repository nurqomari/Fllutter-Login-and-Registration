import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text.dart';

class CustomButton {
  static buttonRatio() {
    return 7 / 2;
  }

  static buttonRatioWide() {
    return 11 / 3;
  }

  static buttonWidth(context) {
    return MediaQuery.of(context).size.width * 0.36;
  }

  static buttonWidthWide(context) {
    return MediaQuery.of(context).size.width * 0.39;
  }

  static Widget getCustomButton(
      {@required context,
      buttonText,
      width,
      height,
      @required color,
      @required textColor,
      @required callbackFunction}) {
    return Container(
      width: buttonWidthWide(context),
      child: AspectRatio(
        aspectRatio: buttonRatioWide(),
        child: ElevatedButton(
            child: Text(
              buttonText ?? "Button",
              style: TextStyle(
                color: textColor,
              ),
            ),
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: () {
              callbackFunction();
            }),
      ),
    );
  }

  static Widget getCustomButtonWithIcon(
      {@required context,
      buttonText,
      width,
      height,
      @required color,
      @required textColor,
      @required callbackFunction,
      @required icon}) {
    return Container(
      width: width ?? buttonWidthWide(context),
      child: AspectRatio(
        aspectRatio: buttonRatioWide(),
        child: ElevatedButton.icon(
            icon: icon,
            label: Text(
              buttonText ?? "Button",
              style: TextStyle(
                color: textColor,
              ),
            ),
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: () {
              callbackFunction();
            }),
      ),
    );
  }

  static Widget getCustomIconButton(
      {@required context,
      @required icon,
      @required callbackFunction,
      margin,
      padding}) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      child: IconButton(
        icon: icon,
        onPressed: callbackFunction,
      ),
    );
  }

  static getSupportedAppIconButton(
      {@required backgroundColor, @required icon}) {
    return Container(
      height: 28,
      width: 28,
      decoration:
          ShapeDecoration(color: backgroundColor, shape: CircleBorder()),
      child: IconButton(iconSize: 12, icon: icon, onPressed: null),
    );
  }

  static getCustomMaterialButton(
      {@required context,
      @required buttonText,
      @required textColor,
      @required callbackFunction,
      buttonColor,
      buttonWidth}) {
    return Container(
      width: buttonWidth ?? Dimens.screenWidth(context, spaceMultiplier: 0.6),
      child: MaterialButton(
        onPressed: callbackFunction,
        color: buttonColor ?? AppTheme.primary,
        child: SizedBox(
            width: Dimens.screenWidth(context, spaceMultiplier: 0.6),
            child: CustomText(
              text: buttonText,
              textColor: textColor,
              fontSize: Dimens.font14,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            )
            /*CustomText.getCustomText(buttonText, textColor, Dimens.fontM,
              fontWeight: FontWeight.w500, textAlign: TextAlign.center),*/
            ),
        height: Dimens.screenHeight(context, spaceMultiplier: 0.08),
        minWidth:
            buttonWidth ?? Dimens.screenWidth(context, spaceMultiplier: 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}

class CustomMaterialButton extends StatelessWidget {
  double buttonWidth, buttonHeight, captionSize, radius, elevation;
  Color buttonColor, captionColor;
  String caption;
  var callbackFunction;

  CustomMaterialButton(
      {required this.callbackFunction,
      required this.caption,
      this.captionColor = Colors.white,
      this.captionSize = 10,
      this.buttonColor = Colors.white,
      this.buttonWidth = 10,
      this.buttonHeight = 10,
      this.radius = 1,
      this.elevation = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth ?? 0.6.sw,
      child: MaterialButton(
        elevation: elevation,
        onPressed: callbackFunction,
        color: buttonColor ?? AppTheme.primary,
        child: SizedBox(
          width: 0.6 * SizeConfig.screenWidth!,
          child: CustomText(
            text: caption,
            textColor: captionColor ?? AppTheme.textWhite,
            fontSize: captionSize ?? Dimens.font14,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
        ),
        height: buttonHeight ?? Dimens.buttonHeightNormal,
        minWidth: buttonWidth ?? Dimens.buttonWidthNormal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 10),
          ),
        ),
      ),
    );
  }
}

class CustomMaterialIconButton extends StatelessWidget {
  Widget icon;
  double buttonWidth, buttonHeight, spaceBetweenIconAndText, radius;
  Color buttonColor, captionColor;
  String caption;
  Alignment contentAlignment;
  EdgeInsets contentPadding;
  var callbackFunction;

  CustomMaterialIconButton(
      {required this.callbackFunction,
      required this.caption,
      required this.icon,
      this.captionColor = Colors.white,
      this.buttonColor = Colors.white,
      this.buttonWidth = 10,
      this.buttonHeight = 10,
      this.spaceBetweenIconAndText = 5,
      this.contentAlignment = Alignment.center,
      this.radius = 10,
      this.contentPadding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth ?? 0.6.sw,
      child: MaterialButton(
        onPressed: callbackFunction,
        color: buttonColor ?? AppTheme.primary,
        padding: EdgeInsets.zero,
        child: Container(
          padding: contentPadding ?? EdgeInsets.only(left: 16, right: 16),
          alignment: contentAlignment ?? Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              Spacer(),
              CustomText(
                text: caption,
                textColor: captionColor ?? AppTheme.textWhite,
                fontSize: Dimens.font14,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                margin: EdgeInsets.only(left: spaceBetweenIconAndText),
              ),
              Spacer(),
            ],
          ),
        ),
        height: buttonHeight ?? Dimens.buttonHeightNormal,
        minWidth: buttonWidth ?? Dimens.buttonWidthNormal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
      ),
    );
  }
}

class CustomLinearBackButton extends StatelessWidget {
  final Color primaryColor;
  final double marginTop, marginLeft;
  final action;

  CustomLinearBackButton(
      {this.primaryColor = AppTheme.textBlack,
      this.marginTop = 1,
      this.marginLeft = 1,
      this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: marginTop! ?? SizeConfig.safeBlockVertical! * 6,
          left: marginLeft! ?? SizeConfig.safeBlockHorizontal! * 6),
      child: Ink(
        child: InkWell(
          onTap: action != null
              ? action
              : () {
                  Navigator.pop(context);
                },
          child: Container(
            child: Row(
              children: [
                CustomBackButton(
                  useBackground: false,
                  primaryColor: primaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "Back",
                  textColor: primaryColor ?? AppTheme.textBlack,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  bool useBackground;
  Color primaryColor;

  CustomBackButton(
      {this.useBackground = true, this.primaryColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return useBackground
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                color: Color.fromRGBO(234, 234, 234, 0.9)),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 9, right: 11),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: FaIcon(
                FontAwesomeIcons.play,
                size: 14,
                color: Colors.black,
              ),
            ),
          )
        : Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: FaIcon(
              FontAwesomeIcons.play,
              size: 14,
              color: useBackground
                  ? Colors.black
                  : primaryColor != null
                      ? primaryColor
                      : Colors.white,
            ),
          );
  }
}
