part of 'venta_bloc.dart';

abstract class VentaEvent {}

class AgregarLoteria extends VentaEvent{
  List<int> voLoterias;

  AgregarLoteria({required this.voLoterias});
}

class Atras extends VentaEvent {}

class AgregarNumero extends VentaEvent {
  List<Venta> voVentList;
  List<int> voLoteList;

  AgregarNumero({required this.voVentList, required this.voLoteList});
}