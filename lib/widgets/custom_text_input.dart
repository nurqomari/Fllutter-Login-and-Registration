import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/dimen.dart';

class CustomTextInputDebounce {
  static Map<Function, Timer> _timeouts = {};

  static debounce(Duration timeout, Function target,
      [List arguments = const []]) {
    if (_timeouts.containsKey(target)) {
      _timeouts[target]!.cancel();
    }

    Timer timer = Timer(timeout, () {
      Function.apply(target, arguments);
    });

    _timeouts[target] = timer;
  }
}

class CustomTextInput extends StatelessWidget {
  TextEditingController controller;
  var textChangeCallback, onSubmitCallback, suffixActionClear, validator;
  String hint;
  late TextStyle labelTextStyle, hintTextStyle, textStyle;
  int maxLines;
  late BoxDecoration containerDecoration;
  EdgeInsets padding, contentPadding;
  TextInputType textInputType = TextInputType.text;
  late List<TextInputFormatter> inputFormatters;
  late FocusNode focusNode = FocusNode();
  late Widget prefix;
  bool isDense;
  double width, height;

  CustomTextInput({
    required this.controller,
    required this.textChangeCallback,
    required this.onSubmitCallback,
    required this.suffixActionClear,
    required this.hint,
    this.isDense = false,
    this.width = 10,
    this.height = 10,
    // this.textStyle,
    // this.hintTextStyle,
    // this.labelTextStyle,
    this.padding = EdgeInsets.zero,
    this.contentPadding = EdgeInsets.zero,
    this.maxLines = 1,
    // this.containerDecoration,
    // this.textInputType,
    // this.inputFormatters,
    // this.focusNode,
    this.validator,
    // this.prefix;
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: containerDecoration ??
          BoxDecoration(
            color: AppTheme.offWhite,
            borderRadius: BorderRadius.circular(50),
          ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLines: maxLines,
        onChanged: textChangeCallback,
        onSubmitted: onSubmitCallback,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        style: textStyle ??
            TextStyle(
                color: AppTheme.textBlack,
                fontSize: Dimens.fontS,
                fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding:
              contentPadding ?? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hint,
          isDense: isDense,
          prefixIcon: prefix ?? null,
          suffixIcon: controller != null
              ? controller.text != ""
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                      ),
                      onPressed: suffixActionClear,
                      padding: EdgeInsets.zero,
                      iconSize: 24,
                      color: Colors.grey,
                      highlightColor: Colors.grey,
                    )
                  : null
              : null,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          labelStyle: labelTextStyle ??
              TextStyle(
                  fontStyle: FontStyle.normal, color: AppTheme.textDefault),
          hintStyle: hintTextStyle ??
              TextStyle(
                  fontStyle: FontStyle.normal, color: AppTheme.textDefault),
        ),
      ),
    );
  }
}

class LocationStyleTextInput extends StatelessWidget {
  TextEditingController controller;
  var textChangeCallback,
      onSubmitCallback,
      suffixActionGetLocation,
      suffixActionClear,
      suffixType;
  String hint;
  late int maxLines;
  late Widget alternatePrefix;
  bool usePrefix, useAlternateIcon;

  LocationStyleTextInput({
    required this.controller,
    required this.textChangeCallback,
    required this.onSubmitCallback,
    required this.hint,
    // this.maxLines,
    this.suffixActionGetLocation,
    this.suffixActionClear,
    this.usePrefix = true,
    this.useAlternateIcon = false,
    // this.alternatePrefix
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(50),
        ),
        // alignment: Alignment.center,
        child: Transform.translate(
          offset: Offset(0, 0),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            onChanged: textChangeCallback,
            onSubmitted: onSubmitCallback,
            // textAlignVertical: TextAlignVertical.top,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimens.font13,
                fontWeight: FontWeight.w500),
            decoration: AppTheme.inputDecorationRoundLocation(hint,
                prefixIcon: usePrefix
                    ? alternatePrefix != null
                        ? alternatePrefix
                        : Image.asset(
                            "assets/icons/order/location.png",
                            height: 14,
                            width: 10.5,
                          )
                    // Icon(
                    //     Icons.location_on,
                    //     size: 20,
                    //     color: Colors.black,
                    //   )
                    : null,
                suffixAction: controller.text != ""
                    ? suffixActionClear
                    : suffixActionGetLocation,
                suffixType: controller.text != ""
                    ? LocationSuffixAction.clear
                    : LocationSuffixAction.getCurrentLocation),
          ),
        ));
  }
}

class LoginStyleTextInput extends StatelessWidget {
  TextEditingController controller;
  var textChangeCallBack, onSubmitCallback, validator;
  late String hint, errorText;
  FocusNode focusNode;
  late int maxLines;
  TextInputType textInputType = TextInputType.text;
  bool obscureText, readOnly;
  TextAlign textAlign;
  late double width, height;
  late EdgeInsets contentPadding, margin;
  var onTap;

  LoginStyleTextInput(
      {required this.controller,
      required this.textChangeCallBack,
      required this.onSubmitCallback,
      required this.hint,
      required this.focusNode,
      // this.maxLines,
      this.validator,
      required this.textInputType,
      this.obscureText = false,
      required this.errorText,
      this.textAlign = TextAlign.start,
      this.width = 301.2,
      // this.height,
      required this.contentPadding,
      required this.margin,
      this.readOnly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: TextFormField(
        controller: controller,
        // validator: validator,
        focusNode: focusNode,
        onSaved: onSubmitCallback,
        readOnly: readOnly,
        onTap: () async {
          if (onTap != null) onTap();
        },
        textAlign: textAlign,
        style: TextStyle(fontSize: Dimens.fontM),
        obscureText: obscureText,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          errorText: errorText,
          hintText: hint,
          hintStyle: TextStyle(fontSize: Dimens.fontM, height: 0),
          errorMaxLines: 3,
          contentPadding:
              contentPadding ?? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(0xffE8E8E8),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xff64feab), width: 2.0),
          ),
          // errorText: state.data.error.emailError,
        ),
        onChanged: textChangeCallBack,
      ),
    );
  }
}

class RegisterStyleTextInput extends StatelessWidget {
  TextEditingController controller;
  var textChangeCallBack, onSubmitCallback, validator;
  String hint = "", errorText = "";
  FocusNode focusNode;
  late int maxLines;
  TextInputType textInputType = TextInputType.text;
  bool obscureText, readOnly;
  TextAlign textAlign;
  double width;
  var onTap;

  RegisterStyleTextInput(
      {required this.controller,
      required this.textChangeCallBack,
      required this.onSubmitCallback,
      required this.hint,
      required this.focusNode,
      // this.maxLines,
      this.validator,
      // this.textInputType,
      this.obscureText = false,
      // this.errorText,
      this.textAlign = TextAlign.start,
      this.width = 301.2,
      this.readOnly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        // validator: validator,
        focusNode: focusNode,
        onSaved: onSubmitCallback,
        readOnly: readOnly,
        onTap: () async {
          if (onTap != null) onTap();
        },
        textAlign: textAlign,
        style: TextStyle(fontSize: Dimens.fontM),
        obscureText: obscureText,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: RichText(
            text: TextSpan(
              text: hint,
              style:
                  TextStyle(fontSize: Dimens.fontS, color: Color(0xffAEB0B3)),
              children: const <TextSpan>[
                TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          errorText: errorText,
          errorMaxLines: 3,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(0xffE8E8E8),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xff64feab), width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(0xffE8E8E8),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          // errorText: state.data.error.emailError,
        ),
        onChanged: textChangeCallBack,
      ),
    );
  }
}
