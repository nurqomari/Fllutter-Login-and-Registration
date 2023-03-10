import 'package:koffie_flutter_bdd/blocs/splashscreen/data/splash_screen_data.dart';

class SplashScreenState {
  SplashScreenState();

  factory SplashScreenState.init() => SplashScreenState();
}

class OnSuccessRefreshToken extends SplashScreenState {
  SplashScreenData data;

  OnSuccessRefreshToken(this.data);
}

class OnErrorRefreshToken extends SplashScreenState {
  String error;

  OnErrorRefreshToken(this.error);
}

class OnProgressRefreshToken extends SplashScreenState {}
