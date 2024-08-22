
class Loteria{
  final int vnId;
  final String vcNombre;
  final String vcUrlLogo;
  final String vcCierre;

  Loteria({required this.vnId, required this.vcNombre, required this.vcUrlLogo, required this.vcCierre});

  factory Loteria.fromJson(Map<String, dynamic> json) => Loteria(
    vnId: json["id"],
    vcNombre: json["nombre"],
    vcUrlLogo: json['url'],
    vcCierre: json['cierre']
  );
}