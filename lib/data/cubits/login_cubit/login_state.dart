part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoggedIn extends LoginState {
  final MetaLoginResponse loginResponse;
  LoggedIn({required this.loginResponse});
}
