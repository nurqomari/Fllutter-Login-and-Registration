import 'dart:convert';

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
    Response response = await ApiCall().postRequest("${Constants.baseUrl}/user",
        param: registrationModel.toJson(), showResponse: true);
    /*var response = await ApiCall().postRequest(
        "${Constants.baseUrl}/${Constants.apiVersion1}/register",
        param: registrationModel.toJson(),
        showResponse: true,
        contentType: ApiCall.contentType[ContentType.json]);*/

    return response;
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
