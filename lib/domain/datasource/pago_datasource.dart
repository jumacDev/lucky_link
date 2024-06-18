
import '../entities/pago.dart';
import '../entities/salida.dart';

abstract class PagoDatasource {

  Future<Salida<Pago>> obtenerPago(String pcFecha, int pnUsuaId);

}