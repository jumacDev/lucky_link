import '../entities/loteria.dart';

import '../entities/salida.dart';

abstract class LoteriaDatasource{

  Future<Salida<List<Loteria>>> obtenerLoterias();

}