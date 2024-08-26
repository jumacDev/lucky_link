
import '/domain/datasource/pago_datasource.dart';

import '../../domain/entities/salida.dart';
import '/domain/entities/pago.dart';
import '/domain/repositories/pago_repository.dart';

class PagoRepositoryImpl extends PagoRepository {

  final PagoDatasource datasource;

  PagoRepositoryImpl(this.datasource);

  @override
  Future<Salida<Pago>> obtenerPago(String pcFecha, int pnUsuaId) {
   return datasource.obtenerPago(pcFecha, pnUsuaId);
  }

}