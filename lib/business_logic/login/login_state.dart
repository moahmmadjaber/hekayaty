part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

 class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginError extends LoginState {
  final ErrorModel err;
  LoginError(this.err);

}
class LoginComplete extends LoginState {
  final LoginModel token ;
  LoginComplete(this.token,);
}