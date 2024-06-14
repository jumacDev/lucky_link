import 'package:dio/dio.dart';
import 'package:vende_bet/data/models/environment.dart';
import 'package:vende_bet/domain/datasource/loteria_datasource.dart';
import 'package:vende_bet/domain/entities/loteria.dart';
import 'package:vende_bet/domain/entities/salida.dart';

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