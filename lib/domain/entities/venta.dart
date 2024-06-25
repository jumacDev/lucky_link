
class Venta{
  final int vnNumero;
  final int vnPrecio;
  final int vnLoteId;
  final String vcLoteria;

  Venta({required this.vnNumero, required this.vnPrecio, required this.vnLoteId, required this.vcLoteria});

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
      vnNumero: json['numero'],
      vnLoteId: json['idLoteria'],
      vcLoteria: json['loteria'],
      vnPrecio: json['precio']
  );

  Map<String, dynamic> toJson() => {
    "numero": vnNumero,
    "idLoteria": vnLoteId,
    "loteria": vcLoteria,
    "precio": vnPrecio,
  };

}