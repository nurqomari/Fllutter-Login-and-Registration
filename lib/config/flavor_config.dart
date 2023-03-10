import 'package:flutter/cupertino.dart';

enum Flavor { dev, devNoKey, acc, prod }

class FlavorValues {
  final String? baseUrl;
  double? devicePixelRatio;
  final bool hideKeyboard;

  FlavorValues(
      {@required this.baseUrl,
      this.devicePixelRatio,
      this.hideKeyboard = false});
}

class FlavorConfig {
  Flavor flavor = Flavor.dev;
  final String name;
  final FlavorValues values;

  FlavorConfig? _instance;

  FlavorConfig.fill(this.flavor, this.name, this.values);

  // factory FlavorConfig(
  //     {@required Flavor flavor, @required FlavorValues values}) {
  //   _instance ??= FlavorConfig._internal(flavor, flavor.toString(), values);
  //   return _instance;
  // }

  // static FlavorConfig get instance {
  //   return _instance;
  // }

  // static bool isProd() => _instance?.flavor == Flavor.prod;

  // static bool isDev() => _instance?.flavor == Flavor.dev;

  // static bool isAcc() => _instance?.flavor == Flavor.acc;

  // static bool isDevNoKey() => _instance?.flavor == Flavor.devNoKey;
}
