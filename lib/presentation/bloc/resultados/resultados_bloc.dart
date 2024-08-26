import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/datasources/resultado_datasource.dart';
import '/data/repositories/resultado_repository_impl.dart';

import '../../../domain/entities/resultado.dart';
import '../../../domain/entities/salida.dart';

part 'resultados_event.dart';
part 'resultados_state.dart';

class ResultadosBloc extends Bloc<ResultadosEvent, ResultadosState> {
  ResultadosBloc() : super(ResultadosInitial()) {
    on<TraerResultadosEvent>(_onTraerResultadosEvent);
    on<LogOutResul>(_onLogOutResul);
  }

  final ResultadoRepositoryImpl _repositoryImpl = ResultadoRepositoryImpl(ResultadoDataSource());


  _onTraerResultadosEvent(TraerResultadosEvent event, Emitter<ResultadosState> emit) async{

    emit(ResultadosLoading());

    final Salida<List<Resultado>> voSalida = await _repositoryImpl.traerResultados(event.vcFecha);

    if(voSalida.vnCodigo == 1){
        emit(ResultadosOk(voResuList: voSalida.voData!, vcMensaje: voSalida.vcMensaje!));
    }else{
      emit(ResultadosError(vcMensaje: voSalida.vcMensaje!));
    }
  }

  _onLogOutResul(LogOutResul event, Emitter<ResultadosState> emit){
    emit(ResultadosInitial());
  }

}
