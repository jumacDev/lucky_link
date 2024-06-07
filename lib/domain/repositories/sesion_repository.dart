import '../entities/salida.dart';
import '../entities/sesion.dart';

abstract class SesionRepository{

  Future<Salida<Sesion>> sesion(String pcUser, String pcPass);

}