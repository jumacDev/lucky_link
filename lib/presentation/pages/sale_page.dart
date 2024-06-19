import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vende_bet/presentation/bloc/blocs.dart';
import 'package:vende_bet/presentation/widgets/shared/cool_alert.dart';

import '../../domain/entities/loteria.dart';
import '../../domain/entities/venta.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  final TextEditingController _numberText = TextEditingController();
  final TextEditingController _priceText = TextEditingController();
  final TextEditingController _numberText2 = TextEditingController();
  final TextEditingController _priceText2 = TextEditingController();
  final TextEditingController _numberText3 = TextEditingController();
  final TextEditingController _priceText3 = TextEditingController();
  int _totalPrice = 0;
  List<bool> voSeleList = [];
  List<Venta> voVentList = [];
  List<int> voLoteSele = [];
  List<Loteria> voLoteList = [];
  late VentaBloc _ventaBloc;

  @override
  void initState() {
    super.initState();
    _ventaBloc = context.read<VentaBloc>();
  }

  _onTapOutside(pointer) {
    final FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus && focus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(
      child: BlocBuilder<VentaBloc, VentaState>(
        builder: (context, state) {
          if (state is LoteriaSeleccionada) {
            return Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    const Gap(24),
                    //inputs
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Números
                        Column(
                          children: [
                            const Gap(8),
                            Center(
                              child: Text(
                                "Número",
                                style: GoogleFonts.openSans(color: Colors.black, fontSize: 24),
                              ),
                            ),
                            const Gap(8),
                            SizedBox(
                              width: 190,
                              height: 90,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    maxLength: 4,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    onTapOutside: _onTapOutside,
                                    controller: _numberText,
                                    decoration: InputDecoration(
                                      labelStyle: GoogleFonts.openSans(color: Colors.black),
                                      isDense: true,
                                      labelText: 'Número',
                                      border: const OutlineInputBorder(),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.toString().length < 3 ||
                                          value.isEmpty) {
                                        return 'Inválido';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: 190,
                              height: 90,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    maxLength: 4,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    onTapOutside: _onTapOutside,
                                    controller: _numberText2,
                                    decoration: InputDecoration(
                                      labelStyle: GoogleFonts.openSans(color: Colors.black),
                                      labelText: 'Número',
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.toString().length < 3 ||
                                          value.isEmpty) {
                                        return 'Inválido';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: 190,
                              height: 90,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    onTapOutside: _onTapOutside,
                                    controller: _numberText3,
                                    decoration: InputDecoration(
                                      labelText: 'Número',
                                      labelStyle: GoogleFonts.openSans(color: Colors.black),
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.toString().length < 3 ||
                                          value.isEmpty) {
                                        return 'Inválido';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                          ],
                        ),
                        //Precios
                        Column(
                          children: [
                            const Gap(8),
                            Center(
                              child:
                                  Text("Valor", style: GoogleFonts.openSans(color: Colors.black, fontSize: 24)),
                            ),
                            const Gap(8),
                            SizedBox(
                              width: 200,
                              height: 90,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 60),
                                child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.next,
                                    onTapOutside: _onTapOutside,
                                    onChanged: (value) {
                                      if (value.length >= 4) {
                                        _totalPrice += (int.parse(value) *
                                            voLoteSele.length);
                                      } else if (value.isEmpty) {
                                        _totalPrice = 0;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: _priceText,
                                    decoration: InputDecoration(
                                      labelText: 'Valor',
                                      labelStyle: GoogleFonts.openSans(color: Colors.black),
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.toString().length < 4) {
                                        return 'Inválido';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              height: 90,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 60),
                                child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.next,
                                    onTapOutside: _onTapOutside,
                                    onChanged: (value) {
                                      if (value.length >= 4) {
                                        _totalPrice += (int.parse(value) *
                                            voLoteSele.length);
                                      } else if (value.isEmpty) {
                                        _totalPrice = 0;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: _priceText2,
                                    decoration: InputDecoration(
                                      labelText: 'Valor',
                                      labelStyle: GoogleFonts.openSans(color: Colors.black),
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.toString().length < 4 ||
                                          value.isEmpty) {
                                        return 'Inválido';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              height: 90,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 60),
                                child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onTapOutside: _onTapOutside,
                                    onChanged: (value) {
                                      if (value.length >= 4) {
                                        _totalPrice += (int.parse(value) *
                                            voLoteSele.length);
                                      } else if (value.isEmpty) {
                                        _totalPrice = 0;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: _priceText3,
                                    decoration: InputDecoration(
                                      labelText: 'Valor',
                                      labelStyle: GoogleFonts.openSans(color: Colors.black),
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.toString().length < 4 ||
                                          value.isEmpty) {
                                        return 'Inválido';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Gap(32),
                    //total
                    Center(
                        child: Text("Total a pagar: ${_totalPrice.toString()}",
                            style: GoogleFonts.openSans(color: Colors.black))),
                    const Gap(32),
                    //botones
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                _ventaBloc.add(Atras());
                              },
                              child: Text(
                                'Atrás',
                                style: GoogleFonts.openSans(color: Colors.white),
                              ),
                            )),
                        Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                for (var item in voLoteSele) {
                                  if (_numberText.text.isNotEmpty &&
                                      _priceText.text.isNotEmpty) {
                                    Venta voVenta = Venta(
                                        vnNumero: int.parse(_numberText.text),
                                        vnPrecio: int.parse(_priceText.text),
                                        vnLoteId: item);
                                    voVentList.add(voVenta);
                                  }
                                  if (_numberText2.text.isNotEmpty &&
                                      _priceText2.text.isNotEmpty) {
                                    Venta voVenta = Venta(
                                        vnNumero: int.parse(_numberText2.text),
                                        vnPrecio: int.parse(_priceText2.text),
                                        vnLoteId: item);
                                    voVentList.add(voVenta);
                                  }
                                  if (_numberText3.text.isNotEmpty &&
                                      _priceText3.text.isNotEmpty) {
                                    Venta voVenta = Venta(
                                        vnNumero: int.parse(_numberText3.text),
                                        vnPrecio: int.parse(_priceText3.text),
                                        vnLoteId: item);
                                    voVentList.add(voVenta);
                                  }
                                }
                                _ventaBloc.add(AgregarNumero(
                                    voVentList: voVentList,
                                    voLoteList: voLoteSele));
                              },
                              child: Text(
                                'Registrar',
                                style: GoogleFonts.openSans(color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is NumerosAgregados) {
            return Column(
              children: [
                const Gap(24),
                Text('Números Agregados',
                    style: GoogleFonts.openSans(
                        fontSize: 22, color: Colors.black)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.voVentList.length,
                  itemBuilder: (BuildContext context, int vnIndex) {
                    var voVenta = state.voVentList[vnIndex];
                    String vcLoteria = '';
                    for(var voLote in voLoteList){
                      if(voLote.vnId == voVenta.vnLoteId){
                        vcLoteria = voLote.vcNombre;
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      child: ListTile(
                        visualDensity: VisualDensity.compact,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Número: ${voVenta.vnNumero}'),
                            Text('Lotería: $vcLoteria',
                                style: GoogleFonts.openSans(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        subtitle: Text('Precio: ${voVenta.vnPrecio}'),
                        subtitleTextStyle: GoogleFonts.openSans(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w100),
                        titleTextStyle: GoogleFonts.openSans(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        leading: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Icon(
                            Icons.sell,
                            color: Colors.lightGreen,
                            size: 40,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () { },
                  child: const Text(
                    'Finalizar',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          }
          return Column(
            children: [
              BlocBuilder<LoteriaBloc, LoteriaState>(builder: (context, state) {
                if (state is LoteriasOk) {
                  voLoteList = state.voListLote;
                  if (voSeleList.length != state.voListLote.length) {
                    voSeleList = List.generate(
                        state.voListLote.length, (index) => false);
                  }
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          const Gap(200),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(state.voListLote.length,
                                  (vnIndeSele) {
                                final voLoteria = state.voListLote[vnIndeSele];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ActionChip(
                                      side: const BorderSide(
                                          color: Colors.transparent),
                                      backgroundColor: voSeleList[vnIndeSele]
                                          ? Colors.lightGreen
                                          : Colors.grey,
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      label: Text(voLoteria.vcNombre,
                                          style: GoogleFonts.openSans(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      onPressed: () {
                                        if (voLoteSele
                                            .contains(voLoteria.vnId)) {
                                          voLoteSele.remove(voLoteria.vnId);
                                        } else {
                                          voLoteSele.add(voLoteria.vnId);
                                        }
                                        setState(() {
                                          voSeleList[vnIndeSele] =
                                              !voSeleList[vnIndeSele];
                                        });
                                      }),
                                );
                              })),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightGreen,
                                    minimumSize: const Size(150, 55),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  if (voLoteSele.isNotEmpty) {
                                    _ventaBloc.add(
                                        AgregarLoteria(voLoterias: voLoteSele));
                                  } else {
                                    showCoolAlert(
                                        context,
                                        CoolAlertType.warning,
                                        'Nada Seleccionado',
                                        'Por favor selecione una o más loterias');
                                  }
                                },
                                child: Text('Continuar',
                                    style: GoogleFonts.openSans(
                                        fontSize: 20, color: Colors.white))),
                          ),
                        ],
                      ));
                }
                return const Center();
              }),
            ],
          );
        },
      ),
    ));
  }
}
