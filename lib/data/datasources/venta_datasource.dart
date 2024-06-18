import 'package:dio/dio.dart';

import '../models/environment.dart';
import '/domain/datasource/venta_datasource.dart';
import '/domain/entities/salida.dart';
import '/domain/entities/venta.dart';

class VentaDataSource extends VentaDatasource{

  final Dio _dio = Dio();
  final Environment _environment = Environment();

  @override
  Future<Salida> enviarVenta(List<Venta> poList, int pnUsuaId) async {
    late Salida voSalida = Salida(
        vnCodigo: 0,
        vcMensaje: '',
        voData: null
    );

    try{
      final vcUrl = '${_environment.base}${_environment.ventas}';


      final response = await _dio.post(vcUrl,
          data: null,
          options: Options(
            headers: {
              "pn_usua_id" : pnUsuaId
            }
      ));

      voSalida = Salida(vnCodigo: response.data['codigo'], vcMensaje: response.data['mensaje'],
          voData: response.data['data']
      );

    }
    catch(e){
      if(e is DioException){
        voSalida = Salida(
            vnCodigo: 0,
            vcMensaje: 'Error ${e.message}',
            voData: null
        );
      }
    }
    return voSalida;

  }

  @override
  Future<Salida<List<Venta>>> obtenerVentas(String pcFecha, int pnUsuaId) async {
    late Salida<List<Venta>> voSalida = Salida<List<Venta>>(
        vnCodigo: 0,
        vcMensaje: '',
        voData: null
    );

    try{
      final vcUrl = '${_environment.base}${_environment.ventas}';

      final response = await _dio.get(vcUrl, options: Options(
        headers: {
          "pn_usua_id": pnUsuaId,
          "pf_fecha": pcFecha
        }
      ));


      voSalida = Salida(vnCodigo: response.data['codigo'], vcMensaje: response.data['mensaje'],
          voData: List<Venta>.from(response.data["data"].map((venta) => Venta.fromJson(venta)))
      );

    }
    catch(e){
      if(e is DioException){
        voSalida = Salida<List<Venta>>(
            vnCodigo: 0,
            vcMensaje: 'Error ${e.message}',
            voData: null
        );
      }
    }
    return voSalida;

  }

}