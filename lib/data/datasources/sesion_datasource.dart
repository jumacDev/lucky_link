import 'package:dio/dio.dart';
import 'package:vende_bet/data/models/environment.dart';

import '../../domain/datasource/sesion_datasource.dart';
import '../../domain/entities/salida.dart';
import '../../domain/entities/sesion.dart';

class SesionDataSource extends SesionDatasource {

  final Dio _dio = Dio();
  final Environment _environment = Environment();

  @override
  Future<Salida<Sesion>> sesion(String pcUser, String pcPass) async {

    final vcUrl = '${_environment.base}${_environment.sesiones}?pn_usuario=$pcUser&pc_password=$pcPass';

    Salida<Sesion> voSalida = Salida(vnCodigo: 0, vcMensaje: null, voData: null);

    try {

      final response = await _dio.get(vcUrl);
      final voData = response.data;

      if (response.statusCode == 200) {
        voSalida = Salida<Sesion>(
          vnCodigo: voData['codigo'],
          vcMensaje: voData['mensaje'],
          voData: voData['codigo'] == 0 ? null : Sesion.fromJson(voData['data']),
        );
      }

    } catch (e) {
      if (e is DioException) {
        rethrow;
      }
    }
    return voSalida;
  }

}