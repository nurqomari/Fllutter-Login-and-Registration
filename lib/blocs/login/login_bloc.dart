import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/login/data/login_data.dart';
import 'package:koffie_flutter_bdd/blocs/login/event/login_event.dart';
import 'package:koffie_flutter_bdd/blocs/login/state/login_state.dart';
import 'package:koffie_flutter_bdd/constants/strings.dart';
import 'package:koffie_flutter_bdd/repositories/login_repository.dart';
import 'package:koffie_flutter_bdd/utils/session_manager.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sb_bloc/blocs/login/data/LoginData.dart';
// import 'package:sb_bloc/blocs/login/event/LoginEvent.dart';
// import 'package:sb_bloc/blocs/login/state/LoginState.dart';
// import 'package:sb_bloc/constants/Strings.dart';
// import 'package:sb_bloc/providers/fcm/FCMProvider.dart';
// import 'package:sb_bloc/repositories/login/LoginRepository.dart';
// import 'package:sb_bloc/utils/Logger.dart';
// import 'package:sb_bloc/utils/SessionManager.dart';
// import 'package:sb_bloc/utils/SocialLoginService.dart';

enum LoginErrorType { emailError, passwordError }

class LoginRetry {
  int _retriesLeft = 5;
  String _previousEmail = "";
  SessionManager sessionManager = SessionManager();

  static LoginRetry instance = LoginRetry._();

  factory LoginRetry() {
    return instance;
  }

  LoginRetry._() {
    _init();
  }

  _init() async {
    sessionManager = SessionManager();
    _retriesLeft = 0;
    //await sessionManager.getRetryCount();
    _previousEmail = "";
    //await sessionManager.getPreviousEmail();
  }

  substractRetries() {
    sessionManager = SessionManager();
    _retriesLeft--;
    sessionManager.setRetryCount(_retriesLeft);
    log("retries substracted : ${_retriesLeft.toString()}");
  }

  resetRetries() {
    sessionManager = SessionManager();
    _retriesLeft = 5;
    sessionManager.setRetryCount(5);
    log("retries resetted : ${_retriesLeft.toString()}");
  }

  int get retriesLeft => _retriesLeft;

  setPreviousEmail(String prevEmail) {
    sessionManager = SessionManager();
    _previousEmail = prevEmail;
    sessionManager.setPreviousEmail(_previousEmail);
    log("previous email set : $_previousEmail");
  }

  String get prevEmail => _previousEmail;
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRetry? loginRetry;

  LoginBloc(LoginState initialState) : super(initialState) {
    loginRetry = LoginRetry();
  }

  attemptLogin(String email, String password) =>
      add(AttemptLoginEvent(email, password));

  attemptSocialLogin(SocialProvider provider) =>
      add(AttemptSocialLoginEvent(provider));

  attemptLogout() => add(AttemptLogoutEvent());

