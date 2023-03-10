import 'package:koffie_flutter_bdd/models/login/user_data.dart';

class SplashScreenData {
  bool? refreshed;
  UserData? userData;
  Map? errorContainer;

  SplashScreenData(this.refreshed, this.userData, this.errorContainer);

  SplashScreenData.init() {
    refreshed = false;
    userData = null;
    errorContainer = null;
  }
}
