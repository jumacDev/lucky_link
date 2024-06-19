import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vende_bet/presentation/bloc/blocs.dart';

class HistoPage extends StatefulWidget {
  const HistoPage({super.key});

  @override
  State<HistoPage> createState() => _HistoPageState();
}

class _HistoPageState extends State<HistoPage> {
  late HistorialBloc _histoBloc;
  DateTime? _vdFechSele;
  final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  String vcFecha = '';

  @override
  void initState() {
    super.initState();
    _histoBloc = context.read<HistorialBloc>();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? vdFecha = await showDatePicker(
      context: context,
      initialDate: _vdFechSele ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (vdFecha != null && vdFecha != _vdFechSele) {
      setState(() {
        _vdFechSele = vdFecha;
        vcFecha = _dateFormat.format(_vdFechSele!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int vnUsuaId = 0;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if(state is LoginOk){
          vnUsuaId = state.voSesion.vnUsuario;
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(80, 40)
                  ),
                  onPressed: () {
                    _selectDate(context).then((value) =>
                        _histoBloc.add(
                            ConsultarHistorial(vcFecha: vcFecha, vnUsuaId: vnUsuaId)));
                  },
                  child:
                  Text(_vdFechSele == null ? 'Seleccione una fecha' : vcFecha,
                    style: GoogleFonts.openSans(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            BlocListener<HistorialBloc, HistorialState>(listener: (context, state){

            },
              child: BlocBuilder<HistorialBloc, HistorialState>(
                builder: (context, state){
                  if(state is HistorialOk){
                    return Column(
                      children: [
                        const Gap(8),
                        Center(child: Text(
                          'Total Ventas: ${state.voPago.vnVentTota}',
                          style: GoogleFonts.openSans(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                        const Gap(8),
                        Center(child: Text(
                          'Mi porcentaje: ${state.voPago.vnMiPorc}',
                          style: GoogleFonts.openSans(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                          child: Divider(),
                        ),
                        const Gap(4),
                        Center(child: Text(
                          'Historial de Ventas',
                          style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                        const Gap(16),
                        state.voVentas.isEmpty ? Center(
                            child: Text('No tiene ventas para el día seleccionado',
                                style: GoogleFonts.openSans(fontSize: 20),
                                textAlign: TextAlign.center)) :
                        ListView.builder(
                          itemBuilder: (BuildContext context, int vnIndex){
                            var voVenta = state.voVentas[vnIndex];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Número: ${voVenta.vnNumero}'),
                                    Text('Lotería: Cundinamarca', style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                    )),
                                  ],
                                ),
                                subtitle: Text('Precio: ${voVenta.vnPrecio}'),
                                subtitleTextStyle: GoogleFonts.openSans(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w100),
                                titleTextStyle: GoogleFonts.openSans(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
                                leading: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                                  child: Icon(Icons.sell, color: Colors.lightGreen, size: 40,),
                                ),
                              ),
                            );

                          },
                          itemCount: state.voVentas.length,
                          shrinkWrap: true,
                        )

                      ],
                    );
                  }
                  if(state is HistorialLoading){
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightGreen,
                        strokeWidth: 2,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 16),
                    child: Center(
                        child: Text('Seleccione una fecha para ver Ventas y Pagos',
                          style: GoogleFonts.openSans(fontSize: 22),
                          textAlign: TextAlign.center,
                        )
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
