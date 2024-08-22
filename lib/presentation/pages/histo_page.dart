import 'package:animate_do/animate_do.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vende_bet/presentation/bloc/blocs.dart';

import '../widgets/widgets.dart';

class HistoPage extends StatefulWidget {
  final int vnUsuaId;
  const HistoPage({super.key, required this.vnUsuaId});

  @override
  State<HistoPage> createState() => _HistoPageState();
}

class _HistoPageState extends State<HistoPage> {
  late HistorialBloc _histoBloc;
  DateTime? _vdFechSele;
  final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  String _vcFecha = '';
  late int _vnUsuaId;

  @override
  void initState() {
    super.initState();
    _histoBloc = context.read<HistorialBloc>();
    _vdFechSele = DateTime.now();
    _vcFecha = _dateFormat.format(_vdFechSele!);
    _vnUsuaId = widget.vnUsuaId;
    _histoBloc.add(ConsultarHistorial(vcFecha: _vcFecha, vnUsuaId: _vnUsuaId));
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
        _vcFecha = _dateFormat.format(_vdFechSele!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    debugPrint('width: ${size.width}');
    debugPrint('height: ${size.height}');

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if(state is LoginOk){
          _vnUsuaId = state.voSesion.vnUsuario;
        }
        return FadeIn(
          child: Column(
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
                              ConsultarHistorial(vcFecha: _vcFecha, vnUsuaId: _vnUsuaId)));
                    },
                    child:
                    Text(_vdFechSele == null ? 'Seleccione una fecha' : _vcFecha,
                      style: GoogleFonts.openSans(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              BlocListener<HistorialBloc, HistorialState>(listener: (context, state){
                if(state is HistorialError){
                  showCoolAlert(context, CoolAlertType.error, 'Error', state.vcMensPago + state.vcMensVent);
                }
              },
                child: BlocBuilder<HistorialBloc, HistorialState>(
                  builder: (context, state){
                    if(state is HistorialOk){
                      return FadeIn(
                        child: Column(
                          children: [
                            const Gap(8),
                            Center(child: Text(
                              'Total Ventas: ${state.voPago.vnVentTota}',
                              style: GoogleFonts.openSans(fontSize: 18),
                              textAlign: TextAlign.center,
                            )),
                            const Gap(8),
                            Center(child: Text(
                              'Mi porcentaje: ${state.voPago.vnMiPorc}',
                              style: GoogleFonts.openSans(fontSize: 18),
                              textAlign: TextAlign.center,
                            )),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                              child: Divider(),
                            ),
                            const Gap(4),
                            Center(child: Text(
                              'Historial de Ventas',
                              style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )),
                            const Gap(16),
                            state.voVentas.isEmpty ? Center(
                                child: Text('No tiene ventas para el día seleccionado',
                                    style: GoogleFonts.openSans(fontSize: 18),
                                    textAlign: TextAlign.center)) :
                            SizedBox(
                              height: size.height < 670? size.height * 0.37 :
                              size.height >= 670 && size.height < 740? size.height * 0.43 :
                              size.height == 825? size.height * 0.55 :
                              size.height >= 740 && size.height < 850? size.height * 0.42 : size.height * 0.5,
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  itemBuilder: (BuildContext context, int vnIndex){
                                    var voVenta = state.voVentas[vnIndex];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      child: ListTile(
                                        visualDensity: VisualDensity.compact,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Número: ${voVenta.vnNumero}'),
                                            Text('Lotería: ${voVenta.vcLoteria}', style: GoogleFonts.openSans(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400
                                            )),
                                          ],
                                        ),
                                        subtitle: Text('Precio: ${voVenta.vnPrecio}'),
                                        subtitleTextStyle: GoogleFonts.openSans(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w100),
                                        titleTextStyle: GoogleFonts.openSans(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700),
                                        leading: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                                          child: Icon(Icons.sell, color: Colors.lightGreen, size: 40,),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: state.voVentas.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics()
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    if(state is HistorialLoading){
                      return FadeIn(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.lightGreen,
                            ),
                          ),
                        ),
                      );
                    }
                    return FadeIn(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 16),
                        child: Center(
                            child: Text('Seleccione una fecha para ver Ventas y Pagos',
                              style: GoogleFonts.openSans(fontSize: 20),
                              textAlign: TextAlign.center,
                            )
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
