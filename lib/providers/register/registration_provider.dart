import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:koffie_flutter_bdd/constants/constants.dart';
import 'package:koffie_flutter_bdd/models/register/registration_model.dart';
import 'package:koffie_flutter_bdd/providers/api_call.dart';

class RegistrationProvider {
  // validate(email) async {
  //   var param = {"email": email};

  //   Response response = await ApiCall().postRequest(
  //       "${Constants.baseUrl}validate-email",
  //       param: json.encode(param),
  //       showResponse: true);

  //   return response;
  // }

  register(RegistrationModel registrationModel) async {
    // var params = registrationModel.toJson();
    // Dio _dio = Dio();
    // Response response = await _dio.post(
    //   "${Constants.baseUrl}/users",
    //   options: Options(headers: {
    //     HttpHeaders.contentTypeHeader: "application/json",
    //   }),
    //   data: registrationModel.toJson(),
    // );

    // Response response = await ApiCall().postRequest(
    //     "${Constants.baseUrl}/users",
    //     param: params,
    //     showResponse: true);
    /*var response = await ApiCall().postRequest(
        "${Constants.baseUrl}/${Constants.apiVersion1}/register",
        param: registrationModel.toJson(),
        showResponse: true,
        contentType: ApiCall.contentType[ContentType.json]);*/

    // return response;

    Map param = {
      "email": registrationModel.email,
      "hp": registrationModel.hp,
      "firstname": registrationModel.firstname,
      "lastname": registrationModel.lastname,
      "grup": "member",
      "role": "",
      "tgl_lahir": "1980-08-14",
      "jenis_kelamin": 1,
      "password": "Rahasia1@",
      "strict_password": "false",
      "referral_code": ""
    };
    var input = jsonEncode(param);
    var contentType = Headers.jsonContentType;

    /*var data = await ApiCall().postRequest("${Constants.baseUrl}/token", param: param,
        contentType: contentType, useToken: false, accessControlAllowOrigin: true, showResponse: true);*/

    var data = await ApiCall().postRequest("${Constants.baseUrl}/users",
        param: input,
        showResponse: true,
        accessControlAllowOrigin: true,
        contentType: contentType);

    return data;
  }

  // resendVerification(String email) async {
  //   final Map map = {"email": email};

  //   Response response = await ApiCall().postRequest(
  //       "${FlavorConfig.instance.values.baseUrl}/${Constants.apiVersion1}/activation/resend",
  //       param: jsonEncode(map),
  //       showResponse: true,
  //       contentType: Headers.jsonContentType);

  /*var response = await ApiCall().postRequest(
        "${Constants.baseUrl}/${Constants.apiVersion1}/activation/resend",
        param: jsonEncode(map),
        showResponse: true,
        contentType: ApiCall.contentType[ContentType.json]);*/

  // return response;
  // }
}
