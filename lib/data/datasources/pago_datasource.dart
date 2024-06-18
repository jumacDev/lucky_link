
import 'package:dio/dio.dart';

import '../../domain/entities/salida.dart';
import '../models/environment.dart';
import '/domain/datasource/pago_datasource.dart';
import '/domain/entities/pago.dart';

class PagoDataSource extends PagoDatasource{

  final Dio _dio = Dio();
  final Environment _environment = Environment();

  @override
  Future<Salida<Pago>> obtenerPago(String pcFecha, int pnUsuaId) async{
    late Salida<Pago> voSalida = Salida<Pago>(
        vnCodigo: 0,
        vcMensaje: '',
        voData: null
    );

    try{
      final vcUrl = '${_environment.base}${_environment.pagos}?pn_usua_id=$pnUsuaId&pf_fecha=$pcFecha';


      final response = await _dio.get(vcUrl);

      voSalida = Salida(vnCodigo: response.data['codigo'], vcMensaje: response.data['mensaje'],
          voData: Pago.fromJson(response.data['data'])
      );

    }
    catch(e){
      if(e is DioException){
        voSalida = Salida<Pago>(
            vnCodigo: 0,
            vcMensaje: 'Error ${e.message}',
            voData: null
        );
      }
    }
    return voSalida;

  }

}