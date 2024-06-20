part of 'venta_bloc.dart';

abstract class VentaState {}

final class VentaInitial extends VentaState {}

class LoteriaSeleccionada extends VentaState{
  List<Loteria> voLoterias;

  LoteriaSeleccionada({required this.voLoterias});
}

class NumerosAAgregar extends VentaState {
  List<Venta> voVentList;
  List<Loteria> voLoteList;
  int vnPagoTota;
  NumerosAAgregar({required this.voVentList, required this.voLoteList, required this.vnPagoTota});
}

class VentaConfirmada extends VentaState {
  String vcMensaje;

  VentaConfirmada({required this.vcMensaje});
}

class VentaError extends VentaState {
  String vcMensaje;

  VentaError({required this.vcMensaje});
}

class VentaLoading extends VentaState {}