import 'dart:convert';

class UserData {
  late String accessToken,
      tokenType,
      // refreshToken,
      // name,
      firstname,
      lastname,
      hp,
      email;
  // phoneNumber,
  // identifier,
  // photoUrl,
  // language,
  // issued,
  // expires,
  // referralCode;
  // int? expiresIn;

  UserData([
    this.accessToken = "",
    this.tokenType = "",
    // this.refreshToken = "",
    // this.name = "",
    this.firstname = "",
    this.lastname = "",
    this.hp = "",
    this.email = "",
    // this.phoneNumber = "",
    // this.identifier = "",
    // this.photoUrl = "",
    // this.language = "",
    // this.issued = "",
    // this.expires = "",
    // this.expiresIn,
    // this.referralCode = ""
  ]);

  UserData.fillUserIdentity(this.firstname, this.lastname, this.hp, this.email);

  UserData.fromJson(jsonData) {
    accessToken = jsonData['access_token'] as String;
    tokenType = jsonData['token_type'] as String;
    // expiresIn = jsonData['expires_in'] as int;
    // refreshToken = jsonData['refresh_token'] as String;
    // name = jsonData['name'] as String;
    firstname = jsonData['data']['firstname'] as String;
    lastname = jsonData['data']['lastname'] as String;
    hp = jsonData['data']['hp'] as String;
    email = jsonData['data']['email'] as String;
    // phoneNumber = jsonData['phone_number'] as String;
    // photoUrl = jsonData['photo_url'] as String;
    // identifier = jsonData['identifier'] as String;
    // language = jsonData['language'] as String;
    // issued = jsonData['.issued'] as String;
    // expires = jsonData['.expires'] as String;
    // if (jsonData['referral_code'] != null) {
    //   referralCode = jsonData['referral_code'] as String;
    // }
  }

  UserData.fromSession(jsonData) {
    accessToken = jsonData['access_token'] as String;
    tokenType = jsonData['token_type'] as String;
    // expiresIn = jsonData['expires_in'] as int;
    // refreshToken = jsonData['refresh_token'] as String;
    // name = jsonData['name'] as String;
    firstname = jsonData['firstname'] as String;
    lastname = jsonData['lastname'] as String;
    hp = jsonData['hp'] as String;
    email = jsonData['email'] as String;
    // phoneNumber = jsonData['phone_number'] as String;
    // photoUrl = jsonData['photo_url'] as String;
    // identifier = jsonData['identifier'] as String;
    // language = jsonData['language'] as String;
    // issued = jsonData['.issued'] as String;
    // expires = jsonData['.expires'] as String;
    // if (jsonData['referral_code'] != null) {
    //   referralCode = jsonData['referral_code'] as String;
    // }
  }

  toJson() {
    return json.encode({
      "access_token": accessToken,
      "token_type": tokenType,
      // "expires_in": expiresIn,
      // "refreshToken": refreshToken,
      // "name": name,
      "firstname": firstname,
      "lastname": lastname,
      "hp": hp,
      "email": email,
      // "phone_number": phoneNumber,
      // "photo_url": photoUrl,
      // "identifier": identifier,
      // "language": language,
      // ".issued": issued,
      // ".expires": expires,
      // "referral_code": referralCode
    });
  }

  populateFromJson(Map jsonData) {
    accessToken = jsonData['access_token'] as String;
    tokenType = jsonData['token_type'] as String;
    // expiresIn = jsonData['expires_in'] as int;
    // refreshToken = jsonData['refresh_token'] as String;
    // name = jsonData['data']['name'] as String;
    firstname = jsonData['data']['firstname'] as String;
    lastname = jsonData['data']['lastname'] as String;
    hp = jsonData['data']['username'] as String;
    email = jsonData['data']['email'] as String;
    // phoneNumber = jsonData['phone_number'] as String;
    // photoUrl = jsonData['photo_url'] as String;
    // identifier = jsonData['identifier'] as String;
    // language = jsonData['language'] as String;
    // issued = jsonData['.issued'] as String;
    // expires = jsonData['.expires'] as String;
    // if (jsonData['referral_code'] != null) {
    //   referralCode = jsonData['referral_code'] as String;
    // }
  }

  @override
  String toString() {
    return 'UserData{tokenType: $tokenType, firstname: $firstname, lastname: $lastname, hp: $hp, email: $email}';
  }
}
