import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/screens/login/email_login.dart';
import 'package:koffie_flutter_bdd/widgets/custom_app_bar.dart';
import 'package:koffie_flutter_bdd/widgets/custom_button.dart';
import 'package:koffie_flutter_bdd/widgets/custom_dialog.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text.dart';

class RegisterFinalStep extends StatefulWidget {
  static const String ID = "registration_final";
  String email;
  String message;

  RegisterFinalStep(this.email, this.message);

  _State createState() => _State();
}

class _State extends State<RegisterFinalStep> {
  // ResendVerificationBloc _bloc;
  String messageSub = "Confirm your email soon";
  @override
  void initState() {
    super.initState();
    // _bloc = BlocProvider.of<ResendVerificationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BlocListener<ResendVerificationBloc, ResendVerificationState>(
            //   child: Container(),
            //   listener: (context, state) {
            //     if (state.isLoading) {
            //       CustomDialog.getLoadingDialog(context);
            //     } else if (!state.isLoading) {
            //       Navigator.pop(context);
            //       if (state.data.isSent) {
            //         CustomDialog.getDialog(
            //           context: context,
            //           contents: Container(
            //             width: Dimens.screenWidth(context, spaceMultiplier: 0.7),
            //             padding: EdgeInsets.only(
            //                 right: Dimens.spaceXs,
            //                 left: Dimens.spaceXs,
            //                 top: Dimens.spaceS),
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 CustomText(
            //                   text: "The activation email has been sent to your address.",
            //                   textColor: AppTheme.textDefault,
            //                   fontSize: Dimens.font14,
            //                   textAlign: TextAlign.center,
            //                   width: 0.7*SizeConfig.screenWidth!,
            //                   maxLines: 2,
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //                 CustomText(
            //                   text: "Please activate the account and login",
            //                   textColor: AppTheme.textDefault,
            //                   fontSize: Dimens.font14,
            //                   textAlign: TextAlign.center,
            //                   width: 0.7*SizeConfig.screenWidth!!,
            //                   maxLines: 2,
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //                 Container(
            //                   child: CustomMaterialButton(
            //                       caption: "OK",
            //                       buttonWidth: 0.4*SizeConfig.screenWidth!,
            //                       callbackFunction: () {
            //                         Navigator.pop(context);
            //                       }),
            //                   margin: EdgeInsets.only(top: Dimens.spaceM),
            //                   alignment: Alignment.center,
            //                 )
            //               ],
            //             ),
            //           ),
            //         );
            //       } else {
            //         if (state.data.errorContainer != null) {
            //           CustomDialog.getDialogWithTextButton(
            //               title: "",
            //               message: state.data.errorContainer['message'],
            //               context: context,
            //               popCount: 1);
            //         }
            //       }
            //     }
            //   },
            // ),
            Container(
              alignment: Alignment.centerLeft,
              child: CustomAppBar(
                "",
                () => Navigator.pushNamedAndRemoveUntil(
                    context, EmailLogin.ID, (a) => false),
                marginLeft: Dimens.spaceS,
              ),
            ),
            Spacer(),
            Center(
              child: Image.asset(
                "assets/images/mail.png",
                height: 0.3 * SizeConfig.screenHeight!,
                width: 0.4 * SizeConfig.screenWidth!,
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                width: Dimens.screenWidth(context, spaceMultiplier: 0.9),
                child: CustomText(
                  text: widget.message.contains("Invalid")
                      ? "${widget.message}\n$messageSub"
                      : messageSub,
                  fontSize: Dimens.font20,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: CustomText(
                text: "We've sent you an email with a link",
                textColor: Color(0xff898989),
                fontSize: Dimens.font14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: CustomText(
                text: "to confirm your email address.",
                textColor: Color(0xff898989),
                fontSize: Dimens.font14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: CustomText(
                text: "If you can't find it,",
                textColor: Color(0xff898989),
                fontSize: Dimens.font14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: CustomText(
                text: "you should check your spam folder",
                textColor: Color(0xff898989),
                fontSize: Dimens.font14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      // bottomNavigationBar: BlocBuilder<ResendVerificationBloc, ResendVerificationState>(
      //     builder: (context, state) {
      //   return Wrap(
      //     direction: Axis.horizontal,
      //     crossAxisAlignment: WrapCrossAlignment.center,
      //     runAlignment: WrapAlignment.center,
      //     alignment: WrapAlignment.center,
      //     runSpacing: Dimens.spaceS,
      //     children: [
      //       /*CustomButton.getCustomMaterialButton(
      //                   context: context,
      //                   buttonText: "Resend",
      //                   textColor: AppTheme.textBlack,
      //                   buttonColor: AppTheme.buttonLight,
      //                   buttonWidth: Dimens.screenWidth(context, spaceMultiplier: 0.4),
      //                   callbackFunction: state.isLoading
      //                       ? () {}
      //                       : () => _bloc.attemptResendVerification(widget.email)),*/
      //       Padding(
      //         padding: const EdgeInsets.only(bottom: 16.0),
      //         child: CustomMaterialButton(
      //           buttonHeight: 50,
      //           callbackFunction: state.isLoading
      //               ? () {}
      //               : () => _bloc.attemptResendVerification(widget.email),
      //           caption: "Resend",
      //           captionColor: AppTheme.textBlack,
      //           buttonColor: AppTheme.buttonLight,
      //           buttonWidth: 0.4.sw,
      //         ),
      //       ),
      //       SizedBox(
      //         width: 10,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(bottom: 16.0),
      //         child: CustomMaterialButton(
      //           buttonHeight: 50,
      //           callbackFunction: () => Navigator.pushNamedAndRemoveUntil(
      //               context, EmailLogin.ID, (route) => false,
      //               arguments: Origin.registerFinal),
      //           caption: "OK, I've got it",
      //           buttonWidth: 0.4.sw,
      //         ),
      //       ),
      //       /*CustomButton.getCustomMaterialButton(
      //                 context: context,
      //                 buttonText: "OK, I've got it",
      //                 textColor: AppTheme.textWhite,
      //                 buttonColor: AppTheme.primary,
      //                 buttonWidth: Dimens.screenWidth(context, spaceMultiplier: 0.4),
      //                 callbackFunction: () => Navigator.pushNamedAndRemoveUntil(
      //                     context, EmailLogin.ID, (route) => false,
      //                     arguments: Origin.registerFinal),
      //               )*/
      //     ],
      //   );
      // }),
    );
  }
}
