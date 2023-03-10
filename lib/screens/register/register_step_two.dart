import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/register/registration_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/register/state/registration_state.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/constants/strings.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/models/register/registration_model.dart';
import 'package:koffie_flutter_bdd/screens/login/email_login.dart';
import 'package:koffie_flutter_bdd/screens/register/insertreferalcode.dart';
import 'package:koffie_flutter_bdd/utils/validators.dart';
import 'package:koffie_flutter_bdd/widgets/custom_app_bar.dart';
import 'package:koffie_flutter_bdd/widgets/custom_button.dart';
import 'package:koffie_flutter_bdd/widgets/custom_dialog.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text_input.dart';

class RegisterStepTwo extends StatefulWidget {
  static const String ID = "register_step_two";
  RegistrationModel registrationModel;

  RegisterStepTwo(this.registrationModel);

  _State createState() => _State();
}

class _State extends State<RegisterStepTwo> {
  String? _email, _password, _confirmPassword;
  var formKey = new GlobalKey<FormState>();
  TextEditingController _passwordController = new TextEditingController(),
      _confirmPasswordController = new TextEditingController(),
      _emailController = new TextEditingController();
  RegistrationBloc? registrationBloc;
  var emailFocusNode = FocusNode(),
      passwordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();

  SimpleCustomDialog simpleDialog = SimpleCustomDialog();

