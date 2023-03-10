import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koffie_flutter_bdd/config/routes.dart';
import 'package:koffie_flutter_bdd/screens/splashscreen/splash_screen.dart';
import 'package:get_it/get_it.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo({String? routeName, Map? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName!, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}

var locator = GetIt.instance;

void setupLocator() {
  // if (!locator.isRegistered(instanceName: "NavigationService")) {
  locator.registerLazySingleton(() => NavigationService());
  // }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'koffiesoft',
      theme: ThemeData(
        fontFamily: "Montserrat",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.ID,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
