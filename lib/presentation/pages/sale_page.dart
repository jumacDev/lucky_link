import 'package:animate_do/animate_do.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  late BloqueoBloc _bloqueoBloc;
  DateTime? _vdFechSele;
  final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  String _vcFecha = '';
  int tempValue1 = 0;
  int tempValue2 = 0;
  int tempValue3 = 0;

  @override
  void initState() {
    super.initState();
    _ventaBloc = context.read<VentaBloc>();
    _bloqueoBloc = context.read<BloqueoBloc>();
    _vdFechSele = DateTime.now();
    _vcFecha = _dateFormat.format(_vdFechSele!);
    _bloqueoBloc.add(ObtenerBloqueos(vcFecha: _vcFecha));
  }

  _onTapOutside(pointer) {
    final FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus && focus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void _updateTotalPrice() {
    setState(() {
      vnTotalPrice = (tempValue1 + tempValue2 + tempValue3) * voLoteSele.length;
    });
  }

  _clearText() {
    _priceText.clear();
    _priceText2.clear();
    _priceText3.clear();
    _numberText.clear();
    _numberText2.clear();
    _numberText3.clear();
    vnTotalPrice = 0;
  }

  _clearPrice(){
    vnTotalPrice = 0;
    tempValue1 = 0;
    tempValue2 = 0;
    tempValue3 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginOk) {
          _vnUsuaId = state.voSesion.vnUsuario;
          return SingleChildScrollView(
            child: BlocListener<VentaBloc, VentaState>(
              listener: (context, state) async {
                if (state is VentaError) {
                  _showAlert(CoolAlertType.error,
                      'No se pudo realizar la venta', state.vcMensaje);
                  await Future.delayed(const Duration(seconds: 2));
                  _ventaBloc.add(LogOutVenta());
                  _clearText();
                  _clearPrice();
                }
                if (state is VentaConfirmada) {
                  _showAlert(
                      CoolAlertType.success, 'Venta Exitosa', state.vcMensaje);
                  await Future.delayed(const Duration(seconds: 2));
                  _ventaBloc.add(LogOutVenta());
                  _clearText();
                  _clearPrice();
                }
                if (state is VentaInitial) {
                  voSeleList.clear();
                  voVentList.clear();
                  voLoteSele.clear();
                }
              },
              child: BlocBuilder<VentaBloc, VentaState>(
                builder: (context, state) {
                  if (state is LoteriaSeleccionada) {
                    voVentList.clear();
                    return FadeIn(
                      child: Column(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            children: [
                              const Gap(20),
                              //inputs
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Números
                                  FadeIn(
                                    child: Column(
                                      children: [
                                        const Gap(8),
                                        Center(
                                          child: Text(
                                            "Número",
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontSize: 24),
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
                                                buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                                                  return null;
                                                },
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                maxLength: 4,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.number,
                                                onTapOutside: _onTapOutside,
                                                controller: _numberText,
                                                decoration: InputDecoration(
                                                  labelStyle:
                                                      GoogleFonts.openSans(
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
                                                buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                                                  return null;
                                                },
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                maxLength: 4,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.number,
                                                onTapOutside: _onTapOutside,
                                                controller: _numberText2,
                                                decoration: InputDecoration(
                                                  labelStyle:
                                                      GoogleFonts.openSans(
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
                                                buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                                                  return null;
                                                },
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                maxLength: 4,
                                                keyboardType:
                                                    TextInputType.number,
                                                onTapOutside: _onTapOutside,
                                                controller: _numberText3,
                                                decoration: InputDecoration(
                                                  labelText: 'Número',
                                                  labelStyle:
                                                      GoogleFonts.openSans(
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
                                  ),
                                  //Precios
                                  FadeIn(
                                    child: Column(
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
                                                onChanged: (value) {
                                                  if (value.length >= 3 && value.length <= 4) {
                                                    tempValue1 = int.parse(value);
                                                  } else {
                                                    tempValue1 = 0;
                                                  }
                                                  _updateTotalPrice();
                                                },
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onTapOutside: _onTapOutside,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: _priceText,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle:
                                                      GoogleFonts.openSans(
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
                                                      3) {
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
                                                onChanged: (value) {
                                                  if (value.length >= 3 && value.length <= 4) {
                                                    tempValue2 = int.parse(value);
                                                  } else {
                                                    tempValue2 = 0;
                                                  }
                                                  _updateTotalPrice();
                                                },
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onTapOutside: _onTapOutside,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: _priceText2,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle:
                                                      GoogleFonts.openSans(
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
                                        SizedBox(
                                          width: 200,
                                          height: 90,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 60),
                                            child: TextFormField(
                                                onChanged: (value) {
                                                  if (value.length >= 3 && value.length <= 4) {
                                                    tempValue3 = int.parse(value);
                                                  } else {
                                                    tempValue3 = 0;
                                                  }
                                                  _updateTotalPrice();
                                                },
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                onTapOutside: _onTapOutside,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: _priceText3,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle:
                                                      GoogleFonts.openSans(
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
                                  )
                                ],
                              ),
                              const Gap(24),
                              //total
                              FadeIn(
                                child: Center(
                                    child: Text(
                                        "Total a pagar: ${vnTotalPrice.toString()}",
                                        style: GoogleFonts.openSans(
                                            color: Colors.black))),
                              ),
                              const Gap(32),
                              //botones
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeIn(
                                    child: Container(
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
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: FadeIn(
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
                                                    vnNumero: int.parse(
                                                        _numberText.text),
                                                    vnPrecio: int.parse(
                                                        _priceText.text),
                                                    vnLoteId: item.vnId,
                                                    vcLoteria: item.vcNombre);
                                                voVentList.add(voVenta);
                                              }
                                              if (_numberText2.text.isNotEmpty &&
                                                  _priceText2.text.isNotEmpty) {
                                                Venta voVenta = Venta(
                                                    vnNumero: int.parse(
                                                        _numberText2.text),
                                                    vnPrecio: int.parse(
                                                        _priceText2.text),
                                                    vnLoteId: item.vnId,
                                                    vcLoteria: item.vcNombre);
                                                voVentList.add(voVenta);
                                              }
                                              if (_numberText3.text.isNotEmpty &&
                                                  _priceText3.text.isNotEmpty) {
                                                Venta voVenta = Venta(
                                                    vnNumero: int.parse(
                                                        _numberText3.text),
                                                    vnPrecio: int.parse(
                                                        _priceText3.text),
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
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is NumerosAAgregar) {
                    return FadeIn(
                      child: FadeIn(
                        child: SingleChildScrollView(
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
                                FadeIn(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.voVentList.length,
                                    itemBuilder:
                                        (BuildContext context, int vnIndex) {
                                      var voVenta = state.voVentList[vnIndex];
                                      String vcLoteria = '';
                                      for (var voLote in voLoteList) {
                                        if (voLote.vnId == voVenta.vnLoteId) {
                                          vcLoteria = voLote.vcNombre;
                                        }
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 32),
                                        child: FadeIn(
                                          child: ListTile(
                                            visualDensity: VisualDensity.compact,
                                            dense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Número: ${voVenta.vnNumero}'),
                                                Text('Lotería: $vcLoteria',
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400)),
                                              ],
                                            ),
                                            subtitle:
                                                Text('Precio: ${voVenta.vnPrecio}'),
                                            subtitleTextStyle: GoogleFonts.openSans(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w100),
                                            titleTextStyle: GoogleFonts.openSans(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                            leading: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0),
                                              child: Icon(
                                                Icons.sell,
                                                color: Colors.lightGreen,
                                                size: 40,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              icon: const Icon(
                                                  CupertinoIcons.minus_circle,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                _ventaBloc.add(EliminarVenta(
                                                    voVentList: voVentList,
                                                    voVenta: voVenta,
                                                    vnPagoTota: state.vnPagoTota,
                                                    voLoteList: voLoteList));
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Gap(16),
                                FadeIn(
                                  child: Text('Total a Pagar: ${state.vnPagoTota}',
                                      style: GoogleFonts.openSans(
                                          fontSize: 22, color: Colors.black)),
                                ),
                                const Gap(24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeIn(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightGreen,
                                            minimumSize: const Size(100, 40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          _ventaBloc
                                              .add(Atras2(voLoterias: voLoteSele));
                                        },
                                        child: const Text(
                                          'Atrás',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Gap(16),
                                    FadeIn(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightGreen,
                                            minimumSize: const Size(100, 40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
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
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return FadeIn(
                    child: Column(
                      children: [
                        BlocBuilder<LoteriaBloc, LoteriaState>(
                            builder: (context, state) {
                          if (state is LoteriasOk) {
                            vnTotalPrice = 0;
                            voLoteList = state.voListLote;
                            if (voSeleList.length != state.voListLote.length) {
                              voSeleList = List.generate(
                                  state.voListLote.length, (index) => false);
                            }
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    BlocBuilder<BloqueoBloc, BloqueoState>(
                                        builder: (context, state) {
                                      if (state is BloqueoOk) {
                                        return state.voListBloq.isEmpty
                                            ? const Center()
                                            : FadeIn(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Gap(8),
                                                    Text(
                                                      'Numeros Bloqueados Hoy:',
                                                      style: GoogleFonts.openSans(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Gap(8),
                                                    SizedBox(
                                                      height: 70,
                                                      child: Center(
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: state
                                                              .voListBloq.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int vnIndex) {
                                                            return ListTile(
                                                              title: Text(
                                                                '${state.voListBloq[vnIndex].vnNumero}',
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                      }
                                      return const Center();
                                    }),
                                    const Gap(80),
                                    FadeIn(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 0,
                                            crossAxisSpacing: 0,
                                            childAspectRatio: 3,
                                          ),
                                          itemCount: state.voListLote.length,
                                          itemBuilder: (BuildContext context,
                                              int vnIndeSele) {
                                            final voLoteria =
                                                state.voListLote[vnIndeSele];
                                            return FadeIn(
                                              child: Center(
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
                                                  label: Text(
                                                    voLoteria.vcNombre,
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
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
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    FadeIn(
                                      child: Padding(
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
                                    ),
                                  ],
                                ));
                          }
                          return const Center();
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return const Center();
      },
    );
  }

  void _showAlert(CoolAlertType type, String pcTitle, String pcMensaje) {
    showCoolAlert(context, type, pcTitle, pcMensaje);
  }
}
