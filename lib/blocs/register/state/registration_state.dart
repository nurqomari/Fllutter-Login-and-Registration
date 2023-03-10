import 'package:koffie_flutter_bdd/blocs/register/data/registration_data.dart';

class RegistrationState {
  RegistrationState();

  factory RegistrationState.init() => OnInitRegistration();
}

class OnInitRegistration extends RegistrationState {}

class OnSuccessRegistration extends RegistrationState {
  RegistrationData data;

  OnSuccessRegistration(this.data);
}

class OnErrorRegistration extends RegistrationState {
  Map errorContainer;

  OnErrorRegistration(this.errorContainer);
}

class OnProgressRegistration extends RegistrationState {}

class OnSuccessRegistrationValidation extends RegistrationState {}

class OnErrorRegistrationValidation extends RegistrationState {
  Map errorContainer;

  OnErrorRegistrationValidation(this.errorContainer);
}

class OnProgressRegistrationValidation extends RegistrationState {}
