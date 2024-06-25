import '/domain/datasource/bloqueo_datasource.dart';
import '/domain/repositories/bloqueo_repository.dart';

import '../../domain/entities/salida.dart';
import '/domain/entities/bloqueo.dart';

class BloqueoRepositoryImpl extends BloqueoRepository{


  final BloqueoDatasource datasource;

  BloqueoRepositoryImpl(this.datasource);

  @override
  Future<Salida<List<Bloqueo>>> obtenerBloqueos(String pcFecha){
    return datasource.obtenerBloqueos(pcFecha);
  }
}