  forgotPassword(String email) => add(ForgotPasswordEvent(email));

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AttemptLoginEvent) {
      LoginData result = LoginData.init();
      bool valid = true;

      if (event.email.isEmpty) {
        result.errorContainer = {"message": Strings.loginEmailRequired};
        valid = false;
      }

      if (event.email.isNotEmpty && !isEmailValid(event.email)) {
        result.errorContainer = {
          "message":
              "Email format is incorrect. Please check the email address and try again"
        };
        valid = false;
      }

      if (event.password.isEmpty) {
        result.errorContainer = {"message": Strings.loginPasswordRequired};
        valid = false;
      }

      if (valid) {
        yield OnProgressLogin();

        // if (loginRetry.prevEmail.isEmpty) {
        //   log("same email");
        //   loginRetry.setPreviousEmail(event.email);
        // } else {
        //   log("different email");
        //   if (loginRetry.prevEmail.compareTo(event.email) != 0) {
        //     loginRetry.setPreviousEmail(event.email);
        //     loginRetry.resetRetries();
        //   }
        // }

        LoginRepository repository = LoginRepository();
        LoginData response =
            await repository.attemptLogin(event.email, event.password);

        if (response.isLogin) {
          String _token;
          Stream<String> _tokenStream;

          SessionManager session = new SessionManager();
          // print("firebasetoken: " + _token.toString());

          // void setToken(String token) {
          //   print('FCM Token: $token');
          //   _token = token;
          //   session.setFcmToken(token);
          //   FCMProvider().saveFcmTokenInServer(token);
          // }

          // if (_token == null) {
          //   FirebaseMessaging.instance
          //       .getToken(
          //           vapidKey:
          //               'BE0LhXar9c0R6qp7bQNVwg1ca1DeTehpxf_R9jrjtRSAnEcupHS80-vw2-_XHmq7kcoGihdRxQZ0K7cWTNIfJco')
          //       .then(setToken);
          //   _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
          //   _tokenStream.listen(setToken);
          // }

          loginRetry?.resetRetries();
          result = LoginData(response.isLogin, response.data, null);
          SessionManager sessionManager = SessionManager();
          await sessionManager.setUser(response.data!);
          yield OnSuccessLogin(result);
        } else {
          // Logger()
          //     .log("error : ${response.errorContainer['message']}", name: "LoginError");
          if (response.errorContainer?['message']
                  .toString()
                  .compareTo(Strings.loginEmailDoesNotExist) ==
              0) {
            loginRetry?.resetRetries();

            result.errorContainer = {
              "message": Strings.loginEmailDoesNotExist,
              "type": LoginErrorType.emailError
            };
          } else if (response.errorContainer?['message']
                  .toString()
                  .compareTo(Strings.loginAccountNotActive) ==
              0) {
            loginRetry?.resetRetries();

            result.errorContainer = {
              "message": Strings.loginAccountNotActiveAlt,
              "type": LoginErrorType.emailError
            };
          }
          // else if (response.errorContainer['message']
          //     .toString()
          //     .contains(Strings.loginAccountLocked)) {
          //   loginRetry?.resetRetries();

          //   result.errorContainer = {
          //     "message": response.errorContainer['message'],
          //     "type": LoginErrorType.emailError
          //   };
          // }
          else if (response.errorContainer?['message']
                  .toString()
                  .compareTo(Strings.loginPasswordInvalid) ==
              0) {
            result.errorContainer = {
              "message":
                  "${Strings.loginPasswordInvalid}. You have ${loginRetry?.retriesLeft.toString()} retry left",
              "type": LoginErrorType.passwordError
            };

            loginRetry?.substractRetries();
          } else if (response.errorContainer?['message']
                  .toString()
                  .compareTo(Strings.loginAccountDeleted) ==
              0) {
            result.errorContainer = {
              "message": response.errorContainer?['message'],
              "type": LoginErrorType.emailError
            };
          }

          yield OnErrorLogin(result.errorContainer);
        }
      } else {
        yield OnErrorLogin(result.errorContainer);
      }
    }

    // if (event is AttemptSocialLoginEvent) {
    //   LoginData result = LoginData.init();

    //   yield OnProgressLogin();

    //   if (event.provider == SocialProvider.facebook) {
    //     result = await SocialLoginService().signInWithFacebook();
    //   }

    //   if (event.provider == SocialProvider.google) {
    //     result = await SocialLoginService().signInWithGoogle();
    //   }

    //   if (result.isLogin) {
    //     String _token;
    //     Stream<String> _tokenStream;

    //     SessionManager session = new SessionManager();
    //     print("firebasetoken: " + _token.toString());

    //     void setToken(String token) {
    //       print('FCM Token: $token');
    //       _token = token;
    //       session.setFcmToken(token);
    //       FCMProvider().saveFcmTokenInServer(token);
    //     }

    //     if (_token == null) {
    //       FirebaseMessaging.instance
    //           .getToken(
    //               vapidKey:
    //                   'BE0LhXar9c0R6qp7bQNVwg1ca1DeTehpxf_R9jrjtRSAnEcupHS80-vw2-_XHmq7kcoGihdRxQZ0K7cWTNIfJco')
    //           .then(setToken);
    //       _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    //       _tokenStream.listen(setToken);
    //     }

    //     SessionManager sessionManager = SessionManager();
    //     sessionManager.setUser(result.data);

    //     yield OnSuccessLogin(result);
    //   } else {
    //     yield OnErrorLogin(result.errorContainer);
    //   }
    // }

    if (event is AttemptLogoutEvent) {
      LoginData result = LoginData.init();

      yield OnProgressLogout();

      // LoginRepository repository = LoginRepository();
      // result = await repository.attemptLogout();
      try {
        SessionManager sessionManager = SessionManager();
        bool isLoggedIn = await sessionManager.isLoggedIn();
        if (isLoggedIn) {
          await sessionManager.logout();
          yield OnSuccessLogout(result);
        }
      } catch (e, stackTrace) {
        yield OnErrorLogout(result.errorContainer);
      }
    }

    if (event is ForgotPasswordEvent) {
      ForgotPasswordData result = ForgotPasswordData.init();
      yield OnProgressForgotPassword();

      result = await LoginRepository().forgotPassword(event.email);

      if (result.errorContainer == null) {
        yield OnSuccessForgotPassword(result);
      } else {
        yield OnErrorForgotPassword(result.errorContainer);
      }
    }
  }

  bool isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
