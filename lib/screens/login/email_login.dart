import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_visibility_detector/keyboard_visibility_detector.dart';
import 'package:koffie_flutter_bdd/blocs/login/data/login_data.dart';
import 'package:koffie_flutter_bdd/blocs/login/login_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/login/state/login_state.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/constants/strings.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/screens/home_screen.dart';
import 'package:koffie_flutter_bdd/screens/register/register_step_one.dart';
import 'package:koffie_flutter_bdd/utils/Validators.dart';
import 'package:koffie_flutter_bdd/utils/session_manager.dart';
import 'package:koffie_flutter_bdd/widgets/custom_app_bar.dart';
import 'package:koffie_flutter_bdd/widgets/custom_button.dart';
import 'package:koffie_flutter_bdd/widgets/custom_dialog.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text_input.dart';

enum Origin { mainLogin, register, registerFinal }

class EmailLogin extends StatefulWidget {
  static const String ID = "login";
  Origin? origin;

  // EmailLogin(this.origin);

  _State createState() => _State();
}

class _State extends State<EmailLogin> {
  LoginBloc? loginBloc;
  TextEditingController _emailInputController = TextEditingController(),
      _passwordInputController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  String? _email, _password;
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();

  LoginData? loginData;
  Map? errorContainer;

  bool isClear = false, isLoading = false;

