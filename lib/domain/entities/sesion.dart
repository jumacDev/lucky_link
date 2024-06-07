
class Sesion{
  final int vnSesion;
  final int vnUsuario;
  final int vnTipoSesi;
  final int vnPorcentaje;
  final String vcCreacion;

  Sesion({required this.vnSesion, required this.vnUsuario, required this.vnTipoSesi, required this.vnPorcentaje, required this.vcCreacion});

  factory Sesion.fromJson(Map<String, dynamic> json) => Sesion(
    vnSesion: json["sesion"],
    vnUsuario: json["usuario"],
    vnTipoSesi: json["tipoSesion"],
    vnPorcentaje: json["porcentaje"],
    vcCreacion: json["creacion"],
  );


}