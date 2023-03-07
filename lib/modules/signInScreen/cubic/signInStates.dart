
abstract class SignInStates {}

class SignInIntilState extends SignInStates {}

class SignInSucessState extends SignInStates {}

class SignInErrorState extends SignInStates {}

class SignInLoadingState extends SignInStates {}


class SucessCreateUserState extends SignInStates {
  String? id ;
  SucessCreateUserState(this.id);
}

class ErrorCreateUserState extends SignInStates {}

class LoadingCreateUserState extends SignInStates {}

class ChangePasswordSignInVisibilityState extends SignInStates{}