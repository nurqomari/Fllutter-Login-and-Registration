import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koffie_flutter_bdd/blocs/register/registration_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/register/state/registration_state.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/constants/strings.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/models/register/registration_model.dart';
import 'package:koffie_flutter_bdd/screens/login/email_login.dart';
import 'package:koffie_flutter_bdd/screens/register/register_step_two.dart';
import 'package:koffie_flutter_bdd/utils/validators.dart';
import 'package:koffie_flutter_bdd/widgets/custom_app_bar.dart';
import 'package:koffie_flutter_bdd/widgets/custom_button.dart';
import 'package:koffie_flutter_bdd/widgets/custom_dialog.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text_input.dart';

class RegisterStepOne extends StatefulWidget {
  static const String ID = "register_step_one";

  _State createState() => _State();
}

class _State extends State<RegisterStepOne> {
  RegistrationBloc? registrationBloc;
  var formKey = new GlobalKey<FormState>();
  RegistrationModel registrationModel = RegistrationModel.addAllProperties(
      '', '', '', '', 1, false, '', '', '', '', '');

  String? _password,
      _confirmPassword,
      _hp,
      _pmassword,
      _firstName,
      _lastname,
      _email;
  TextEditingController _emailController = TextEditingController(),
      _firstNameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _hpController = TextEditingController(),
      _confirmPasswordController = TextEditingController(),
      _lastnameController = TextEditingController();
  var emailFocusNode = FocusNode(),
      lastnameFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode(),
      passwordFocusNode = FocusNode(),
      hpFocusNode = FocusNode(),
      firstnameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
  }

  bool isLoading = false;
  setLoadingState({@required state}) {
    setState(() {
      isLoading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = false;
    var isClear = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          child: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/background.png'),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: Column(children: [
          BlocListener<RegistrationBloc, RegistrationState>(
              child: Container(),
              listener: (context, state) async {
                if (state is OnSuccessRegistration) {
                  //show dialog lanjut ke login
                  setLoadingState(state: false);
                  WidgetsBinding.instance?.addPostFrameCallback((_) async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            content: Container(
                                height: Dimens.screenHeight(context,
                                    spaceMultiplier: 0.37),
                                width: Dimens.screenWidth(context,
                                    spaceMultiplier: 0.7),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 80,
                                        height: 60,
                                        child: Icon(
                                          Icons.check,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 20)),
                                    Text(
                                      "Your reservation is complete",
                                      style: TextStyle(
                                          fontSize: Dimens.font14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 20)),
                                    Text(
                                      "Please also check your email",
                                      style: TextStyle(
                                          fontSize: Dimens.font12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "for detail confirmation.",
                                      style: TextStyle(
                                          fontSize: Dimens.font12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 20)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                            ),
                                            child: Text(
                                              "OK!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Dimens.font10),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  EmailLogin.ID,
                                                  (Route<dynamic> route) =>
                                                      false);
                                              // Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )));
                      },
                    );
                  });
                }
                if (state is OnErrorRegistration) {
                  //show dialog balik ke form
                  setLoadingState(state: false);
                  WidgetsBinding.instance!.addPostFrameCallback((_) async {
                    await Flushbar(
                      messageText: Text(
                        'Registration failed',
                        // style: GoogleFonts.getFont('Montserrat',
                        //     fontSize: 14, color: Colors.white),
                      ),
                      margin: EdgeInsets.only(bottom: 30),
                      maxWidth: MediaQuery.of(context).size.width * 0.85,
                      padding: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(20),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ).show(context);
                  });
                }
                if (state is OnProgressRegistration) {
                  //show progress
                  setLoadingState(state: true);
                  CustomDialog.getLoadingDialog(context);
                }
              }),
          Expanded(
            child: Stack(children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(8.0),
                child: Form(
                    key: formKey,
                    child: Container(
                      // margin: EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 0.085 * SizeConfig.screenHeight!,
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
                          SizedBox(height: 20.0),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: 0.06 * SizeConfig.screenWidth!,
                                left: 0.06 * SizeConfig.screenWidth!),
                            child: RegisterStyleTextInput(
                              controller: _firstNameController,
                              textChangeCallBack: (value) {},
                              onSubmitCallback: (value) => _firstName = value,
                              hint: "First Name",
                              width: double.infinity,
                              focusNode: firstnameFocusNode,
                              // validator: (String value) {
                              //   if (value.isEmpty) {
                              //     if (firstnameFocusNode.hasFocus ||
                              //         surnameFocusNode.hasFocus) {
                              //       firstnameFocusNode.requestFocus();
                              //     }
                              //     return Strings.registerFirstNameRequired;
                              //   }

                              //   if (value.length > 50) {
                              //     firstnameFocusNode.requestFocus();
                              //     return Strings.registerFirstNameInvalid;
                              //   }
                              // },
                            ),
                          ),
                          SizedBox(
                            height: Dimens.screenHeight(context,
                                spaceMultiplier: Dimens.mQueryVerticalXs),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: 0.06 * SizeConfig.screenWidth!,
                                left: 0.06 * SizeConfig.screenWidth!),
                            child: RegisterStyleTextInput(
                              controller: _lastnameController,
                              textChangeCallBack: (value) {},
                              onSubmitCallback: (value) => _lastname = value,
                              hint: "Last Name",
                              width: double.infinity,
                              focusNode: lastnameFocusNode,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  if (firstnameFocusNode.hasFocus ||
                                      firstnameFocusNode.hasFocus) {
                                    lastnameFocusNode.requestFocus();
                                  }
                                  return Strings.registerSurnameRequired;
                                }

                                if (value.length > 50) {
                                  lastnameFocusNode.requestFocus();
                                  return Strings.registerSurnameInvalid;
                                }
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: 0.06 * SizeConfig.screenWidth!,
                                left: 0.06 * SizeConfig.screenWidth!),
                            child: RegisterStyleTextInput(
                              controller: _hpController,
                              textChangeCallBack: (value) {},
                              onSubmitCallback: (value) => _hp = value,
                              hint: "Phone",
                              focusNode: hpFocusNode,
                              width: double.infinity,
                              // validator: (value) {
                              //   if (_usernameController.text.isEmpty &&
                              //       _firstNameController.text.isEmpty &&
                              //       _surnameController.text.isEmpty) {
                              //     firstnameFocusNode.requestFocus();
                              //   }

                              //   if (value.isEmpty) {
                              //     firstnameFocusNode.requestFocus();
                              //     return Strings.registerUsernameRequired;
                              //   }

                              //   bool isValid = validateUsername(value);
                              //   if (!isValid) {
                              //     firstnameFocusNode.requestFocus();
                              //     return Strings.registerUsernameInvalid;
                              //   }
                              // },
                            ),
                          ),
                          SizedBox(
                            height: Dimens.screenHeight(context,
                                spaceMultiplier: Dimens.mQueryVerticalXs),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: 0.06 * SizeConfig.screenWidth!,
                                left: 0.06 * SizeConfig.screenWidth!),
                            child: RegisterStyleTextInput(
                              controller: _emailController,
                              textChangeCallBack: (value) {},
                              onSubmitCallback: (value) => _email = value,
                              hint: "Email",
                              focusNode: emailFocusNode,
                              width: double.infinity,
                              // validator: (value) {
                              //   if (_usernameController.text.isEmpty &&
                              //       _firstNameController.text.isEmpty &&
                              //       _surnameController.text.isEmpty) {
                              //     firstnameFocusNode.requestFocus();
                              //   }

                              //   if (value.isEmpty) {
                              //     firstnameFocusNode.requestFocus();
                              //     return Strings.registerUsernameRequired;
                              //   }

                              //   bool isValid = validateUsername(value);
                              //   if (!isValid) {
                              //     firstnameFocusNode.requestFocus();
                              //     return Strings.registerUsernameInvalid;
                              //   }
                              // },
                            ),
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
                              // validator: (String value) {
                              //   if (value.isEmpty) {
                              //     if (emailFocusNode.hasFocus ||
                              //         confirmPasswordFocusNode.hasFocus) {
                              //       passwordFocusNode.requestFocus();
                              //     }
                              //     return Strings.registerPasswordRequired;
                              //   } else {
                              //     _passwordController.text = value.trim();
                              //     bool isValid =
                              //         validatePassword(value.trim());

                              //     if (!isValid) {
                              //       passwordFocusNode.requestFocus();
                              //       return Strings.registerPasswordInvalid;
                              //     }
                              //   }
                              //   return null;
                              // },
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
                              textChangeCallBack: (value) =>
                                  _confirmPassword = value,
                              onSubmitCallback: (value) =>
                                  _confirmPassword = value,
                              width: double.infinity,
                              hint: "Confirm password",
                              obscureText: true,
                              focusNode: confirmPasswordFocusNode,
                              // validator: (String value) {
                              //   if (value.isEmpty) {
                              //     if (emailFocusNode.hasFocus ||
                              //         passwordFocusNode.hasFocus) {
                              //       confirmPasswordFocusNode.requestFocus();
                              //     }
                              //     return Strings.registerReEnterPassword;
                              //   }

                              //   if (_passwordController.text.trim() !=
                              //       _confirmPasswordController.text.trim()) {
                              //     if (passwordFocusNode.hasFocus) {
                              //       confirmPasswordFocusNode.requestFocus();
                              //     }
                              //     return Strings.registerPasswordDoesNotMatch;
                              //   }

                              //   return null;
                              // },
                            ),
                          ),
                          SizedBox(
                            height: Dimens.screenHeight(context,
                                spaceMultiplier: Dimens.mQueryVerticalXs),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 0.06 * SizeConfig.screenWidth!),
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
                                margin: EdgeInsets.only(
                                    left: 0.06 * SizeConfig.screenWidth!),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check_circle_outline_rounded,
                                        size: 9.6),
                                    CustomText(
                                      width: 0.5 * SizeConfig.screenWidth!,
                                      text: "8 to 20 characters",
                                      textColor: AppTheme.textGrey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimens.font12,
                                      margin: EdgeInsets.only(
                                          left: 0.05 * SizeConfig.screenWidth!),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.0),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 0.06 * SizeConfig.screenWidth!),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.check_circle_outline_rounded,
                                        size: 9.6),
                                    CustomText(
                                      text:
                                          "Letter, number and special characters",
                                      textColor: AppTheme.textGrey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimens.font12,
                                      maxLines: 2,
                                      width: 0.7 * SizeConfig.screenWidth!,
                                      overflow: TextOverflow.ellipsis,
                                      margin: EdgeInsets.only(
                                          left: 0.05 * SizeConfig.screenWidth!),
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
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: CustomMaterialButton(
                              callbackFunction: isLoading
                                  ? () {}
                                  : () {
                                      final form = formKey.currentState;
                                      // if (form!.validate()) {
                                      form!.save();
                                      String firstname = _firstName!.replaceAll(
                                          RegExp(r"\s+\b|\b\s"), "");
                                      _firstNameController.text = firstname;

                                      String lastname = _lastname!.replaceAll(
                                          RegExp(r"\s+\b|\b\s"), "");
                                      _lastnameController.text = lastname;

                                      String hp = _hp!.replaceAll(
                                          RegExp(r"\s+\b|\b\s"), "");
                                      _hpController.text = hp;

                                      String email = _email!.replaceAll(
                                          RegExp(r"\s+\b|\b\s"), "");
                                      _emailController.text = email;

                                      String password = _password!.replaceAll(
                                          RegExp(r"\s+\b|\b\s"), "");
                                      _passwordController.text = password;

                                      String confirmPassword = _confirmPassword!
                                          .replaceAll(
                                              RegExp(r"\s+\b|\b\s"), "");
                                      _confirmPasswordController.text =
                                          confirmPassword;

                                      log("firstname:$firstname, lastname: $lastname, phone: $hp,email: $email, password: $password");
                                      if (firstname != "" &&
                                          lastname != "" &&
                                          email != "" &&
                                          password != "") {
                                        registrationModel.firstname = firstname;
                                        registrationModel.email = email;
                                        registrationModel.lastname = lastname;
                                        registrationModel.hp = hp;
                                        registrationModel.password = password;

                                        registrationBloc!
                                            .attemptRegister(registrationModel);
                                      }
                                      // } else {}
                                    },
                              caption: "Submit",
                              captionSize: 20,
                              buttonColor: isLoading
                                  ? AppTheme.primaryLight
                                  : isClear
                                      ? AppTheme.primary
                                      : AppTheme.buttonGrey,
                              buttonWidth: double.infinity,
                              buttonHeight: 0.065 * SizeConfig.screenHeight!,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 0.085 * SizeConfig.screenWidth!),
                          ),
                        ],
                      ),
                    )),
              ),
            ]),
          ),
        ]),
      )),
    );
  }
}
