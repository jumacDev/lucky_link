part of 'login_bloc.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginOk extends LoginState{
  final Sesion voSesion;

  LoginOk({required this.voSesion});

}

class LoginError extends LoginState{
  final String vcMensaje;

  LoginError({required this.vcMensaje});
}

