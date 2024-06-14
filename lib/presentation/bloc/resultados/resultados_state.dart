part of 'resultados_bloc.dart';

abstract class ResultadosState {}

final class ResultadosInitial extends ResultadosState {}

class ResultadosLoading extends ResultadosState {}


class ResultadosOk extends ResultadosState{
  final List<Resultado> voResuList;
  final String vcMensaje;

  ResultadosOk({required this.voResuList, required this.vcMensaje});

}

class ResultadosError extends ResultadosState{
  final String vcMensaje;

  ResultadosError({required this.vcMensaje});
}

