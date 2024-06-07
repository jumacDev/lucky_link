
import '../entities/salida.dart';
import '../entities/sesion.dart';

abstract class SesionDatasource{

  Future<Salida<Sesion>> sesion(String pcUser, String pcPass);
}