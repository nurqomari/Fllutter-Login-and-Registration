import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koffie_flutter_bdd/blocs/register/data/registration_data.dart';
import 'package:koffie_flutter_bdd/blocs/register/event/registration_event.dart';
import 'package:koffie_flutter_bdd/blocs/register/state/registration_state.dart';
import 'package:koffie_flutter_bdd/repositories/register/registration_repository.dart';
import 'package:koffie_flutter_bdd/utils/session_manager.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(RegistrationState initialState) : super(initialState);

  attemptRegister(registrationModel) =>
      add(AttemptRegisterEvent(registrationModel));

  validateRegistrationData(email) => add(ValidateRegistrationEvent(email));

  var repository = RegistrationRepository();

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is AttemptRegisterEvent) {
      RegistrationData result;

      result = RegistrationData.init();

      yield OnProgressRegistration();

      var repository = new RegistrationRepository();
      RegistrationData response =
          await repository.attemptRegister(event.registrationModel);
      result = response;
      if (result.isRegister!) {
        result.isRegister = true;
        SessionManager sessionManager = new SessionManager();
        sessionManager.setRegistrationData(event.registrationModel.firstname!,
            event.registrationModel.lastname!, event.registrationModel.email!);
        yield OnSuccessRegistration(result);
      } else {
        yield OnErrorRegistration(result.errorContainer!);
      }
    }
  }
}
