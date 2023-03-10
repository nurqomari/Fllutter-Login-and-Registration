import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/splashscreen/data/splash_screen_data.dart';
import 'package:koffie_flutter_bdd/blocs/splashscreen/event/splash_screen_event.dart';
import 'package:koffie_flutter_bdd/blocs/splashscreen/state/splash_screen_state.dart';
import 'package:koffie_flutter_bdd/utils/session_manager.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc(SplashScreenState initialState) : super(initialState);

  refreshToken() => add(RefreshTokenEvent());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    if (event is RefreshTokenEvent) {
      SplashScreenData result = SplashScreenData.init();
      yield OnProgressRefreshToken();

      try {
        SessionManager sessionManager = SessionManager();
        bool isLoggedIn = await sessionManager.isLoggedIn();

        if (isLoggedIn) {
          result.refreshed = true;

          yield OnSuccessRefreshToken(result);
        } else {
          log("is not refreshed", name: "SplashScreenBloc");

          result.refreshed = false;
          yield OnSuccessRefreshToken(result);
        }
      } catch (e, stackTrace) {
        log("splashscreen error : ${e.toString()}");
        result.refreshed = false;
        yield OnErrorRefreshToken(e.toString());
      }
    }
  }
}
