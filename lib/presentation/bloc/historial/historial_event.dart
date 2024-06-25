part of 'historial_bloc.dart';

abstract class HistorialEvent {}

class ConsultarHistorial extends HistorialEvent {
  final String vcFecha;
  final int vnUsuaId;

  ConsultarHistorial({required this.vcFecha, required this.vnUsuaId});
}

class LogOutHisto extends HistorialEvent {}
