import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_visibility_detector/keyboard_visibility_detector.dart';
import 'package:koffie_flutter_bdd/blocs/login/login_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/login/state/login_state.dart';
import 'package:koffie_flutter_bdd/constants/app_theme.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/models/login/user_data.dart';
import 'package:koffie_flutter_bdd/screens/login/email_login.dart';
import 'package:koffie_flutter_bdd/utils/session_manager.dart';
import 'package:koffie_flutter_bdd/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  static const String ID = "homescreen";

  /*should be homescreen, but this'll do for now*/
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getUser();
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();

    @override
    void dispose() {
      super.dispose();
    }
  }

  getUser() async {
    user = await SessionManager().getUser();
    this.setState(() {});
  }

  LoginBloc? loginBloc;
  UserData? user;
  bool isLoading = false, isClear = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is OnSuccessLogout) {
              Navigator.pushNamedAndRemoveUntil(
                  context, EmailLogin.ID, (route) => false);
            }
          },
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewport) =>
                SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: viewport.maxHeight, minWidth: viewport.maxWidth),
                child: IntrinsicHeight(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Selamat Datang\n${user?.firstname} ${user?.lastname}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: "Montserrat",
                              letterSpacing: -1.0,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 0.03 * SizeConfig.screenHeight!,
                        ),
                        Container(
                          child: CustomMaterialButton(
                            callbackFunction: isLoading
                                ? () {}
                                : () {
                                    loginBloc!.attemptLogout();
                                  },
                            caption: "Logout",
                            captionSize: 20,
                            buttonColor: AppTheme.primaryLight,
                            buttonWidth: 0.3 * SizeConfig.screenWidth!,
                            buttonHeight: 0.065 * SizeConfig.screenHeight!,
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 0.085 * SizeConfig.screenWidth!),
                        ),
                        SizedBox(
                          height: 0.05 * SizeConfig.screenHeight!,
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
