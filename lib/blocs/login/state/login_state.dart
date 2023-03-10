import 'package:koffie_flutter_bdd/blocs/login/data/login_data.dart';
import 'package:koffie_flutter_bdd/utils/error_container_handler.dart';

class LoginState {
  LoginState();

  factory LoginState.init() => LoginState();
}

class OnSuccessLogin extends LoginState {
  LoginData loginData;

  OnSuccessLogin(this.loginData);
}

class OnErrorLogin extends LoginState with ErrorContainerHandler {
  Map? errorContainer;

  OnErrorLogin(this.errorContainer);
}

class OnProgressLogin extends LoginState {}

class OnSuccessLogout extends LoginState {
  LoginData loginData;

  OnSuccessLogout(this.loginData);
}

class OnErrorLogout extends LoginState with ErrorContainerHandler {
  Map? errorContainer;

  OnErrorLogout(this.errorContainer);
}

class OnProgressLogout extends LoginState {}

class OnSuccessForgotPassword extends LoginState {
  ForgotPasswordData forgotPasswordData;

  OnSuccessForgotPassword(this.forgotPasswordData);
}

class OnErrorForgotPassword extends LoginState with ErrorContainerHandler {
  Map? errorContainer;

  OnErrorForgotPassword(this.errorContainer);
}

class OnProgressForgotPassword extends LoginState {}
