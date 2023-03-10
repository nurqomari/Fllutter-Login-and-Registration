import 'package:flutter/material.dart';
import 'package:koffie_flutter_bdd/dimen.dart';

enum LocationSuffixAction { clear, getCurrentLocation }

class AppTheme {
  static const Color primary = Color(0xff000000);
  static const Color primaryLight = Color(0xff484848);
  static const Color primaryDark = Color(0xff000000);

  static const Color white = Colors.white;
  static const Color offWhite = Color(0xfff0f1f4);
  static const Color inactiveItem = Color(0xff747474);

  static const Color scaffoldBackground = Color.fromRGBO(234, 234, 234, 1);

  static const Color textOnPrimary = Color(0xffffffff);
  static const Color textOnSecondary = Color(0xff000000);
  static const Color textWhite = Colors.white;
  static const Color textBlack = primary;
  static const Color textGrey = Color(0xffc7c7c7);
  static const Color textDefault = Colors.black54;
  static const Color textBlueAccent = Color(0xff1884A3);
  static const Color textRed = Colors.redAccent;
  static const Color textGreen = Color(0xff2e7d32);
  static const Color textLightGreen = Color(0xff64FEAB);

  static const Color buttonBlueAccent = Colors.blueAccent;
  static const Color buttonBlue = Color(0xff1884A3);
  static const Color buttonLight = Colors.white70;
  static const Color buttonGrey = Color(0xffD1D0D0);

  static MaterialColor blackPrimarySwatch =
      MaterialColor(0xff212121, <int, Color>{
    50: Color(0xff909090),
    100: Color(0xff7a7a7a),
    200: Color(0xff646464),
    300: Color(0xff4d4d4d),
    400: Color(0xff373737),
    500: primary,
    600: Color(0xff1e1e1e),
    700: Color(0xff1a1a1a),
    800: Color(0xff171717),
    900: Color(0xff141414)
  });

  static Color secondary = Color(0xffffffff);

  static inputDecoration(hint) {
    return InputDecoration(
        labelText: hint,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: AppTheme.textDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: AppTheme.textDefault),
        ),
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(18.0),
          borderSide: BorderSide(color: AppTheme.textOnPrimary),
        ),
        labelStyle:
            TextStyle(fontStyle: FontStyle.normal, color: AppTheme.textDefault),
        hintStyle: TextStyle(
            fontStyle: FontStyle.normal, color: AppTheme.textDefault));
  }

  static addMediaContainerDecoration() {
    return BoxDecoration(
      color: AppTheme.white,
      border: Border.all(
        color: AppTheme.white,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }

  static boxDecorationNone() {
    return BoxDecoration(
        // color: AppTheme.white,
        // border: Border.all(
        //   color: AppTheme.white,
        // ),
        // borderRadius: BorderRadius.circular(12),
        );
  }

  static inputDecorationNone(hint, {icon, enabled}) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.0),
        border: InputBorder.none,
        hintText: hint ?? "",
        hintStyle: TextStyle(fontSize: Dimens.font11),
        icon: icon ?? null,
        enabled: enabled ?? true);
  }

  static inputDecorationRoundLocation(hint,
      {prefixIcon, suffixAction, suffixType}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(top: -2),
      hintText: hint,
      prefixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
      prefixIcon: Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: prefixIcon) ??
          null,
      suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
      suffixIcon: suffixAction != null && suffixType != null
          ? Padding(
              padding: EdgeInsets.only(left: 5, right: 10),
              child: GestureDetector(
                child: Icon(
                  suffixType == LocationSuffixAction.clear
                      ? Icons.clear
                      : Icons.gps_fixed,
                  size: 20,
                  color: Colors.grey,
                ),
                onTap: suffixAction,
              ))
          : null,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      labelStyle:
          TextStyle(fontStyle: FontStyle.normal, color: AppTheme.textDefault),
      hintStyle:
          TextStyle(fontStyle: FontStyle.normal, color: AppTheme.textDefault),
    );
  }

  static inputDecorationRound(hint, isDense,
      {contentPadding, prefixIcon, suffixAction}) {
    return InputDecoration(
      contentPadding:
          contentPadding ?? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: hint,
      isDense: isDense,
      prefixIcon: prefixIcon ?? null,
      suffixIcon: suffixAction != null
          ? IconButton(
              icon: Icon(
                Icons.clear,
              ),
              onPressed: suffixAction,
              padding: EdgeInsets.zero,
              iconSize: 24,
              color: Colors.grey,
              highlightColor: Colors.grey,
            )
          : null,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      labelStyle:
          TextStyle(fontStyle: FontStyle.normal, color: AppTheme.textDefault),
      hintStyle:
          TextStyle(fontStyle: FontStyle.normal, color: AppTheme.textDefault),
    );
  }

  static roundedCornerDecoration() {
    return BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(32)));
  }

  static RoundedRectangleBorder roundedCornerShape({double radius = 16}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );
  }

  static getLuminance(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
