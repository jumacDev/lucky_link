
class Salida<T>{
  final int? vnCodigo;
  final String? vcMensaje;
  T? voData;

  Salida({required this.vnCodigo, required this.vcMensaje, required this.voData});

  factory Salida.fromJson(Map<String, dynamic> json) => Salida(
    vnCodigo: json['codigo'],
    vcMensaje: json['mensaje'],
    voData: json['data'],
  );
}