
class Loteria{
  final int vnId;
  final String vcNombre;

  Loteria({required this.vnId, required this.vcNombre});

  factory Loteria.fromJson(Map<String, dynamic> json) => Loteria(
    vnId: json["id"],
    vcNombre: json["nombre"],
  );
}