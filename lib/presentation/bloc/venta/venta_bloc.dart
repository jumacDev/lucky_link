import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/venta.dart';

part 'venta_event.dart';
part 'venta_state.dart';

class VentaBloc extends Bloc<VentaEvent, VentaState> {
  VentaBloc() : super(VentaInitial()) {
    on<AgregarLoteria>(_onAgregarLoterias);
    on<Atras>(_onBotonAtras);
    on<AgregarNumero>(_onAgregarNumeros);
  }
  
  
  _onAgregarLoterias(AgregarLoteria event, Emitter<VentaState> emit){
    emit(LoteriaSeleccionada(voLoterias: event.voLoterias));
  }

  _onBotonAtras(Atras event, Emitter<VentaState> emit){
    emit(VentaInitial());
  }

  _onAgregarNumeros(AgregarNumero event, Emitter<VentaState> emit){
    emit(NumerosAgregados(voVentList: event.voVentList, voLoteList: event.voLoteList));
  }

}
