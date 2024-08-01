import 'package:animate_do/animate_do.dart';
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
  late String _vcFecha;

  @override
  void initState() {
    super.initState();
    _resultadosBloc = context.read<ResultadosBloc>();
    _vdFechSele = DateTime.now();
    _vcFecha = _dateFormat.format(_vdFechSele!);
    _resultadosBloc.add(TraerResultadosEvent(_vcFecha));
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FadeIn(
          child: Center(
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
                      _resultadosBloc.add(TraerResultadosEvent(_vcFecha)));
                },
                child:
                    Text(_vdFechSele == null ? 'Seleccione una fecha' : _vcFecha,
                      style: GoogleFonts.openSans(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
              ),
            ),
          ),
        ),
        FadeIn(
          child: BlocBuilder<ResultadosBloc, ResultadosState>(builder: (context, state) {
            if(state is ResultadosError){
              showCoolAlert(context, CoolAlertType.error, 'Error', state.vcMensaje);
            }
            if (state is ResultadosOk) {
              if (state.voResuList.isEmpty) {
                return FadeIn(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 24),
                    child: Center(
                      child: Text(
                        state.vcMensaje,
                        style: GoogleFonts.openSans(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }
              return FadeIn(
                child: SizedBox(
                  height: size.height < 670? size.height * 0.56 :
                  size.height >= 670 && size.height < 740? size.height * 0.63 :
                  size.height >= 740 && size.height < 850? size.height * 0.6 :
                  size.height == 960? size.height * 0.7 :
                  size.height == 916 || size.height == 926? size.height * 0.66 : size.height * 0.68,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.voResuList.length,
                      itemBuilder: (BuildContext context, int vnIndex) {
                        Resultado voResultado = state.voResuList[vnIndex];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 54),
                            title: Text('Lotería: ${voResultado.vcLoteria}', textAlign: TextAlign.left,),
                            titleTextStyle: GoogleFonts.openSans(fontSize: 14, color: Colors.black),
                            subtitle: Text('Número: ${voResultado.vnNumero}'),
                            subtitleTextStyle: GoogleFonts.openSans(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w300),
                            leading: const Icon(Icons.fact_check, color: Colors.lightGreen,size: 55),
                          ),
                        );
                      }),
                ),
              );
            }
            if (state is ResultadosLoading) {
              return FadeIn(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.lightGreen,
                  )),
                ),
              );
            }
            return FadeIn(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 16),
                child: Center(
                    child: Text('Seleccione una fecha para ver resultados',
                        style: GoogleFonts.openSans(fontSize: 22),
                      textAlign: TextAlign.center,
                    )
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
