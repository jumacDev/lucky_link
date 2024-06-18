part of 'historial_bloc.dart';

abstract class HistorialState {}

class HistorialInitial extends HistorialState {}

class HistorialOk extends HistorialState{
  final Pago voPago;
  final List<Venta> voVentas;

  HistorialOk({required this.voPago, required this.voVentas});
}

class HistorialLoading extends HistorialState {}

class HistorialError extends HistorialState {
  final String vcMensPago;
  final String vcMensVent;

  HistorialError({required this.vcMensPago, required this.vcMensVent});
}