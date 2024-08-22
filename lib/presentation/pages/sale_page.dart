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
  final TextEditingController _numberText4 = TextEditingController();
  final TextEditingController _priceText4 = TextEditingController();
  final TextEditingController _numberText5 = TextEditingController();
  final TextEditingController _priceText5 = TextEditingController();
  final TextEditingController _numberText6 = TextEditingController();
  final TextEditingController _priceText6 = TextEditingController();
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
  int tempValue4 = 0;
  int tempValue5 = 0;
  int tempValue6 = 0;

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
      vnTotalPrice = (tempValue1 + tempValue2 + tempValue3 + tempValue4 + tempValue5 + tempValue6) * voLoteSele.length;
    });
  }

  _clearText() {
    _priceText.clear();
    _priceText2.clear();
    _priceText3.clear();
    _priceText4.clear();
    _priceText5.clear();
    _priceText6.clear();
    _numberText.clear();
    _numberText2.clear();
    _numberText3.clear();
    _numberText4.clear();
    _numberText5.clear();
    _numberText6.clear();
    vnTotalPrice = 0;
  }

  _clearPrice(){
    vnTotalPrice = 0;
    tempValue1 = 0;
    tempValue2 = 0;
    tempValue3 = 0;
    tempValue4 = 0;
    tempValue5 = 0;
    tempValue6 = 0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    debugPrint('width: ${size.width}');
    debugPrint('height: ${size.height}');

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginOk) {
          _vnUsuaId = state.voSesion.vnUsuario;
          return SingleChildScrollView(
            //physics: size.height < 870 ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
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
                                                fontSize: 22),
                                          ),
                                        ),
                                        const Gap(8),
                                        SizedBox(
                                          width: 170,
                                          height: 80,
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
                                                textInputAction: TextInputAction.next,
                                                keyboardType: TextInputType.number,
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
                                          width: 170,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 50),
                                            child: TextFormField(
                                                buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                                                  return null;
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                maxLength: 4,
                                                textInputAction: TextInputAction.next,
                                                keyboardType: TextInputType.number,
                                                onTapOutside: _onTapOutside,
                                                controller: _numberText2,
                                                decoration: InputDecoration(
                                                  labelStyle:
                                                      GoogleFonts.openSans(color: Colors.black),
                                                  labelText: 'Número',
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 170,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 50),
                                            child: TextFormField(
                                                buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                                                  return null;
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                maxLength: 4,
                                                keyboardType: TextInputType.number,
                                                textInputAction: TextInputAction.next,
                                                onTapOutside: _onTapOutside,
                                                controller: _numberText3,
                                                decoration: InputDecoration(
                                                  labelText: 'Número',
                                                  labelStyle:
                                                      GoogleFonts.openSans(
                                                          color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 170,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                            child: TextFormField(
                                                buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                                                  return null;
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                maxLength: 4,
                                                keyboardType: TextInputType.number,
                                                textInputAction: TextInputAction.next,
                                                onTapOutside: _onTapOutside,
                                                controller: _numberText4,
                                                decoration: InputDecoration(
                                                  labelText: 'Número',
                                                  labelStyle:
                                                  GoogleFonts.openSans(
                                                      color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 170,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 50),
                                            child: TextFormField(
                                                buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                                                  return null;
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                maxLength: 4,
                                                keyboardType: TextInputType.number,
                                                textInputAction: TextInputAction.next,
                                                onTapOutside: _onTapOutside,
                                                controller: _numberText5,
                                                decoration: InputDecoration(
                                                  labelText: 'Número',
                                                  labelStyle: GoogleFonts.openSans(
                                                      color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 170,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 50),
                                            child: TextFormField(
                                                buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                                                  return null;
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                maxLength: 4,
                                                keyboardType: TextInputType.number,
                                                onTapOutside: _onTapOutside,
                                                controller: _numberText6,
                                                decoration: InputDecoration(
                                                  labelText: 'Número',
                                                  labelStyle: GoogleFonts.openSans(
                                                      color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                                  fontSize: 22)),
                                        ),
                                        const Gap(8),
                                        SizedBox(
                                          width: 190,
                                          height: 80,
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
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textInputAction: TextInputAction.next,
                                                onTapOutside: _onTapOutside,
                                                keyboardType: TextInputType.number,
                                                controller: _priceText,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle: GoogleFonts.openSans(
                                                          color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 190,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                            child: TextFormField(
                                                onChanged: (value) {
                                                  if (value.length >= 3 && value.length <= 4) {
                                                    tempValue2 = int.parse(value);
                                                  } else {
                                                    tempValue2 = 0;
                                                  }
                                                  _updateTotalPrice();
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textInputAction: TextInputAction.next,
                                                onTapOutside: _onTapOutside,
                                                keyboardType: TextInputType.number,
                                                controller: _priceText2,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle: GoogleFonts.openSans(
                                                          color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 190,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                            child: TextFormField(
                                                onChanged: (value) {
                                                  if (value.length >= 3 && value.length <= 4) {
                                                    tempValue3 = int.parse(value);
                                                  } else {
                                                    tempValue3 = 0;
                                                  }
                                                  _updateTotalPrice();
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                onTapOutside: _onTapOutside,
                                                keyboardType: TextInputType.number,
                                                textInputAction: TextInputAction.next,
                                                controller: _priceText3,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle: GoogleFonts.openSans(
                                                          color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 190,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 60),
                                            child: TextFormField(
                                                onChanged: (value) {
                                                  if (value.length >= 3 && value.length <= 4) {
                                                    tempValue4 = int.parse(value);
                                                  } else {
                                                    tempValue4 = 0;
                                                  }
                                                  _updateTotalPrice();
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                onTapOutside: _onTapOutside,
                                                keyboardType: TextInputType.number,
                                                textInputAction: TextInputAction.next,
                                                controller: _priceText4,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle: GoogleFonts.openSans(
                                                      color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 190,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 60),
                                            child: TextFormField(
                                                onChanged: (value) {
                                                  if (value.length >= 3 && value.length <= 4) {
                                                    tempValue5 = int.parse(value);
                                                  } else {
                                                    tempValue5 = 0;
                                                  }
                                                  _updateTotalPrice();
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                onTapOutside: _onTapOutside,
                                                keyboardType: TextInputType.number,
                                                textInputAction: TextInputAction.next,
                                                controller: _priceText5,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle: GoogleFonts.openSans(
                                                      color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                          width: 190,
                                          height: 80,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                            child: TextFormField(
                                                onChanged: (value) {
                                                  if (value.length >= 3 && value.length <= 4) {
                                                    tempValue6 = int.parse(value);
                                                  } else {
                                                    tempValue6 = 0;
                                                  }
                                                  _updateTotalPrice();
                                                },
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                onTapOutside: _onTapOutside,
                                                keyboardType: TextInputType.number,
                                                controller: _priceText6,
                                                decoration: InputDecoration(
                                                  labelText: 'Valor',
                                                  labelStyle: GoogleFonts.openSans(
                                                      color: Colors.black),
                                                  isDense: true,
                                                  border: const OutlineInputBorder(),
                                                  focusedBorder: const OutlineInputBorder(
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
                                    ),
                                  )
                                ],
                              ),
                              const Gap(16),
                              //total
                              FadeIn(
                                child: Center(
                                    child: Text(
                                        "Total a pagar: ${vnTotalPrice.toString()}",
                                        style: GoogleFonts.openSans(
                                            color: Colors.black))),
                              ),
                              const Gap(24),
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
                                              if (_numberText4.text.isNotEmpty &&
                                                  _priceText4.text.isNotEmpty) {
                                                Venta voVenta = Venta(
                                                    vnNumero: int.parse(
                                                        _numberText4.text),
                                                    vnPrecio: int.parse(
                                                        _priceText4.text),
                                                    vnLoteId: item.vnId,
                                                    vcLoteria: item.vcNombre);
                                                voVentList.add(voVenta);
                                              }
                                              if (_numberText5.text.isNotEmpty &&
                                                  _priceText5.text.isNotEmpty) {
                                                Venta voVenta = Venta(
                                                    vnNumero: int.parse(
                                                        _numberText5.text),
                                                    vnPrecio: int.parse(
                                                        _priceText5.text),
                                                    vnLoteId: item.vnId,
                                                    vcLoteria: item.vcNombre);
                                                voVentList.add(voVenta);
                                              }
                                              if (_numberText6.text.isNotEmpty &&
                                                  _priceText6.text.isNotEmpty) {
                                                Venta voVenta = Venta(
                                                    vnNumero: int.parse(
                                                        _numberText6.text),
                                                    vnPrecio: int.parse(
                                                        _priceText6.text),
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
                            padding: const EdgeInsets.only(bottom: 48.0, top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Números A Agregar',
                                    style: GoogleFonts.openSans(
                                        fontSize: 20, color: Colors.black)),
                                const Gap(8),
                                FadeIn(
                                  child: SizedBox(
                                    height: size.height < 670? size.height * 0.51 :
                                    size.height >= 670 && size.height < 740? size.height * 0.52 :
                                    size.height >= 740 && size.height < 840? size.height * 0.5 :
                                    size.height == 844 || size.height == 812 ? size.height * 0.54 :
                                    size.height == 825? size.height * 0.61 :
                                    size.height >= 854 && size.height < 890 || size.height == 960? size.height * 0.65 :
                                    size.height == 916? size.height * 0.58 : size.height * 0.59,
                                    child: ListView.builder(
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 32),
                                          child: FadeIn(
                                            child: ListTile(
                                              visualDensity: VisualDensity.compact,
                                              dense: true,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                                              title: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Número: ${voVenta.vnNumero}'),
                                                  Text('Lotería: $vcLoteria')
                                                ],
                                              ),
                                              subtitle: Text('Precio: ${voVenta.vnPrecio}'),
                                              subtitleTextStyle: GoogleFonts.openSans(
                                                  fontSize: 11,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w100),
                                              titleTextStyle: GoogleFonts.openSans(
                                                  fontSize: 11,
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
                                ),
                                const Gap(16),
                                FadeIn(
                                  child: Text('Total a Pagar: ${state.vnPagoTota}',
                                      style: GoogleFonts.openSans(
                                          fontSize: 20, color: Colors.black)),
                                ),
                                const Gap(16),
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
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                    const Gap(8),
                                                    SizedBox(
                                                      height: 30,
                                                      width: size.width * 0.95,
                                                      child: Center(
                                                        child: ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          shrinkWrap: true,
                                                          itemCount: state.voListBloq.length,
                                                          itemBuilder: (BuildContext context, int vnIndex) {
                                                            return SizedBox(
                                                              width: 80,
                                                              height: 16,
                                                              child: ListTile(
                                                                visualDensity: VisualDensity.compact,
                                                                dense: true,
                                                                title: Text(
                                                                  '${state.voListBloq[vnIndex].vnNumero}',
                                                                  style: GoogleFonts.openSans(
                                                                      fontSize: 14,
                                                                      color: Colors.black),
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                ),
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
                                      const Gap(50),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                        child: GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 6,
                                            childAspectRatio: 1.2,
                                          ),
                                          itemCount: state.voListLote.length,
                                          itemBuilder: (BuildContext context, int vnIndeSele) {
                                            final voLoteria = state.voListLote[vnIndeSele];
                                            return ActionChip(
                                              side: const BorderSide(color: Colors.transparent),
                                              backgroundColor: voSeleList[vnIndeSele] ? Colors.lightGreen : Colors.grey,
                                              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                                              label: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                      child: FadeInImage(
                                                        placeholder: const NetworkImage('https://technometrics.net/wp-content/uploads/2020/11/loading-icon-animated-gif-19-1.gif'),
                                                        image: NetworkImage('https://drive.google.com/uc?export=view&id=${voLoteria.vcUrlLogo}'),
                                                        width: 85,
                                                      )
                                                  ),
                                                  const Gap(8),
                                                  Text(
                                                    voLoteria.vcNombre,
                                                    style: GoogleFonts.openSans(fontSize: 12, color: Colors.white),
                                                  ),
                                                  Text(
                                                    'Cierre: ${voLoteria.vcCierre}',
                                                    style: GoogleFonts.openSans(fontSize: 12, color: Colors.white),
                                                  ),

                                                ],
                                              ),
                                              onPressed: () {
                                                if (voLoteSele.contains(voLoteria)) {
                                                  voLoteSele.remove(voLoteria);
                                                } else {
                                                  voLoteSele.add(voLoteria);
                                                }
                                                setState(() {
                                                  voSeleList[vnIndeSele] = !voSeleList[vnIndeSele];
                                                });
                                              },
                                            );
                                            },
                                        ),
                                      ),

                                    ],
                                  ));
                            }
                            return const Center();
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:  30, horizontal: 100),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightGreen,
                                maximumSize: const Size(155, 85),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
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
