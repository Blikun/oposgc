import 'package:flutter/material.dart';

///colores ui
const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);
final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);
final kguardiacivil = Color.fromARGB(255, 0, 115, 80);

///texto respuestas tests
var color_standard = Colors.grey[800];
var color_correcto = Colors.lightGreen[900];
var color_error = Colors.red[900];
var color_desactivado = Colors.grey[400];
var color_respuesta_elegida = Colors.grey[800];


///espaciador para los flex
Widget space(int flex) {
  return Expanded(flex: flex, child: Container());
}