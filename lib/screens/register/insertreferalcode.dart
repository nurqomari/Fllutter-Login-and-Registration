import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koffie_flutter_bdd/blocs/register/registration_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/register/state/registration_state.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/models/register/registration_model.dart';
import 'package:koffie_flutter_bdd/screens/register/register_final_step.dart';
import 'package:koffie_flutter_bdd/utils/session_manager.dart';
import 'package:koffie_flutter_bdd/widgets/custom_app_bar.dart';
import 'package:koffie_flutter_bdd/widgets/custom_button.dart';
import 'package:koffie_flutter_bdd/widgets/custom_dialog.dart';
import 'package:koffie_flutter_bdd/widgets/custom_text.dart';

class InsertReferalCode extends StatefulWidget {
  static const String ID = "insert_referal";
  RegistrationModel registrationModel;

  InsertReferalCode(this.registrationModel);

  _State createState() => _State();
}

class _State extends State<InsertReferalCode> {
  RegistrationBloc? _bloc;

  // static final List<String> languagesList = application.supportedLanguages;
  // static final List<String> languageCodesList = application.supportedLanguagesCodes;

  SimpleCustomDialog simpleDialog = SimpleCustomDialog();

  // final Map<dynamic, dynamic> languagesMap = {
  //   languagesList[0]: languageCodesList[0],
  //   languagesList[1]: languageCodesList[1],
  // };

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // application.onLocaleChanged = onLocaleChange;
    // onLocaleChange(Locale(languagesMap["English"]));
    _bloc = BlocProvider.of<RegistrationBloc>(context);
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      // AppTranslations.load(locale);
    });
  }

  var sessionManager = SessionManager();

  void _select(String language) async {
    // onLocaleChange(Locale(languagesMap[language]));
    // await sessionManager.setLanguage(languagesMap[language]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is OnSuccessRegistration) {
            simpleDialog.show(context,
                alertType: Alert.info,
                message:
                    "We've sent you an email with activation link. Please check your email to complete your registration.",
                action: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RegisterFinalStep.ID, (route) => false, arguments: {
                'email': widget.registrationModel.email,
                'message': state.data.responseMessage
              });
            });
          }

          if (state is OnErrorRegistration) {
            var message = "${state.errorContainer['message']}";
            Navigator.pop(context);
            simpleDialog.show(context,
                alertType: Alert.error,
                message: "Registration code is invalid");
          }

          if (state is OnProgressRegistration) {
            CustomDialog.getLoadingDialog(context);
          }
        },
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.screenWidth! * 0.7,
                          alignment: Alignment.centerLeft,
                          child: CustomAppBar(
                            "Insert referral code",
                            () => Navigator.pop(context, "home"),
                            backButtonStyle: BackButtonStyle.withoutBackground,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            widget.registrationModel.referral_code = "";
                            _bloc!.attemptRegister(widget.registrationModel);
                          },
                          child: CustomText(
                            fontWeight: FontWeight.w600,
                            textColor: Colors.black,
                            text: "SKIP",
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            margin: EdgeInsets.only(right: 0.06.sw),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 46,
                    ),
                    Image.asset('assets/images/refer2.png',
                        width: 300, height: 303),
                    SizedBox(
                      height: 8,
                    ),
                    CustomText(
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      text:
                          "Insert a referral code to help your referral get more points or insert merchant code to help your favorite merchant provide better service",
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      margin: EdgeInsets.only(left: 0.06.sw, right: 0.06.sw),
                    ),
                    SizedBox(
                      height: 46,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.06.sw, right: 0.06.sw),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          color: Color(0xFFF6F6FC),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth! * 0.5,
                              child: TextFormField(
                                autofocus: true,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.only(left: 20),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                controller: controller,
                                onTap: () async {},
                                keyboardType: TextInputType.text,
                              ),
                              // CustomText(fontSize: 16, text: "7BJANED",fontWeight: FontWeight.w800,textColor: Colors.black,
                              //   textAlign: TextAlign.center,)
                              //
                            ),
                            CustomMaterialButton(
                              callbackFunction: () {
                                widget.registrationModel.referral_code =
                                    controller.text;
                                _bloc!
                                    .attemptRegister(widget.registrationModel);
                              },
                              caption: "Confirm",
                              buttonWidth: SizeConfig.screenWidth! * 0.3,
                              buttonHeight: 40,
                              buttonColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomText(
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black54,
                      text: "Don’t have any code? Just skip",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      margin: EdgeInsets.only(left: 0.06.sw, right: 0.06.sw),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Future<void> share() async {
  //   await FlutterShare.share(
  //       title: 'Share',
  //       text:
  //           'I’m giving you 100 reward points on 7Butlers app.\nTo accept, use code 7BJANED when you register.'
  //           '\nDetails: https://refer.7Butlers.nl/7BJANED',
  //       // linkUrl: 'https://flutter.dev/',
  //       chooserTitle: 'Share');
  // }
}
