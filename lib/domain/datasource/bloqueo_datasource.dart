import '../entities/bloqueo.dart';
import '../entities/salida.dart';

abstract class BloqueoDatasource{
  Future<Salida<List<Bloqueo>>> obtenerBloqueos(String pcFecha);
}