part of 'bloqueo_bloc.dart';

abstract class BloqueoState {}

final class BloqueoInitial extends BloqueoState {}

class BloqueoOk extends BloqueoState {
  List<Bloqueo> voListBloq;

  BloqueoOk({this.voListBloq = const []});
}

class BloqueoError extends BloqueoState{
  final String vcMensaje;

  BloqueoError({required this.vcMensaje});
}