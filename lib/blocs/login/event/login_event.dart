enum SocialProvider {
	google, facebook
}

class LoginEvent{

}

class AttemptLoginEvent extends LoginEvent{
	final String email, password;

	AttemptLoginEvent(this.email, this.password);
}

class AttemptSocialLoginEvent extends LoginEvent{
	final SocialProvider provider;

	AttemptSocialLoginEvent(this.provider);
}

class AttemptLogoutEvent extends LoginEvent{
	AttemptLogoutEvent();
}

class ForgotPasswordEvent extends LoginEvent{
	final String email;
	ForgotPasswordEvent(this.email);
}