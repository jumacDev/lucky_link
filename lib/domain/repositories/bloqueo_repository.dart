import '../entities/bloqueo.dart';
import '../entities/salida.dart';

abstract class BloqueoRepository{
  Future<Salida<List<Bloqueo>>> obtenerBloqueos(String pcFecha);
}