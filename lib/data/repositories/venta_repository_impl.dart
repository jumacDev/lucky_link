

import '/domain/datasource/venta_datasource.dart';
import '/domain/entities/salida.dart';

import '/domain/entities/venta.dart';
import '/domain/repositories/venta_repository.dart';

class VentaRepositoryImpl extends VentaRepository{

  final VentaDatasource datasource;

  VentaRepositoryImpl(this.datasource);

  @override
  Future<Salida> enviarVenta(List<Venta> poList, int pnUsuaId) {
    return datasource.enviarVenta(poList, pnUsuaId);
  }

  @override
  Future<Salida<List<Venta>>> obtenerVentas(String pcFecha, int pnUsuaId) {
    return datasource.obtenerVentas(pcFecha, pnUsuaId);
  }

}
