part of 'venta_bloc.dart';

abstract class VentaState {}

final class VentaInitial extends VentaState {}

class LoteriaSeleccionada extends VentaState{
  List<int> voLoterias;

  LoteriaSeleccionada({required this.voLoterias});
}

class NumerosAgregados extends VentaState {
  List<Venta> voVentList;
  List<int> voLoteList;

  NumerosAgregados({required this.voVentList, required this.voLoteList});
}

class VentaConfirmada extends VentaState {}

