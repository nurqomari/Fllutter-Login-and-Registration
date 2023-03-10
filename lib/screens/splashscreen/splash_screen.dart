import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koffie_flutter_bdd/blocs/splashscreen/splash_screen_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/splashscreen/state/splash_screen_state.dart';
import 'package:koffie_flutter_bdd/constants/size_config.dart';
import 'package:koffie_flutter_bdd/dimen.dart';
import 'package:koffie_flutter_bdd/models/login/user_data.dart';
import 'package:koffie_flutter_bdd/screens/home_screen.dart';
import 'package:koffie_flutter_bdd/screens/login/email_login.dart';
import 'package:koffie_flutter_bdd/utils/session_manager.dart';

bool _initialUriIsHandled = false;

class SplashScreen extends StatefulWidget {
  static const String ID = "splash_screen";

  @override
  _State createState() => _State();
}

class _State extends State<SplashScreen> {
  SplashScreenBloc? splashScreenBloc;

  // Uri _initialUri;
  // Uri _latestUri;
  // Object _err;

  // StreamSubscription _sub;
  final _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    splashScreenBloc = BlocProvider.of<SplashScreenBloc>(context)
      ..refreshToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // var queryData = MediaQuery.of(context);
    // // FlavorConfig.instance.values.devicePixelRatio = queryData.devicePixelRatio;
    // ScreenUtil()
    // ScreenUtil.init(
    //     BoxConstraints(
    //         maxWidth: Dimens.screenWidth(context),
    //         maxHeight: Dimens.screenHeight(context)),
    //     orientation: Orientation.portrait);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image(
                  image: AssetImage(
                    'assets/logo-koffie.png',
                  ),
                  width: (SizeConfig.screenWidth! * 0.5),
                ),
              ),
            ),
            BlocListener<SplashScreenBloc, SplashScreenState>(
              bloc: splashScreenBloc,
              listener: (context, state) async {
                if (state is OnSuccessRefreshToken) {
                  if (state.data.refreshed!) {
                    SessionManager().getUser().then((userValue) {
                      UserData user = userValue;
                      log("access token : " + user.accessToken);
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.ID, (route) => false);
                    });
                  } else {
                    // SessionManager().getStartupExperience().then((value) {
                    // if (value) {
                    //   Future.delayed(Duration(seconds: 1), () {
                    //     Navigator.pushNamedAndRemoveUntil(
                    //         context, LandingInitial.ID, (route) => false);
                    //   });
                    // } else {
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, EmailLogin.ID, (route) => false);
                    });
                    // }
                    // }
                    // );
                  }
                }

                if (state is OnErrorRefreshToken) {
                  /*should we add retry?*/
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, EmailLogin.ID, (route) => false);
                  });
                }

                if (state is OnProgressRefreshToken) {}
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
