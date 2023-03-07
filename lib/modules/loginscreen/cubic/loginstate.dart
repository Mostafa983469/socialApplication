
abstract class LoginStates {}

class IntilState extends LoginStates {}

class LoginSucessState extends LoginStates {
  String? id;
  LoginSucessState(this.id);
}

class LoginErrorState extends LoginStates {}

class loadingState extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates{}