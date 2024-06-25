
class Bloqueo{
  final int vnNumero;

  Bloqueo({required this.vnNumero});

  factory Bloqueo.fromJson(Map<String, dynamic> json) => Bloqueo(vnNumero: json['numero']);

}