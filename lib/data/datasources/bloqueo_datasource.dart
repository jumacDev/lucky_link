import 'package:dio/dio.dart';
import 'package:vende_bet/data/models/environment.dart';

import '/domain/entities/salida.dart';
import '/domain/datasource/bloqueo_datasource.dart';
import '/domain/entities/bloqueo.dart';

class BloqueoDataSource extends BloqueoDatasource{

  final Dio _dio = Dio();
  final Environment _environment = Environment();

  @override
  Future<Salida<List<Bloqueo>>> obtenerBloqueos(String pcFecha) async{
    late Salida<List<Bloqueo>> voSalida = Salida<List<Bloqueo>>(
        vnCodigo: 0,
        vcMensaje: '',
        voData: <Bloqueo>[]
    );

    try{
      final vcUrl = '${_environment.base}${_environment.bloqueos}';


      final response = await _dio.get(vcUrl, options: Options(
        headers: {
          'pf_fecha' : pcFecha
        }
      ));

      voSalida = Salida(vnCodigo: response.data['codigo'], vcMensaje: response.data['mensaje'],
          voData: List<Bloqueo>.from(response.data['data'].map((voBloqueo) => Bloqueo.fromJson(voBloqueo))),
      );

    }
    catch(e){
      if(e is DioException){
        voSalida = Salida<List<Bloqueo>>(
            vnCodigo: 0,
            vcMensaje: 'Error ${e.message}',
            voData: <Bloqueo>[]
        );
      }
    }
    return voSalida;
  }

}