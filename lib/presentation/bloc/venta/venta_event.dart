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
  int vnUsuaId;

  EnviarVenta({required this.voVentList, required this.vnUsuaId});
}

class EliminarVenta extends VentaEvent {
  List<Venta> voVentList;
  Venta voVenta;
  List<Loteria> voLoteList;
  int vnPagoTota;

  EliminarVenta({required this.voVentList, required this.voVenta, required this.vnPagoTota, required this.voLoteList});

}

class LogOutVenta extends VentaEvent {}