

import '../../../models/login_model.dart';

abstract class LoginState {
}

class InitialState extends LoginState {}
class LoginSuccessState extends LoginState {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginState {
final String error;
LoginErrorState({required this.error});
}
class LoginLoadingState extends LoginState {}

class pressLoginState extends LoginState {}
class pressSignUpState extends LoginState {}

class ChangePassVisibilityState extends LoginState {}

class SuccessGoogleToken extends LoginState {
  // final GoogleModel model;
  //
  // SuccessGoogleToken( this.model);
}

class ErrorGoogleToken extends LoginState {}

class LoadingGoogleToken extends LoginState {}

class RegisterLoadingState extends LoginState {}

class RegisterSuccessState extends LoginState {
  final LoginModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends LoginState {
  //34an azhero 3ala el screen
  final String error;

  RegisterErrorState(this.error);
}


class LoadingSignInGoogle extends LoginState {}
class SuccessSignInGoogle extends LoginState {
  final LoginModel loginModel;
  SuccessSignInGoogle(this.loginModel);
}
class ErrorSignInGoogle extends LoginState {
  final String error;
  ErrorSignInGoogle({required this.error});
}