
import '../entities/resultado.dart';
import '../entities/salida.dart';

abstract class ResultadoDatasource{

  Future<Salida<List<Resultado>>> traerResultados(String pcFecha);

}