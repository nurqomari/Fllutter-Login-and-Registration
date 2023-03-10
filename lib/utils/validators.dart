bool validateEmail(String value) {
  bool valid = true;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (!regex.hasMatch(value)) {
    valid = false;
  }
  return valid;
}

bool validatePassword(String password) {
  bool valid = true;
  RegExp regex = new RegExp(r"(?=(.*[0-9\!@#$%^&*()\\[\]{}\-_+=~`|:;<>,.\/?]))"
      '(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,20}');
  if (!regex.hasMatch(password)) {
    valid = false;
  }
  return valid;
}

bool validateUsername(String username) {
  bool valid = true;
  RegExp regex = new RegExp(r"(^([a-z]|[a-z\d]){3,20}$)");
  if (!regex.hasMatch(username)) {
    valid = false;
  }
  return valid;
}
