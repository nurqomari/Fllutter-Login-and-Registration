import 'dart:convert';

class RegistrationModel {
  String? hp,
      grup,
      role,
      tgl_lahir,
      firstname,
      lastname,
      email,
      password,
      referral_code;
  int? jenis_kelamin;
  bool? strict_password;

  RegistrationModel();

  RegistrationModel.addAllProperties(
      this.hp,
      this.grup,
      this.role,
      this.tgl_lahir,
      this.jenis_kelamin,
      this.strict_password,
      this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.referral_code);
// {
//   "email": "nurqomari@gmail.com",
//   "hp": "0817270809",
//   "firstname": "nur",
//   "lastname": "qomari",
//   "grup": "member",
//   "role": "",
//   "tgl_lahir": "1980-08-14",
//   "jenis_kelamin": 1,
//   "password": "Rahasia1@",
//   "strict_password": false,
//   "referral_code": ""
// }
  toJson() {
    Map param = {
      'firstname': this.firstname,
      'lastname': this.lastname,
      'email': this.email,
      'password': this.password,
      'role': '',
      'grup': this.grup,
      'hp': this.hp,
      'tgl_lahir': this.tgl_lahir,
      'jenis_kelamin': this.jenis_kelamin,
      'strict_password': this.strict_password,
      'referral_code': this.referral_code
    };

    return jsonEncode(param);
  }

  validateFirstStep() {
    bool validation = true;

    if (firstname != null) validation = false;

    if (lastname != null) validation = false;

    if (email != null) validation = false;

    return validation;
  }

  validateSecondStep() {
    bool validation = true;

    if (firstname != null) validation = false;

    if (lastname != null) validation = false;

    if (email != null) validation = false;

    if (password != null) validation = false;

    return validation;
  }

  @override
  String toString() {
    return 'RegistrationModel{firstname: $firstname, lastname: $lastname, hp: $hp, email: $email, password: $password, referral_code: $referral_code,tgl_lahir:$tgl_lahir, jenis_kelamin:$jenis_kelamin,grup=$grup,role=$role,strict_password=$strict_password}';
  }
}
