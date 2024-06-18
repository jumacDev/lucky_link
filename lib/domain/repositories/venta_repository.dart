import '../entities/salida.dart';
import '../entities/venta.dart';

abstract class VentaRepository{

  Future<Salida<List<Venta>>> obtenerVentas(String pcFecha, int pnUsuaId);

  Future<Salida> enviarVenta(List<Venta> poList, int pnUsuaId);

}