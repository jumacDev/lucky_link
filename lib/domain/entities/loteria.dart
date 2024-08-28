
class Loteria{
  final int vnId;
  final String vcNombre;
  final String vcCierre;
  final int vnLogo;

  Loteria({required this.vnId, required this.vcNombre, required this.vcCierre, required this.vnLogo});

  factory Loteria.fromJson(Map<String, dynamic> json) => Loteria(
    vnId: json["id"],
    vcNombre: json["nombre"],
    vcCierre: json['cierre'],
    vnLogo: json['logo']
  );
}