
import 'package:vende_bet/domain/datasource/sesion_datasource.dart';
import 'package:vende_bet/domain/repositories/sesion_repository.dart';

import '../../domain/entities/salida.dart';
import '../../domain/entities/sesion.dart';

class SesionRepositoryImpl extends SesionRepository{

  SesionDatasource datasource;

  SesionRepositoryImpl(this.datasource);

  @override
  Future<Salida<Sesion>> sesion(String pcUser, String pcPass) {
    return datasource.sesion(pcUser, pcPass);
  }

}