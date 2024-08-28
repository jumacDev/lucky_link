import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/datasources/bloqueo_datasource.dart';
import '/data/repositories/bloqueo_repository_impl.dart';

import '../../../domain/entities/bloqueo.dart';
part 'bloqueo_event.dart';
part 'bloqueo_state.dart';

class BloqueoBloc extends Bloc<BloqueoEvent, BloqueoState> {
  BloqueoBloc() : super(BloqueoInitial()) {
    on<ObtenerBloqueos>(_onObtenerBloqueos);
  }

  final BloqueoRepositoryImpl _repositoryImpl = BloqueoRepositoryImpl(BloqueoDataSource());

  _onObtenerBloqueos(ObtenerBloqueos event, Emitter<BloqueoState> emit) async {

    final voSalida = await _repositoryImpl.obtenerBloqueos(event.vcFecha);

    if(voSalida.vnCodigo == 1){
      emit(BloqueoOk(voListBloq: voSalida.voData!));
    }else{
      emit(BloqueoError(vcMensaje: voSalida.vcMensaje!));
    }

  }
}
