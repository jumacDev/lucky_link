import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '/presentation/bloc/blocs.dart';
import '/presentation/widgets/shared/cool_alert.dart';
import '/domain/entities/loteria.dart';
import '/domain/entities/venta.dart';

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
  int vnTotalPrice = 0;
  int _vnUsuaId = 0;
  List<bool> voSeleList = [];
  List<Venta> voVentList = [];
  List<Loteria> voLoteSele = [];
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

  _clearText(){
    _priceText.clear();
    _priceText2.clear();
    _priceText3.clear();
    _numberText.clear();
    _numberText2.clear();
    _numberText3.clear();
    vnTotalPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginOk) {
          _vnUsuaId = state.voSesion.vnUsuario;
          return SafeArea(
            minimum: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
            child: BlocListener<VentaBloc, VentaState>(
              listener: (context, state) {
                if(state is VentaError){
                  showCoolAlert(context, CoolAlertType.error, 'No se pudo realizar la venta', state.vcMensaje);
                  Future.delayed(const Duration(seconds: 3));
                  _ventaBloc.add(LogOutVenta());
                  _clearText();
                }
                if(state is VentaConfirmada){
                  showCoolAlert(context, CoolAlertType.success, 'Venta Exitosa', state.vcMensaje);
                  _ventaBloc.add(LogOutVenta());
                  _clearText();
                }
                if(state is VentaInitial){
                  voSeleList.clear();
                  voVentList.clear();
                  voLoteSele.clear();
                }
              },
              child: BlocBuilder<VentaBloc, VentaState>(
                builder: (context, state) {
                  if (state is LoteriaSeleccionada) {
                    voVentList.clear();
                    return Column(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          children: [
                            const Gap(20),
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
                                        style: GoogleFonts.openSans(
                                            color: Colors.black, fontSize: 24),
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            maxLength: 4,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            onTapOutside: _onTapOutside,
                                            controller: _numberText,
                                            decoration: InputDecoration(
                                              labelStyle: GoogleFonts.openSans(
                                                  color: Colors.black),
                                              isDense: true,
                                              labelText: 'Número',
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.toString().length <
                                                      3 ||
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            maxLength: 4,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            onTapOutside: _onTapOutside,
                                            controller: _numberText2,
                                            decoration: InputDecoration(
                                              labelStyle: GoogleFonts.openSans(
                                                  color: Colors.black),
                                              labelText: 'Número',
                                              isDense: true,
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.toString().length <
                                                      3 ||
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            maxLength: 4,
                                            keyboardType: TextInputType.number,
                                            onTapOutside: _onTapOutside,
                                            controller: _numberText3,
                                            decoration: InputDecoration(
                                              labelText: 'Número',
                                              labelStyle: GoogleFonts.openSans(
                                                  color: Colors.black),
                                              isDense: true,
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.toString().length <
                                                      3 ||
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
                                      child: Text("Valor",
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontSize: 24)),
                                    ),
                                    const Gap(8),
                                    SizedBox(
                                      width: 200,
                                      height: 90,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 60),
                                        child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            textInputAction:
                                                TextInputAction.next,
                                            onTapOutside: _onTapOutside,
                                            onChanged: (value) {
                                              if (value.length > 3) {
                                                vnTotalPrice += (int.parse(value) * voLoteSele.length);
                                              } else if (value.isEmpty) {
                                                vnTotalPrice = 0;
                                              }
                                              setState(() {});
                                            },
                                            keyboardType: TextInputType.number,
                                            controller: _priceText,
                                            decoration: InputDecoration(
                                              labelText: 'Valor',
                                              labelStyle: GoogleFonts.openSans(
                                                  color: Colors.black),
                                              isDense: true,
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.toString().length < 3) {
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            textInputAction:
                                                TextInputAction.next,
                                            onTapOutside: _onTapOutside,
                                            onChanged: (value) {
                                              if (value.length > 3) {
                                                vnTotalPrice += (int.parse(value) * voLoteSele.length);
                                              } else if (value.isEmpty) {
                                                vnTotalPrice = 0;
                                              }
                                              setState(() {});
                                            },
                                            keyboardType: TextInputType.number,
                                            controller: _priceText2,
                                            decoration: InputDecoration(
                                              labelText: 'Valor',
                                              labelStyle: GoogleFonts.openSans(
                                                  color: Colors.black),
                                              isDense: true,
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.toString().length < 3 || value.isEmpty) {
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            onTapOutside: _onTapOutside,
                                            onChanged: (value) {
                                              if (value.length > 3) {
                                                vnTotalPrice += (int.parse(value) * voLoteSele.length);
                                              } else if (value.isEmpty) {
                                                vnTotalPrice = 0;
                                              }
                                              setState(() {});
                                            },
                                            keyboardType: TextInputType.number,
                                            controller: _priceText3,
                                            decoration: InputDecoration(
                                              labelText: 'Valor',
                                              labelStyle: GoogleFonts.openSans(
                                                  color: Colors.black),
                                              isDense: true,
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.toString().length < 3 || value.isEmpty) {
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
                            const Gap(24),
                            //total
                            Center(
                                child: Text(
                                    "Total a pagar: ${vnTotalPrice.toString()}",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black))),
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
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () {
                                        _ventaBloc.add(Atras());
                                        _clearText();
                                      },
                                      child: Text(
                                        'Atrás',
                                        style: GoogleFonts.openSans(
                                            color: Colors.white),
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
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () {
                                        for (var item in voLoteSele) {
                                          if (_numberText.text.isNotEmpty &&
                                              _priceText.text.isNotEmpty) {
                                            Venta voVenta = Venta(
                                                vnNumero:
                                                    int.parse(_numberText.text),
                                                vnPrecio:
                                                    int.parse(_priceText.text),
                                                vnLoteId: item.vnId,
                                                vcLoteria: item.vcNombre);
                                            voVentList.add(voVenta);
                                          }
                                          if (_numberText2.text.isNotEmpty &&
                                              _priceText2.text.isNotEmpty) {
                                            Venta voVenta = Venta(
                                                vnNumero: int.parse(
                                                    _numberText2.text),
                                                vnPrecio:
                                                    int.parse(_priceText2.text),
                                                vnLoteId: item.vnId,
                                                vcLoteria: item.vcNombre);
                                            voVentList.add(voVenta);
                                          }
                                          if (_numberText3.text.isNotEmpty &&
                                              _priceText3.text.isNotEmpty) {
                                            Venta voVenta = Venta(
                                                vnNumero: int.parse(
                                                    _numberText3.text),
                                                vnPrecio:
                                                    int.parse(_priceText3.text),
                                                vnLoteId: item.vnId,
                                                vcLoteria: item.vcNombre);
                                            voVentList.add(voVenta);
                                          }
                                        }
                                        _ventaBloc.add(AgregarNumero(
                                            voVentList: voVentList,
                                            voLoteList: voLoteSele,
                                            vnPagoTota: vnTotalPrice));
                                      },
                                      child: Text(
                                        'Registrar',
                                        style: GoogleFonts.openSans(
                                            color: Colors.white),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  if (state is NumerosAAgregar) {
                    return SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Números A Agregar',
                                style: GoogleFonts.openSans(
                                    fontSize: 22, color: Colors.black)),
                            const Gap(8),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.voVentList.length,
                              itemBuilder: (BuildContext context, int vnIndex) {
                                var voVenta = state.voVentList[vnIndex];
                                String vcLoteria = '';
                                for (var voLote in voLoteList) {
                                  if (voLote.vnId == voVenta.vnLoteId) {
                                    vcLoteria = voLote.vcNombre;
                                  }
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
                                  child: ListTile(
                                    visualDensity: VisualDensity.compact,
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Número: ${voVenta.vnNumero}'),
                                        Text('Lotería: $vcLoteria',
                                            style: GoogleFonts.openSans(
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 24.0),
                                      child: Icon(
                                        Icons.sell,
                                        color: Colors.lightGreen,
                                        size: 40,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(CupertinoIcons.minus_circle, color: Colors.grey),
                                      onPressed: (){
                                        _ventaBloc.add(EliminarVenta(
                                            voVentList: voVentList,
                                            voVenta: voVenta,
                                            vnPagoTota: vnTotalPrice,
                                            voLoteList: voLoteList
                                        ));
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Gap(16),
                            Text('Total a Pagar: ${state.vnPagoTota}',
                                style: GoogleFonts.openSans(
                                    fontSize: 22, color: Colors.black)),
                            const Gap(24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightGreen,
                                      minimumSize: const Size(100, 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  onPressed: () {
                                    _ventaBloc.add(Atras2(voLoterias: voLoteSele));
                                  },
                                  child: const Text(
                                    'Atrás',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const Gap(16),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightGreen,
                                      minimumSize: const Size(100, 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  onPressed: () {
                                    _ventaBloc.add(EnviarVenta(
                                        voVentList: voVentList,
                                        vnUsuaId: _vnUsuaId));
                                  },
                                  child: const Text(
                                    'Finalizar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      BlocBuilder<LoteriaBloc, LoteriaState>(
                          builder: (context, state) {
                        if (state is LoteriasOk) {
                          voLoteList = state.voListLote;
                          if (voSeleList.length != state.voListLote.length) {
                            voSeleList = List.generate(
                                state.voListLote.length, (index) => false);
                          }
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                children: [
                                  const Gap(200),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:
                                          List.generate(state.voListLote.length,
                                              (vnIndeSele) {
                                        final voLoteria =
                                            state.voListLote[vnIndeSele];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ActionChip(
                                              side: const BorderSide(
                                                  color: Colors.transparent),
                                              backgroundColor:
                                                  voSeleList[vnIndeSele]
                                                      ? Colors.lightGreen
                                                      : Colors.grey,
                                              labelPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              label: Text(voLoteria.vcNombre,
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                              onPressed: () {
                                                if (voLoteSele
                                                    .contains(voLoteria)) {
                                                  voLoteSele.remove(voLoteria);
                                                } else {
                                                  voLoteSele.add(voLoteria);
                                                }
                                                setState(() {
                                                  voSeleList[vnIndeSele] =
                                                      !voSeleList[vnIndeSele];
                                                });
                                              }),
                                        );
                                      })),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 50),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightGreen,
                                            minimumSize: const Size(150, 55),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          if (voLoteSele.isNotEmpty) {
                                            _ventaBloc.add(AgregarLoteria(
                                                voLoterias: voLoteSele));
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
                                                fontSize: 20,
                                                color: Colors.white))),
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
            ),
          ));
        }
        return const Center();
      },
    );
  }
}
