import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/datasources/pago_datasource.dart';
import '/data/datasources/venta_datasource.dart';
import '/data/repositories/pago_repository_impl.dart';
import '/data/repositories/venta_repository_impl.dart';

import '../../../domain/entities/pago.dart';
import '../../../domain/entities/venta.dart';

part 'historial_event.dart';
part 'historial_state.dart';

class HistorialBloc extends Bloc<HistorialEvent, HistorialState> {
  HistorialBloc() : super(HistorialInitial()) {
    on<ConsultarHistorial>(_onConsultarHistorial);
    on<LogOutHisto>(_onLogOutHisto);
  }

  final PagoRepositoryImpl _pagoRepositoryImpl = PagoRepositoryImpl(PagoDataSource());
  final VentaRepositoryImpl _ventaRepositoryImpl = VentaRepositoryImpl(VentaDataSource());

  _onConsultarHistorial(ConsultarHistorial event, Emitter<HistorialState> emit) async{
    emit(HistorialLoading());

    final voSaliPago = await _pagoRepositoryImpl.obtenerPago(event.vcFecha, event.vnUsuaId);

    final voSaliVentas = await _ventaRepositoryImpl.obtenerVentas(event.vcFecha, event.vnUsuaId);


    if(voSaliVentas.vnCodigo == 1 && voSaliPago.vnCodigo == 1){
      emit(HistorialOk(voPago: voSaliPago.voData!, voVentas: voSaliVentas.voData!));
    }else{
      emit(HistorialError(vcMensPago: voSaliPago.vcMensaje!, vcMensVent: voSaliVentas.vcMensaje!));
    }

  }

  _onLogOutHisto(LogOutHisto event, Emitter<HistorialState> emit){
    emit(HistorialInitial());
  }
}
