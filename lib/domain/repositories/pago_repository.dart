import '../entities/pago.dart';
import '../entities/salida.dart';

abstract class PagoRepository {

  Future<Salida<Pago>> obtenerPago(String pcFecha, int pnUsuaId);

}