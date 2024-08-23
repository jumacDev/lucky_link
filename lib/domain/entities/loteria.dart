
class Loteria{
  final int vnId;
  final String vcNombre;
  final String vcCierre;

  Loteria({required this.vnId, required this.vcNombre, required this.vcCierre});

  factory Loteria.fromJson(Map<String, dynamic> json) => Loteria(
    vnId: json["id"],
    vcNombre: json["nombre"],
    vcCierre: json['cierre']
  );
}