import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/datasources/venta_datasource.dart';
import '/data/repositories/venta_repository_impl.dart';

import '/domain/entities/loteria.dart';
import '/domain/entities/venta.dart';

part 'venta_event.dart';
part 'venta_state.dart';

class VentaBloc extends Bloc<VentaEvent, VentaState> {
  VentaBloc() : super(VentaInitial()) {
    on<AgregarLoteria>(_onAgregarLoterias);
    on<Atras>(_onBotonAtras);
    on<Atras2>(_onBotonAtras2);
    on<AgregarNumero>(_onAgregarNumeros);
    on<EnviarVenta>(_onEnviarVenta);
    on<LogOutVenta>(_onLogOutVenta);
  }

  final VentaRepositoryImpl _repositoryImpl = VentaRepositoryImpl(VentaDataSource());
  
  _onAgregarLoterias(AgregarLoteria event, Emitter<VentaState> emit){
    emit(LoteriaSeleccionada(voLoterias: event.voLoterias));
  }

  _onBotonAtras(Atras event, Emitter<VentaState> emit){
    emit(VentaInitial());
  }

  _onBotonAtras2(Atras2 event, Emitter<VentaState> emit){
    emit(LoteriaSeleccionada(voLoterias: event.voLoterias));
  }

  _onAgregarNumeros(AgregarNumero event, Emitter<VentaState> emit){
    emit(NumerosAAgregar(voVentList: event.voVentList, voLoteList: event.voLoteList, vnPagoTota: event.vnPagoTota));
  }

  _onEnviarVenta(EnviarVenta event, Emitter<VentaState> emit) async {
    emit(VentaLoading());

    final voSalida = await _repositoryImpl.enviarVenta(event.voVentList, event.pnUsuaId);

    if(voSalida.vnCodigo == 1){
      emit(VentaConfirmada(vcMensaje: voSalida.vcMensaje!));
      Future.delayed(const Duration(seconds: 5));
      emit(VentaInitial());
    }else{
      emit(VentaError(vcMensaje: voSalida.vcMensaje!));
      Future.delayed(const Duration(seconds: 5));
      emit(VentaInitial());
    }
  }

  _onLogOutVenta(LogOutVenta event, Emitter<VentaState> emit){
    emit(VentaInitial());
  }

}
