part of 'loteria_bloc.dart';

abstract class LoteriaState {}

final class LoteriaInitial extends LoteriaState {}

class LoteriasOk extends LoteriaState{
  final List<Loteria> voListLote;

  LoteriasOk({required this.voListLote});
}

class LoteriasError extends LoteriaState{
  final String vcMensaje;

  LoteriasError({required this.vcMensaje});

}