import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vende_bet/presentation/bloc/blocs.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<bool> voSeleList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<LoteriaBloc, LoteriaState>(builder: (context, state) {
                if (state is LoteriasOk) {
                  if (voSeleList.length != state.voListLote.length) {
                    voSeleList = List.generate(state.voListLote.length, (index) => false);
                  }
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          List.generate(state.voListLote.length, (vnIndeSele) {
                            final voLoteria = state.voListLote[vnIndeSele];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ActionChip(
                                side: const BorderSide(
                                  color: Colors.transparent
                                ),
                                  backgroundColor: voSeleList[vnIndeSele]
                                      ? Colors.lightGreen
                                      : Colors.grey,
                                  label: Text(voLoteria.vcNombre,
                                      style: GoogleFonts.openSans(
                                          fontSize: 20, color: Colors.white)),
                                  onPressed: () {
                                    setState(() {
                                      voSeleList[vnIndeSele] = !voSeleList[vnIndeSele];
                                    });
                                  }),
                            );
                          })));
                }
                return const Center();
              }),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    minimumSize: const Size(150, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: (){},
                  child: Text('Continuar', style:  GoogleFonts.openSans(
                      fontSize: 20, color: Colors.white))),
                ),
            ],
          ),
        ));
  }
}
