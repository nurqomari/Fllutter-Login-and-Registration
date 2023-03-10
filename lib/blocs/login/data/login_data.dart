import 'package:koffie_flutter_bdd/models/login/user_data.dart';

class LoginData {
  bool isLogin = false;
  UserData? data;
  Map? errorContainer;

  LoginData(this.isLogin, this.data, this.errorContainer);

  LoginData.init() {
    isLogin = false;
    data = null;
    errorContainer = null;
  }

  @override
  String toString() {
    return 'LoginData{isLogin: $isLogin, data: $data, errorContainer: $errorContainer}';
  }
}

class ForgotPasswordData {
  var data;
  Map? errorContainer;

  ForgotPasswordData(this.data, this.errorContainer);

  ForgotPasswordData.init() {
    data = null;
    errorContainer = null;
  }
}
