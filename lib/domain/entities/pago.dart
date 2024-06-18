
class Pago{
  final int vnVentTota;
  final int vnMiPorc;

  Pago({required this.vnVentTota, required this.vnMiPorc});

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
      vnVentTota: json['ventaTotal'],
      vnMiPorc: json['miPorcentaje']
  );

}