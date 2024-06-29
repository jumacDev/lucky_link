import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCoolAlert(BuildContext context, CoolAlertType type, String vcTitle, String vcMensaje) {
  CoolAlert.show(
    context: context,
    type: type,
    title: vcTitle,
    text: vcMensaje,
    textTextStyle: GoogleFonts.openSans(fontSize: 14, color: Colors.black),
    titleTextStyle: GoogleFonts.openSans(fontSize: 12, color: Colors.black),
    confirmBtnColor: Colors.lightGreen,
    backgroundColor: Colors.lightGreen,
    width: 200
  );
}