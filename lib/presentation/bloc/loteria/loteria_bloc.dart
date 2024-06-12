import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vende_bet/data/datasources/loteria_datasource.dart';
import 'package:vende_bet/data/repositories/loteria_repository_impl.dart';

import '../../../domain/entities/loteria.dart';
import '../../../domain/entities/salida.dart';

part 'loteria_event.dart';
part 'loteria_state.dart';

class LoteriaBloc extends Bloc<LoteriaEvent, LoteriaState> {
  LoteriaBloc() : super(LoteriaInitial()) {
    on<ObtenerLoteria>(_onLoteria);
  }

  final LoteriaRepositoryImpl _repositoryImpl = LoteriaRepositoryImpl(LoteriaDataSource());

  _onLoteria(ObtenerLoteria event, Emitter<LoteriaState> emit) async{

    final Salida<List<Loteria>> voSalida = await _repositoryImpl.obtenerLoterias();

    if(voSalida.vnCodigo == 1){
      emit(LoteriasOk(voListLote: voSalida.voData!));
    }else{
      emit(LoteriasError(vcMensaje: voSalida.vcMensaje!));
    }


  }


}
