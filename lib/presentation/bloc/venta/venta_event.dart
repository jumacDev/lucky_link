part of 'venta_bloc.dart';

abstract class VentaEvent {}

class AgregarLoteria extends VentaEvent{
  List<Loteria> voLoterias;

  AgregarLoteria({required this.voLoterias});
}

class Atras extends VentaEvent {}

class Atras2 extends VentaEvent {
  List<Loteria> voLoterias;

  Atras2({required this.voLoterias});
}

class AgregarNumero extends VentaEvent {
  List<Venta> voVentList;
  List<Loteria> voLoteList;
  int vnPagoTota;
  AgregarNumero({required this.voVentList, required this.voLoteList, required this.vnPagoTota});
}

class EnviarVenta extends VentaEvent {
  List<Venta> voVentList;
  int pnUsuaId;

  EnviarVenta({required this.voVentList, required this.pnUsuaId});
}

class LogOutVenta extends VentaEvent {}