part of 'bloqueo_bloc.dart';

abstract class BloqueoEvent {}

class ObtenerBloqueos extends BloqueoEvent {
  final String vcFecha;

  ObtenerBloqueos({required this.vcFecha});
}
