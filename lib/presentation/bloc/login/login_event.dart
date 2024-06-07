part of 'login_bloc.dart';


abstract class LoginEvent {}

class LoginPress extends LoginEvent {
  final String vcUser;
  final String vcPass;

  LoginPress({required this.vcUser, required this.vcPass});
}