  isLoggedIn() async {
    bool isLoggedIn = await SessionManager().isLoggedIn();
    return isLoggedIn;
  }

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  setLoadingState({@required state}) {
    setState(() {
      isLoading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is OnSuccessLogin) {
              setLoadingState(state: false);
              // Navigator.pop(context);

              if (state.loginData.isLogin) {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.ID, (route) => false);
              }
            }

            if (state is OnErrorLogin) {
              setLoadingState(state: false);
              Navigator.pop(context);

              setState(() {
                errorContainer = state.errorContainer;
              });

              if (state.errorContainer != null) {
                if (state.errorContainer!['type'] ==
                    LoginErrorType.emailError) {
                  emailFocusNode.requestFocus();
                }

                if (state.errorContainer!['type'] ==
                    LoginErrorType.passwordError) {
                  passwordFocusNode.requestFocus();
                }

                setState(() {});
              }
            }

            if (state is OnProgressLogin) {
              setLoadingState(state: true);
              CustomDialog.getLoadingDialog(context);
            }
          },
          child: Form(
            key: formKey,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewport) =>
                  SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewport.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 16, top: 48),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image(
                                image: AssetImage(
                                  'assets/logo-koffie.png',
                                ),
                                height: 100,
                                width: SizeConfig.screenWidth! * 0.5,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(Dimens.spaceS),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.2),
                              ),
                            ),
                            child: Column(children: [
                              SizedBox(
                                height: Dimens.screenHeight(context,
                                    spaceMultiplier: Dimens.mQueryVerticalS),
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: "Montserrat",
                                    letterSpacing: -1.0,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: Dimens.screenHeight(context,
                                    spaceMultiplier: Dimens.mQueryVerticalS),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(
                              //       top: Dimens.spaceXs,
                              //       left: 0.09 * SizeConfig.screenWidth!),
                              //   alignment: Alignment.centerLeft,
                              //   child: Ink(
                              //     child: InkWell(
                              //       splashColor: Colors.transparent,
                              //       highlightColor: Colors.transparent,
                              //       onTap: () {
                              //         if (widget.origin == Origin.mainLogin ||
                              //             widget.origin == Origin.register) {
                              //           Navigator.pop(context);
                              //         } else if (widget.origin ==
                              //             Origin.registerFinal) {
                              //           // Navigator.pushNamed(context, MainLogin.ID);
                              //         }
                              //       },
                              //       child:
                              //       BackIcon(
                              //           BackButtonStyle.withoutBackground,
                              //           false),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 16,
                              ),
                              LoginStyleTextInput(
                                controller: _emailInputController,
                                textChangeCallBack: (text) {
                                  if ((text != " " &&
                                          _passwordInputController.text !=
                                              " ") &&
                                      (text.isNotEmpty &&
                                          _passwordInputController
                                              .text.isNotEmpty)) {
                                    setState(() {
                                      isClear = true;
                                    });
                                  } else {
                                    setState(() {
                                      isClear = false;
                                    });
                                  }
                                },
                                contentPadding: EdgeInsets.zero,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0.08 * SizeConfig.screenWidth!,
                                    vertical: 0.01 * SizeConfig.screenHeight!),
                                onSubmitCallback: (value) => _email = value,
                                hint: "Email address",
                                focusNode: emailFocusNode,
                                textInputType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                errorText: errorContainer != null
                                    ? errorContainer!['type'] ==
                                            LoginErrorType.emailError
                                        ? errorContainer!['message']
                                        : ""
                                    : "",
                                validator: (String value) {
                                  if (value.isEmpty &&
                                      _passwordInputController.text.isEmpty) {
                                    emailFocusNode.requestFocus();
                                  }
                                  if (value.isEmpty) {
                                    emailFocusNode.requestFocus();
                                    return Strings.loginEmailRequired;
                                  } else {
                                    _emailInputController.text = value.trim();
                                    bool isValid = validateEmail(value.trim());

                                    if (!isValid) {
                                      emailFocusNode.requestFocus();
                                      return Strings.loginEmailIncorrectFormat;
                                    }
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              LoginStyleTextInput(
                                controller: _passwordInputController,
                                textChangeCallBack: (text) {
                                  if ((_emailInputController.text != " " &&
                                          text != " ") &&
                                      (_emailInputController.text.isNotEmpty &&
                                          text.isNotEmpty)) {
                                    setState(() {
                                      isClear = true;
                                    });
                                  } else {
                                    setState(() {
                                      isClear = false;
                                    });
                                  }
                                  ;
                                },
                                contentPadding: EdgeInsets.zero,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0.08 * SizeConfig.screenWidth!,
                                    vertical: 0.01 * SizeConfig.screenHeight!),
                                onSubmitCallback: (value) => _password = value,
                                hint: "Password",
                                focusNode: passwordFocusNode,
                                textInputType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                errorText: errorContainer != null
                                    ? errorContainer!['type'] ==
                                            LoginErrorType.passwordError
                                        ? errorContainer!['message']
                                        : ""
                                    : "",
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    if (emailFocusNode.hasFocus) {
                                      passwordFocusNode.requestFocus();
                                    }
                                    return Strings.loginPasswordRequired;
                                  }
                                  return null;
                                },
                                obscureText: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              // LoginStyleTextInput(
                              //   controller: _passwordInputController,
                              //   textInputType: TextInputType.none,
                              //   textChangeCallBack: (text) {
                              //     if ((_emailInputController.text != " " &&
                              //             text != " ") &&
                              //         (_emailInputController.text.isNotEmpty &&
                              //             text.isNotEmpty)) {
                              //       setState(() {
                              //         isClear = true;
                              //       });
                              //     } else {
                              //       setState(() {
                              //         isClear = false;
                              //       });
                              //     }
                              //     ;
                              //   },
                              //   margin: EdgeInsets.symmetric(
                              //       horizontal: 0.08 * SizeConfig.screenWidth!,
                              //       vertical: 0.01 * SizeConfig.screenHeight!),
                              //   contentPadding: EdgeInsets.zero,
                              //   onSubmitCallback: (value) => _password = value,
                              //   hint: "Password",
                              //   focusNode: passwordFocusNode,
                              //   // validator: (String value) {
                              //   //   if (value.isEmpty) {
                              //   //     if (emailFocusNode.hasFocus) {
                              //   //       passwordFocusNode.requestFocus();
                              //   //     }
                              //   //     return Strings.loginPasswordRequired;
                              //   //   }

                              //   //   return null;
                              //   // },
                              //   textAlign: TextAlign.center,
                              //   errorText: errorContainer != null
                              //       ? errorContainer!['type'] ==
                              //               LoginErrorType.passwordError
                              //           ? errorContainer!['message']
                              //           : "null"
                              //       : "null",
                              //   obscureText: true,
                              // ),
                              // SizedBox(
                              //   height: 8,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  InkWell(
                                    // onTap: () => Navigator.pushNamed(
                                    //     context, ForgotPassword.ID),
                                    child: Text(
                                      "Forgot password",
                                      style: TextStyle(
                                          color: Color(0xff1884a3),
                                          fontSize: 14,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 8),
                              Container(
                                child: CustomMaterialButton(
                                  callbackFunction: isLoading
                                      ? () {}
                                      : () {
                                          final form = formKey.currentState;
                                          if (form!.validate()) {
                                            form.save();
                                            String password = _password!
                                                .replaceAll(
                                                    RegExp(r"\s+\b|\b\s"), "");
                                            _passwordInputController.text =
                                                password;

                                            String email = _email!.replaceAll(
                                                RegExp(r"\s+\b|\b\s"), "");
                                            _emailInputController.text = email;

                                            log("email: $email, password: $password");
                                            if (email != "" || password != "") {
                                              loginBloc!.attemptLogin(
                                                  email, password);
                                            }
                                          } else {}
                                        },
                                  caption: "Login",
                                  captionSize: 20,
                                  buttonColor: isLoading
                                      ? AppTheme.primaryLight
                                      : isClear
                                          ? AppTheme.primary
                                          : AppTheme.buttonGrey,
                                  buttonWidth: double.infinity,
                                  buttonHeight:
                                      0.065 * SizeConfig.screenHeight!,
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        0.085 * SizeConfig.screenWidth!),
                              ),
                              SizedBox(
                                height: Dimens.screenHeight(context,
                                    spaceMultiplier: Dimens.mQueryVerticalS),
                              ),
                            ]),
                          ),
                        ),
                        Spacer(),
                        // Wrap(
                        //   direction: Axis.horizontal,
                        //   crossAxisAlignment: WrapCrossAlignment.center,
                        //   children: [
                        // Container(
                        //   child: CustomText(
                        //     text: "Don't have account?   ",
                        //     textColor: AppTheme.textWhite,
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.w500,
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                        // SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, RegisterStepOne.ID),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: AppTheme.textLightGreen,
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        // TextButton(
                        //   child: CustomText(
                        //     text: "Register",
                        //     textColor: AppTheme.textLightGreen,
                        //     fontSize: 18,
                        //     // fontWeight: FontWeight.w700,
                        //     textAlign: TextAlign.center,
                        //   ),
                        //   onPressed: () {
                        //     // Navigator.pushNamed(
                        //     //     context, RegisterStepOne.ID);
                        //   },
                        // ),
                        //   ],
                        // ),
                        SizedBox(
                          height: Dimens.screenHeight(context,
                              spaceMultiplier: Dimens.mQueryVerticalS),
                        ),
                        KeyboardVisibilityDetector(
                          builder: (context, child, isVisible) {
                            if (isVisible) {
                              return SizedBox(
                                height: Dimens.screenHeight(context,
                                    spaceMultiplier: 0.25),
                              );
                            } else {
                              return Container();
                            }
                          },
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
