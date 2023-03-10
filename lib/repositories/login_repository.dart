import 'package:dio/dio.dart';
import 'package:koffie_flutter_bdd/blocs/login/data/login_data.dart';
import 'package:koffie_flutter_bdd/blocs/login/login_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/splashscreen/data/splash_screen_data.dart';
import 'package:koffie_flutter_bdd/models/login/user_data.dart';
import 'package:koffie_flutter_bdd/providers/api_call.dart';
import 'package:koffie_flutter_bdd/providers/login/login_provider.dart';

class LoginRepository {
  final provider = LoginProvider();

  attemptLogin(String email, String password) async {
    var response = await provider.login(email, password);
    LoginData loginData = LoginData.init();

    if (response is Response) {
      if (response.statusCode == 200) {
        if (response.data['access_token'] != null) {
          loginData.isLogin = true;
          loginData.data = UserData.fromJson(response.data);
        } else {
          loginData.isLogin = false;
          loginData.errorContainer = {
            "message": response.data['error_description']
          };
        }
      } else {
        loginData.isLogin = false;
        loginData.errorContainer = {
          "message": response.data['error_description']
        };
      }
    } else {
      loginData.isLogin = false;
      loginData.errorContainer = {"message": response};
    }
    return loginData;
  }

  attemptRefreshToken(String refreshToken) async {
    var response = await provider.refreshToken(refreshToken);
    SplashScreenData splashScreenData = SplashScreenData.init();

    if (response is Response) {
      if (response.statusCode == 200) {
        splashScreenData.refreshed = true;
        splashScreenData.userData = UserData.fromJson(response.data);
      } else {
        splashScreenData.refreshed = false;
        splashScreenData.errorContainer = {
          "message": "No response form server"
        };
      }
    } else {
      splashScreenData.refreshed = false;
      splashScreenData.errorContainer = {"message": response};
    }
    return splashScreenData;
  }

  attemptLogout() async {
    LoginData loginData = LoginData.init();

    var response = await provider.logout();

    if (response is Response) {
      if (response.statusCode == 200) {
        if (response.data['status'] == ApiCall.RESPONSE_SUCCESS) {
          loginData.isLogin = false;
        } else {
          loginData.errorContainer = {"message": response.data['message']};
          loginData.isLogin = true;
        }
      } else {
        loginData.errorContainer = {"message": "No response form server"};
        loginData.isLogin = true;
      }
    } else {
      loginData.errorContainer = {"message": response};
      loginData.isLogin = true;
    }
    return loginData;
  }

  forgotPassword(String email) async {
    ForgotPasswordData data = ForgotPasswordData.init();

    var response = await provider.forgotPassword(email);

    if (response is Response) {
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == ApiCall.RESPONSE_SUCCESS) {
          data.data = {"isValid": true, "message": responseData['message']};
        } else {
          data.errorContainer = {
            "message": responseData['message'][0],
            "type": LoginErrorType.emailError
          };
        }
      } else {
        data.errorContainer = {"message": "No response form server"};
      }
    } else {
      data.errorContainer = {"message": response.toString()};
    }

    return data;
  }
}
