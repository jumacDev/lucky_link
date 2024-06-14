import '../entities/loteria.dart';

import '../entities/salida.dart';

abstract class LoteriaRepository{

  Future<Salida<List<Loteria>>> obtenerLoterias();

}