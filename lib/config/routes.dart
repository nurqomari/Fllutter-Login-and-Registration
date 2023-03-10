import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/login/login_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/login/state/login_state.dart';
import 'package:koffie_flutter_bdd/blocs/register/registration_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/register/state/registration_state.dart';
import 'package:koffie_flutter_bdd/blocs/splashscreen/splash_screen_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/splashscreen/state/splash_screen_state.dart';
import 'package:koffie_flutter_bdd/screens/home_screen.dart';
import 'package:koffie_flutter_bdd/screens/login/email_login.dart';
import 'package:koffie_flutter_bdd/screens/register/register_step_one.dart';
import 'package:koffie_flutter_bdd/screens/register/register_step_two.dart';
import 'package:koffie_flutter_bdd/screens/splashscreen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    // BottomBarConfig();

    switch (settings.name) {
      case SplashScreen.ID:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SplashScreenBloc(
              SplashScreenState.init(),
            ),
            child: SplashScreen(),
          ),
        );

      // case MainLogin.ID:
      //   return MaterialPageRoute(
      //     builder: (context) => MainLogin(),
      //   );
      case EmailLogin.ID:
        // if (args is Origin) {
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(
              LoginState.init(),
            ),
            child: EmailLogin(),
          ),
        );

      case HomeScreen.ID:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LoginBloc(
                    LoginState.init(),
                  ),
                  child: HomeScreen(),
                ));

      case RegisterStepOne.ID:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => RegistrationBloc(
                    RegistrationState.init(),
                  ),
                  child: RegisterStepOne(),
                ));

      case RegisterStepTwo.ID:
        if (args is Map) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => RegistrationBloc(
                RegistrationState.init(),
              ),
              child: RegisterStepTwo(args['registrationModel']),
            ),
          );
        }
        return null;
      // case RegisterFinalStep.ID:
      /*return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ResendVerificationBloc(
              ResendVerificationState.init(),
            ),
            child: RegisterFinalStep("tridarid@gmail.com"),
          ),
        );*/
      // if (args is Map)
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) => ResendVerificationBloc(
      //         ResendVerificationState.init(),
      //       ),
      //       child: RegisterFinalStep(args['email'],args['message']),
      //     ),
      //   );
      // return null;
      default:
        return null;
    }
  }
}
