
class Venta{
  final int vnNumero;
  final int vnPrecio;
  final int vnLoteId;

  Venta({required this.vnNumero, required this.vnPrecio, required this.vnLoteId});

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
      vnNumero: json['numero'],
      vnLoteId: json['idLoteria'],
      vnPrecio: json['precio']
  );

  Map<String, dynamic> toJson() => {
    "numero": vnNumero,
    "idLoteria": vnLoteId,
    "precio": vnPrecio,
  };

}