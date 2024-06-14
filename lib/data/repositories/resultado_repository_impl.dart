import 'package:vende_bet/domain/datasource/resultado_datasource.dart';

import '../../domain/entities/resultado.dart';
import '../../domain/entities/salida.dart';
import '/domain/repositories/resultado_repository.dart';


class ResultadoRepositoryImpl extends ResultadoRepository{

  final ResultadoDatasource datasource;

  ResultadoRepositoryImpl(this.datasource);

  @override
  Future<Salida<List<Resultado>>> traerResultados(String pcFecha){
    return datasource.traerResultados(pcFecha);
  }

}