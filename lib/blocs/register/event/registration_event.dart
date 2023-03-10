import 'package:equatable/equatable.dart';
import 'package:koffie_flutter_bdd/models/register/registration_model.dart';

class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AttemptRegisterEvent extends RegistrationEvent {
  RegistrationModel registrationModel;

  AttemptRegisterEvent(this.registrationModel);
}

class ValidateRegistrationEvent extends RegistrationEvent {
  String email;

  ValidateRegistrationEvent(this.email);
}
