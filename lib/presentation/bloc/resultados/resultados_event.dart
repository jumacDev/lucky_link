part of 'resultados_bloc.dart';

abstract class ResultadosEvent {}


class TraerResultadosEvent extends ResultadosEvent{
  String vcFecha;

  TraerResultadosEvent(this.vcFecha);
}

