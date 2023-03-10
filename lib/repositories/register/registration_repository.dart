import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:koffie_flutter_bdd/blocs/register/data/registration_data.dart';
import 'package:koffie_flutter_bdd/models/register/registration_model.dart';
import 'package:koffie_flutter_bdd/providers/api_call.dart';
import 'package:koffie_flutter_bdd/providers/register/registration_provider.dart';

class RegistrationRepository {
  RegistrationProvider _provider = new RegistrationProvider();

  static const String EMAIL_VALID = "Valid", EMAIL_INVALID = "Invalid";

  // attemptValidation(email) async {
  //   var response = await _provider.validate(email);

  //   if (response is Response) {
  //     if (response.statusCode == 200) {
  //       if (response.data['status'].toString().compareTo(EMAIL_VALID) == 0) {
  //         return RegistrationValidationData(true, "");
  //       } else {
  //         if (response.data['message'][0].toString().compareTo(
  //             "SendingInvalidEmailMessage") ==
  //             0) {
  //           return RegistrationValidationData(false, "Email is not valid");
  //         }
  //         return RegistrationValidationData(false, response.data['message'][0]);
  //       }
  //     } else {
  //       return RegistrationValidationData(false, "No response from server");
  //     }
  //   } else {
  //     return RegistrationValidationData(false, response.toString());
  //   }
  // }

  attemptRegister(RegistrationModel registrationModel) async {
    var response = await _provider.register(registrationModel);

    if (response is Response) {
      if (response.statusCode == 200) {
        if (response.data['status']['kode'] == "success") {
          return RegistrationData(
              true, response.data['data']['keterangan'], null);
        } else {
          Map errorContainer = {
            "message": response.data['status']['keterangan']
          };
          // if (response.data['data'][0]
          //         .toString()
          //         .compareTo("SendingInvalidEmail") ==
          //     0) {
          //   errorContainer = {"message": "Email is not valid"};
          // }
          return RegistrationData(false, '', errorContainer);
        }
      } else {
        Map errorContainer = {"message": "No response from server."};
        return RegistrationData(false, '', errorContainer);
      }
    } else {
      Map errorContainer = {"message": response};
      return RegistrationData(false, '', errorContainer);
    }
  }

  // attemptResendVerification(String email) async {
  //   var response = await _provider.resendVerification(email);

  //   if(response is Response){
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == ApiCall.RESPONSE_SUCCESS) {
  //         return ResendVerificationData(true, "${response.data['message'][0]} ${response.data['message'][1]}", null);
  //       } else {
  //         Map errorContainer = {"message": response.data['message'][0]};
  //         return ResendVerificationData(false, '', errorContainer);
  //       }
  //     } else {
  //       Map errorContainer = {"message": "No response from server."};
  //       return ResendVerificationData(false, '', errorContainer);
  //     }
  //   }else{
  //     Map errorContainer = {"message": response};
  //     return ResendVerificationData(false, '', errorContainer);
  //   }
  // }
}
