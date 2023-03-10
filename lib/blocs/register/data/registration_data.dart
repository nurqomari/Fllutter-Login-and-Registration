class RegistrationData {
  bool? isRegister;
  String? responseMessage;
  Map? errorContainer;

  RegistrationData(this.isRegister, this.responseMessage, this.errorContainer);

  RegistrationData.init() {
    isRegister = false;
    responseMessage = null;
    errorContainer = null;
  }
}
