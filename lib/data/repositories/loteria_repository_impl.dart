
import '/domain/datasource/loteria_datasource.dart';
import '/domain/entities/loteria.dart';
import '/domain/entities/salida.dart';
import '/domain/repositories/loteria_repository.dart';

class LoteriaRepositoryImpl extends LoteriaRepository{

  final LoteriaDatasource datasource;

  LoteriaRepositoryImpl(this.datasource);

  @override
  Future<Salida<List<Loteria>>> obtenerLoterias() {
    return datasource.obtenerLoterias();
  }


}