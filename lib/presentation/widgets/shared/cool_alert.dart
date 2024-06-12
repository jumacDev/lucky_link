import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

void showCoolAlert(BuildContext context, CoolAlertType type, String vcTitle, String vcMensaje) {
  CoolAlert.show(
    context: context,
    type: type,
    title: vcTitle,
    text: vcMensaje,
    textTextStyle: const TextStyle(fontSize: 15, color: Colors.black),
    confirmBtnColor: Colors.lightGreen,
    backgroundColor: Colors.lightGreen,
    width: 200
  );
}