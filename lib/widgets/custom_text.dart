import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/dimen.dart';

class CustomText extends StatelessWidget {
  EdgeInsetsGeometry margin;
  double width;
  String text;
  int maxLines;
  TextOverflow overflow;
  TextAlign textAlign;

  Color textColor;
  double fontSize;
  FontWeight fontWeight;

  static getCustomText(text, textColor, textSize,
      {fontWeight, margin, textAlign, maxLines, width, overflow}) {
    if (text.isEmpty) {
      return Container();
    } else {
      return Container(
        margin: margin ?? EdgeInsets.zero,
        width: width ?? null,
        child: AutoSizeText(
          text,
          maxLines: maxLines,
          overflow: overflow ?? TextOverflow.visible,
          textAlign: textAlign ?? TextAlign.start,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
        ),
      );
    }
  }

  CustomText(
      {required this.text,
      this.margin = EdgeInsets.zero,
      this.width = 0,
      this.maxLines = 1,
      this.overflow = TextOverflow.visible,
      this.textAlign = TextAlign.start,
      this.textColor = Colors.white,
      this.fontSize = 10,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      width: width ?? null,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.visible,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
          color: textColor ?? AppTheme.textBlack,
          fontSize: fontSize ?? Dimens.font12,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }
}

class CustomAutoSizeText extends StatelessWidget {
  EdgeInsetsGeometry margin;
  double width;
  String text;
  int maxLines;
  TextOverflow overflow;
  TextAlign textAlign;

  Color textColor;
  double textSize;
  FontWeight fontWeight;

  CustomAutoSizeText(
      {required this.text,
      this.margin = EdgeInsets.zero,
      this.width = 0,
      this.maxLines = 1,
      this.overflow = TextOverflow.visible,
      this.textAlign = TextAlign.start,
      this.textColor = Colors.white,
      this.textSize = 10,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? null,
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.visible,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
          color: textColor ?? AppTheme.textBlack,
          fontSize: textSize ?? Dimens.font12,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }
}
