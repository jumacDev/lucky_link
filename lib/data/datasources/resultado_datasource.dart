import 'package:dio/dio.dart';

import '../models/environment.dart';
import '/domain/datasource/resultado_datasource.dart';
import '/domain/entities/resultado.dart';
import '/domain/entities/salida.dart';

class ResultadoDataSource extends ResultadoDatasource{

  final Dio _dio = Dio();
  final Environment _environment = Environment();

  @override
  Future<Salida<List<Resultado>>> traerResultados(String pcFecha) async {
    late Salida<List<Resultado>> voSalida = Salida<List<Resultado>>(
        vnCodigo: 0,
        vcMensaje: '',
        voData: <Resultado>[]
    );

    try{
      final vcUrl = '${_environment.base}${_environment.resultados}';


      final response = await _dio.get(vcUrl, options: Options(
        headers: {
          'pf_fecha' : pcFecha
        }
      ));

      voSalida = Salida(vnCodigo: response.data['codigo'], vcMensaje: response.data['mensaje'],
          voData: List<Resultado>.from(response.data["data"].map((resultado) => Resultado.fromJson(resultado)))
      );

    }
    catch(e){
      if(e is DioException){
        voSalida = Salida<List<Resultado>>(
            vnCodigo: 0,
            vcMensaje: 'Error ${e.message}',
            voData: <Resultado>[]
        );
      }
    }
    return voSalida;

  }

}