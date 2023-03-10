import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:koffie_flutter_bdd/constants/constants.dart';
import 'package:koffie_flutter_bdd/providers/api_call.dart';
// import 'package:sb_bloc/config/FlavorConfig.dart';
// import 'package:sb_bloc/constants/Constants.dart';
// import 'package:sb_bloc/providers/ApiCall.dart';

class LoginProvider {
  login(String email, String password) async {
    var param = {
      // 'grant_type': 'password',
      'username': email,
      'password': password,
      // 'client_id': '64001261-259A-4BB9-A60E-2179DF74FC58'
    };
    var contentType = Headers.formUrlEncodedContentType;

    /*var data = await ApiCall().postRequest("${Constants.baseUrl}/token", param: param,
        contentType: contentType, useToken: false, accessControlAllowOrigin: true, showResponse: true);*/

    var data = await ApiCall().postRequest("${Constants.baseUrl}/login",
        param: param,
        showResponse: true,
        accessControlAllowOrigin: true,
        contentType: ApiCall.contentType[ContentType.formUrlEncoded]);

    return data;
  }

  refreshToken(String refreshToken) async {
    var param = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': '64001261-259A-4BB9-A60E-2179DF74FC58'
    };

    var contentType = Headers.formUrlEncodedContentType;

    Response data = await ApiCall().postRequest("${Constants.baseUrl}/token",
        param: param, contentType: contentType, showResponse: true);

    /*Response data = await ApiCall().postRequest("${Constants.baseUrl}/token",
        param: param,
        showResponse: true,
        contentType: ApiCall.contentType[ContentType.formUrlEncoded]);*/

    return data;
  }

  logout() async {
    var contentType = Headers.jsonContentType;

    Response data = await ApiCall().postRequest("${Constants.baseUrl}/logout",
        contentType: contentType, useToken: true);

    /*Response data = await ApiCall().postRequest(
        "${Constants.baseUrl}/${Constants.apiVersion1}/account/logout",
        useToken: true,
        showResponse: true,
        contentType: ApiCall.contentType[ContentType.formUrlEncoded]);*/

    return data;
  }

  forgotPassword(String email) async {
    var contentType = Headers.jsonContentType;

    Map mapParam = {"email": email};

    String jsonParam = jsonEncode(mapParam);
    var data = await ApiCall().postRequest(
        "${Constants.baseUrl}/v.1/reset-password",
        param: jsonParam,
        contentType: contentType,
        showResponse: true);

    /*var data = await ApiCall().postRequest(
        "${Constants.baseUrl}/${Constants.apiVersion1}/account/logout",
        useToken: true,
        showResponse: true,
        contentType: ApiCall.contentType[ContentType.json]);*/

    return data;
  }
}
