
class Resultado {
  final int vnIdLote;
  final String vcLoteria;
  final int vnNumero;

  Resultado({required this.vnIdLote, required this.vcLoteria, required this.vnNumero});

  factory Resultado.fromJson(Map<String, dynamic> json) => Resultado(
        vnIdLote: json['id_loteria'],
        vcLoteria: json['loteria'],
        vnNumero: json['numero']
  );


}