  @override
  void initState() {
    super.initState();
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocListener(
                  bloc: registrationBloc,
                  listener: (context, state) {
                    if (state is OnSuccessRegistrationValidation) {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, InsertReferalCode.ID,
                          arguments: {
                            "registrationModel": widget.registrationModel
                          });
                    }

                    if (state is OnErrorRegistrationValidation) {
                      Navigator.of(context).pop();
                    }

                    if (state is OnProgressRegistrationValidation) {
                      CustomDialog.getLoadingDialogWithText(context,
                          text: "Validating email");
                    }
                  },
                  child: Container(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: CustomAppBar(
                    "",
                    () => Navigator.pop(context),
                    marginLeft: 0.05 * SizeConfig.screenWidth!,
                    marginTop: Dimens.spaceM,
                  ),
                ),
                Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Dimens.screenHeight(context,
                      spaceMultiplier: Dimens.mQueryVerticalM),
                ),
                Container(
                  margin: EdgeInsets.only(left: 0.06 * SizeConfig.screenWidth!),
                  child: CustomText(
                    text: "Email",
                    textColor: Color(0xff1884A3),
                    fontSize: Dimens.font12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.0),
                BlocBuilder(
                  bloc: registrationBloc,
                  builder: (context, state) {
                    Widget emailForm = Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: 0.06 * SizeConfig.screenWidth!,
                          right: 0.06 * SizeConfig.screenWidth!),
                      child: RegisterStyleTextInput(
                        controller: _emailController,
                        textChangeCallBack: (value) => _email = value,
                        onSubmitCallback: (value) => _email = value,
                        hint: "Email",
                        width: double.infinity,
                        focusNode: emailFocusNode,
                        // errorText: state is OnErrorRegistrationValidation
                        //     ? state.errorContainer != null
                        //         ? state.errorContainer['message']
                        //         : null
                        //     : null,
                        validator: (String value) {
                          if (value.isEmpty &&
                              _passwordController.text.isEmpty &&
                              _confirmPasswordController.text.isEmpty) {
                            emailFocusNode.requestFocus();
                          }

                          if (value.isEmpty) {
                            emailFocusNode.requestFocus();
                            return Strings.registerEmailRequired;
                          }

                          _emailController.text = value.trim();
                          bool isValid = validateEmail(value.trim());
                          if (!isValid) {
                            emailFocusNode.requestFocus();
                            return Strings.registerEmailEmpty;
                          }
                        },
                      ),
                    );

                    if (state is OnInitRegistration) {
                      return emailForm;
                    }

                    if (state is OnErrorRegistrationValidation) {
                      return emailForm;
                    }

                    if (state is OnProgressRegistrationValidation) {
                      return emailForm;
                    }

                    if (state is OnSuccessRegistrationValidation) {
                      return emailForm;
                    }

                    return Container();
                  },
                ),
                SizedBox(
                  height: Dimens.screenHeight(context,
                      spaceMultiplier: Dimens.mQueryVerticalXs),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: 0.06 * SizeConfig.screenWidth!,
                      right: 0.06 * SizeConfig.screenWidth!),
                  child: RegisterStyleTextInput(
                    controller: _passwordController,
                    textChangeCallBack: (value) => _password = value,
                    onSubmitCallback: (value) => _password = value,
                    width: double.infinity,
                    hint: "Password",
                    focusNode: passwordFocusNode,
                    obscureText: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        if (emailFocusNode.hasFocus ||
                            confirmPasswordFocusNode.hasFocus) {
                          passwordFocusNode.requestFocus();
                        }
                        return Strings.registerPasswordRequired;
                      } else {
                        _passwordController.text = value.trim();
                        bool isValid = validatePassword(value.trim());

                        if (!isValid) {
                          passwordFocusNode.requestFocus();
                          return Strings.registerPasswordInvalid;
                        }
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: Dimens.screenHeight(context,
                      spaceMultiplier: Dimens.mQueryVerticalXs),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: 0.06 * SizeConfig.screenWidth!,
                      right: 0.06 * SizeConfig.screenWidth!),
                  child: RegisterStyleTextInput(
                    controller: _confirmPasswordController,
                    textChangeCallBack: (value) => _confirmPassword = value,
                    onSubmitCallback: (value) => _confirmPassword = value,
                    width: double.infinity,
                    hint: "Confirm password",
                    obscureText: true,
                    focusNode: confirmPasswordFocusNode,
                    validator: (String value) {
                      if (value.isEmpty) {
                        if (emailFocusNode.hasFocus ||
                            passwordFocusNode.hasFocus) {
                          confirmPasswordFocusNode.requestFocus();
                        }
                        return Strings.registerReEnterPassword;
                      }

                      if (_passwordController.text.trim() !=
                          _confirmPasswordController.text.trim()) {
                        if (passwordFocusNode.hasFocus) {
                          confirmPasswordFocusNode.requestFocus();
                        }
                        return Strings.registerPasswordDoesNotMatch;
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                RegistrationInfo(),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 0.06 * SizeConfig.screenWidth!, vertical: 16),
                  child: CustomMaterialButton(
                      buttonWidth: double.infinity,
                      buttonHeight: 50,
                      callbackFunction: () {
                        final form = formKey.currentState;
                        if (form!.validate()) {
                          widget.registrationModel.firstname = widget
                              .registrationModel.firstname!
                              .replaceAll(RegExp(r"\s+\b|\b\s"), "");
                          widget.registrationModel.lastname = widget
                              .registrationModel.lastname!
                              .replaceAll(RegExp(r"\s+\b|\b\s"), "");
                          widget.registrationModel.email =
                              _email!.replaceAll(RegExp(r"\s+\b|\b\s"), "");
                          widget.registrationModel.password =
                              _password!.replaceAll(RegExp(r"\s+\b|\b\s"), "");

                          var email =
                              _email!.replaceAll(RegExp(r"\s+\b|\b\s"), "");

                          // registrationBloc.validateRegistrationData(email);
                        }

                        if (_confirmPasswordController.text.isEmpty) {
                          confirmPasswordFocusNode.requestFocus();
                        }

                        if (_passwordController.text.isEmpty &&
                            _confirmPasswordController.text.isEmpty) {
                          passwordFocusNode.requestFocus();
                        }

                        if (_emailController.text.isEmpty &&
                            _passwordController.text.isEmpty &&
                            _confirmPasswordController.text.isEmpty) {
                          emailFocusNode.requestFocus();
                        }
                      },
                      caption: "Submit"),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Container(
              child: CustomText(
                text: "Already have an account? ",
                textColor: AppTheme.textDefault,
                fontSize: Dimens.font16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              child: CustomText(
                text: "Login",
                textColor: Color(0xff1884A3),
                fontSize: Dimens.font16,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.pushNamed(context, EmailLogin.ID,
                    arguments: Origin.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: 0.06 * SizeConfig.screenWidth!),
          child: Text(
            "Your password must have:",
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 3.0),
        Container(
          margin: EdgeInsets.only(left: 0.06 * SizeConfig.screenWidth!),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline_rounded, size: 9.6),
              CustomText(
                width: 0.5 * SizeConfig.screenWidth!,
                text: "8 to 20 characters",
                textColor: AppTheme.textGrey,
                fontWeight: FontWeight.w600,
                fontSize: Dimens.font12,
                margin: EdgeInsets.only(left: 0.05 * SizeConfig.screenWidth!),
              )
            ],
          ),
        ),
        SizedBox(height: 3.0),
        Container(
          margin: EdgeInsets.only(left: 0.06 * SizeConfig.screenWidth!),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.check_circle_outline_rounded, size: 9.6),
              CustomText(
                text: "Letter, number and special characters",
                textColor: AppTheme.textGrey,
                fontWeight: FontWeight.w600,
                fontSize: Dimens.font12,
                maxLines: 2,
                width: 0.7 * SizeConfig.screenWidth!,
                overflow: TextOverflow.ellipsis,
                margin: EdgeInsets.only(left: 0.05 * SizeConfig.screenWidth!),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.03 * SizeConfig.screenHeight!,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center,
          //Center Row contents vertically,
          children: [
            CustomText(
              text: "By continuing, you agree to",
              fontSize: Dimens.font11,
              textColor: AppTheme.textGrey,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(width: 5),
            CustomText(
              text: "Seven Butlers",
              fontSize: Dimens.font11,
              textColor: AppTheme.textBlack,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 3.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center,
          //Center Row contents vertically,
          children: [
            SizedBox(width: 10),
            GestureDetector(
              // onTap: () => Navigator.pushNamed(context, TermsOfUse.ID),
              child: CustomText(
                text: "Terms Of Use",
                fontSize: Dimens.font11,
                textColor: AppTheme.textBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5),
            CustomText(
              text: "and confirm that you have",
              fontSize: Dimens.font11,
              textColor: AppTheme.textGrey,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            CustomText(
              text: "read",
              fontSize: Dimens.font11,
              textColor: AppTheme.textGrey,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(width: 5),
            GestureDetector(
              // onTap: () => Navigator.pushNamed(context, PrivacyPolicy.ID),
              child: CustomText(
                text: "Seven Butlers Privacy Policy",
                fontSize: Dimens.font11,
                textColor: AppTheme.textBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ],
    );
  }
}
