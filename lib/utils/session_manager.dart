import 'dart:convert';

import 'package:koffie_flutter_bdd/models/login/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String KEY_USER_DATA_CORE = "core_user_data";
  static const String KEY_USER_DATA_EXTENDED = "extended_user_data";

  static const String KEY_ACCESS_TOKEN = "access_token";
  static const String KEY_TOKEN_TYPE = "token_type";
  static const String KEY_EXPIRES_IN = "expires_in";
  static const String KEY_REFRESH_TOKEN = "refresh_token";
  static const String KEY_NAME = "name";
  static const String KEY_FIRST_NAME = "firstname";
  static const String KEY_LAST_NAME = "lastname";
  static const String KEY_USER_NAME = "username";
  static const String KEY_EMAIL = "email";
  static const String KEY_PHONE_NUMBER = "hp";
  static const String KEY_PHOTO_URL = "photo_url";
  static const String KEY_IDENTIFIER = "identifier";
  static const String KEY_LANGUAGE = "language";
  static const String KEY_ISSUED = ".issued";
  static const String KEY_EXPIRES = ".expires";
  static const String KEY_REFERAL_CODE = "referral_code";
  static const String KEY_ID = "id";
  static const String KEY_BIRTHDAY = "birthday";
  static const String KEY_BACKGROUND_ID = "background_id";

  static const String KEY_FCM_TOKEN = "fcm_token";

  static const String KEY_IS_LOGGED_IN = "is_logged_in";

  static const String KEY_IS_FIRST_STARTUP = "is_first_start";

  static const String KEY_USER_LOCATION_PREFERENCE = "user_location_preference";
  static const String KEY_USER_ADDRESS_PREFERENCE = "user_address_preference";
  static const String KEY_USER_ZIPCODE_PREFERENCE = "user_zipcode_preference";
  static const String KEY_USER_CITY_PREFERENCE = "user_city_preference";
  static const String KEY_USER_LATITUDE_PREFERENCE = "user_latitude_preference";
  static const String KEY_USER_LONGITUDE_PREFERENCE =
      "user_longitude_preference";

  static const String KEY_REGISRATION_FIRST_NAME = "firstname";
  static const String KEY_REGISRATION_LAST_NAME = "lastname";
  static const String KEY_REGISRATION_EMAIL = "email";

  static const String KEY_RETRY_COUNT = "retry_count";
  static const String KEY_PREVIOUS_EMAIL = "prev_email";

  static const String KEY_SHOPPING_CART_ITEMS = "shopping_cart_items";
  static const String KEY_DELIVERY_OPTION = "delivery_option";

  static const String KEY_CURRENT_ORDER = "current_order";

  setUser(UserData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_USER_DATA_CORE, data.toJson());
    // await prefs.setString(KEY_REFERAL_CODE, data.referralCode);
    await prefs.setBool(KEY_IS_LOGGED_IN, true);
  }

  Future<UserData> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData data =
        UserData.fromSession(json.decode(prefs.getString(KEY_USER_DATA_CORE)!));
    return data;
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(KEY_IS_LOGGED_IN);
    prefs.remove(KEY_USER_DATA_CORE);
    prefs.remove(KEY_USER_DATA_EXTENDED);
    prefs.remove(KEY_REGISRATION_FIRST_NAME);
    prefs.remove(KEY_REGISRATION_LAST_NAME);
    prefs.remove(KEY_REGISRATION_EMAIL);
    prefs.remove(KEY_RETRY_COUNT);
    prefs.remove(KEY_PREVIOUS_EMAIL);
    prefs.remove(KEY_SHOPPING_CART_ITEMS);
    prefs.remove(KEY_DELIVERY_OPTION);
    prefs.remove(KEY_CURRENT_ORDER);

    return true;
  }

  isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_IS_LOGGED_IN) ?? false;
  }

  ///to update profile picture
  updateProfilePicture(photoUrl) async {
    UserData userData = await getUser();
    // userData.photoUrl = photoUrl;
    await setUser(userData);
  }

  void setRegistrationData(
      String firstName, String lastName, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_REGISRATION_FIRST_NAME, firstName);
    await prefs.setString(KEY_REGISRATION_LAST_NAME, lastName);
    await prefs.setString(KEY_REGISRATION_EMAIL, email);
  }

  void setRetryCount(retryCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(KEY_RETRY_COUNT, retryCount);
  }

  getRetryCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int retryCount = 5; //await prefs.getInt(KEY_RETRY_COUNT)!;
    return retryCount;
  }

  setPreviousEmail(previousEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_PREVIOUS_EMAIL, previousEmail);
  }

  getPreviousEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String previousEmail = ""; //await prefs.getString(KEY_PREVIOUS_EMAIL)!;
    return previousEmail;
  }

  Future<String> getReferalCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String referalCode = prefs.getString(KEY_REFERAL_CODE)!;
    return referalCode;
  }
}
