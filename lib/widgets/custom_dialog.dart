import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text.dart';

class CustomDialog {
  static popWithCount(popCount, context) {
    for (int i = 0; i < popCount; i++) {
      Navigator.of(context).pop();
    }
  }

  static Future getDialogWithTextButton(
      {@required String? title,
      @required String? message,
      @required BuildContext? context,
      int? popCount,
      String? routeId,
      bool doesRememberRoute = false,
      int returnCode = 0}) {
    return showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(
            message!,
            style: TextStyle(color: Colors.black54),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                if (popCount == null) {
                  if (doesRememberRoute) {
                    Navigator.of(context).pushNamed(routeId!);
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        routeId!, (Route<dynamic> route) => false);
                  }
                } else {
                  if (popCount > 1) {
                    for (int i = 0; i < popCount; i++) {
                      if (returnCode != 0) {
                        Navigator.of(context).pop(returnCode);
                      } else {
                        Navigator.of(context).pop();
                      }
                    }
                  } else {
                    if (returnCode != 0) {
                      Navigator.of(context).pop(returnCode);
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                }
              },
            )
          ],
        );
      },
    );
  }

  static Future getDialog(
      {@required BuildContext? context, List? actions, contents}) {
    return showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          content: contents,
          actions: actions!.cast<Widget>() ?? <Widget>[],
        );
      },
    );
  }

  static Future getLoadingDialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static Future getLoadingDialogWithText(context,
      {text = "", textColor = Colors.white, fontSize}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            CustomText(
              text: text,
              textColor: textColor,
              fontSize: fontSize ?? Dimens.font12,
              margin: EdgeInsets.symmetric(vertical: Dimens.spaceS),
            )
            /*CustomText.getCustomText(
              text,
              textColor,
              textSize,
              margin: EdgeInsets.symmetric(vertical: Dimens.spaceS),
            )*/
          ],
        );
      },
    );
  }

  static Future getExpLoadingDialog(context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 7),
            child: CustomText(
              text: "Loading...",
              textColor: AppTheme.textWhite,
              fontSize: Dimens.font14,
            ) /*CustomText.getCustomText("Loading...", AppTheme.textWhite, Dimens.fontM)*/,
          ),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

enum Alert { info, error, none, warning, confirmation }

abstract class CustomDialogTheme {
  Radius radius = Radius.circular(16);

  RoundedRectangleBorder border = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  );

  EdgeInsets contentPadding = const EdgeInsets.all(8);
  EdgeInsets insetPadding = const EdgeInsets.only(left: 32, right: 32);

  double width = 0.9 * SizeConfig.screenWidth!;

  Colors? backgroundColor;

  getBackgroundColor(Alert alertType) {
    switch (alertType) {
      case Alert.info:
        return Color(0xff4D829F);
        break;
      case Alert.confirmation:
        break;
      case Alert.error:
        return Color(0xffDA0000);
        break;
      case Alert.warning:
        break;
      case Alert.none:
        return Color(0xfff0f1f4);
        break;
      default:
        return Color(0xfff0f1f4);
        break;
    }
  }
}

abstract class CustomDialogInterface extends CustomDialogTheme {
  BuildContext? dialogContext;

  Widget create(BuildContext context,
      {String title,
      String message,
      String additionalMessage,
      var action,
      Widget customContent,
      Alert alertType});

  Future show(BuildContext context,
      {title, message, content, alertType, action}) {
    var dialog = create(context,
        title: title,
        message: message,
        customContent: content,
        alertType: alertType,
        action: action);

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          dialogContext = context;
          return dialog;
        });
  }

  close() {
    if (dialogContext != null) Navigator.pop(dialogContext!);
  }
}

class SimpleCustomDialog extends CustomDialogInterface {
  @override
  Widget create(BuildContext context,
      {String? title,
      String? message,
      String? additionalMessage,
      action,
      Widget? customContent,
      Alert alertType = Alert.none}) {
    return AlertDialog(
        insetPadding: insetPadding,
        shape: border,
        contentPadding: contentPadding,
        backgroundColor: getBackgroundColor(alertType),
        content: StatefulBuilder(
          builder: (dialogContext, setState) {
            return Container(
                width: width,
                height: 0.07 * SizeConfig.screenHeight!,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(120),
                                color: AppTheme.getLuminance(
                                    getBackgroundColor(alertType))),
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.close,
                              color: getBackgroundColor(alertType),
                              size: 16,
                            ),
                          ),
                          onTap: () => action != null
                              ? action()
                              : Navigator.pop(dialogContext),
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: message!,
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        textColor: AppTheme.getLuminance(
                            getBackgroundColor(alertType)),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ));
          },
        ));
  }
}
