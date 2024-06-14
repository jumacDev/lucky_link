import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vende_bet/presentation/widgets/shared/cool_alert.dart';
import '../../domain/entities/resultado.dart';
import '/presentation/bloc/resultados/resultados_bloc.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late ResultadosBloc _resultadosBloc;
  DateTime? _vdFechSele;
  final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  late String vcFecha;

  @override
  void initState() {
    super.initState();
    _resultadosBloc = context.read<ResultadosBloc>();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white),
              onPressed: () {
                _selectDate(context).then((value) =>
                    _resultadosBloc.add(TraerResultadosEvent(vcFecha)));
              },
              child:
                  Text(_vdFechSele == null ? 'Seleccione una fecha' : vcFecha),
            ),
          ),
        ),
        BlocBuilder<ResultadosBloc, ResultadosState>(builder: (context, state) {
          if(state is ResultadosError){
            showCoolAlert(context, CoolAlertType.error, 'Error', state.vcMensaje);
          }
          if (state is ResultadosOk) {
            if (state.voResuList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 24),
                child: Center(
                  child: Text(
                    state.vcMensaje,
                    style: GoogleFonts.openSans(fontSize: 20),
                  ),
                ),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.voResuList.length,
                itemBuilder: (BuildContext context, int vnIndex) {
                  Resultado voResultado = state.voResuList[vnIndex];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      title: Text('Lotería: ${voResultado.vcLoteria}'),
                      titleTextStyle: GoogleFonts.openSans(fontSize: 20),
                      subtitle: Text('Número: ${voResultado.vnNumero}'),
                      subtitleTextStyle: GoogleFonts.openSans(fontSize: 20),
                      leading: const Icon(Icons.fact_check, color: Colors.lightGreen,),
                    ),
                  );
                });
          }
          if (state is ResultadosLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.lightGreen,
              )),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 16),
            child: Center(
                child: Text('Seleccione una fecha para ver resultados',
                    style: GoogleFonts.openSans(fontSize: 20))),
          );
        })
      ],
    );
  }
}
