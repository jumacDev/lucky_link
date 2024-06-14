
import 'package:vende_bet/domain/datasource/loteria_datasource.dart';
import 'package:vende_bet/domain/entities/loteria.dart';
import 'package:vende_bet/domain/entities/salida.dart';
import 'package:vende_bet/domain/repositories/loteria_repository.dart';

class LoteriaRepositoryImpl extends LoteriaRepository{

  final LoteriaDatasource datasource;

  LoteriaRepositoryImpl(this.datasource);

  @override
  Future<Salida<List<Loteria>>> obtenerLoterias() {
    return datasource.obtenerLoterias();
  }


}