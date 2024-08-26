import 'package:dio/dio.dart';
import '/data/models/environment.dart';
import '/domain/datasource/loteria_datasource.dart';
import '/domain/entities/loteria.dart';
import '/domain/entities/salida.dart';

class LoteriaDataSource extends LoteriaDatasource{

  final Dio _dio = Dio();
  final Environment _environment = Environment();

  @override
  Future<Salida<List<Loteria>>> obtenerLoterias() async {

    late Salida<List<Loteria>> voSalida = Salida<List<Loteria>>(
      vnCodigo: 0,
      vcMensaje: '',
      voData: <Loteria>[]
    );

    try{
      final vcUrl = '${_environment.base}${_environment.loterias}';


      final response = await _dio.get(vcUrl);

      voSalida = Salida(vnCodigo: response.data['codigo'], vcMensaje: response.data['mensaje'],
          voData: List<Loteria>.from(response.data["data"].map((loteria) => Loteria.fromJson(loteria)))
      );

    }
    catch(e){
      if(e is DioException){
        voSalida = Salida<List<Loteria>>(
            vnCodigo: 0,
            vcMensaje: 'Error ${e.message}',
            voData: <Loteria>[]
        );
      }
    }
    return voSalida;
  }

}