import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
const Color primaryBlue = Color.fromARGB(255, 8, 86, 223);
const Color primaryWhite = Color.fromARGB(255, 250, 250, 254);
const Color primaryBlack=Colors.black;
const Color rama=Color.fromARGB(255, 110, 255, 238);
const Color teal=Colors.teal;
const Color grey=Colors.grey;
const Color lightBlue = Colors.lightBlue;
const Color transparent = Colors.transparent;
var textFiledPadding=const EdgeInsets.all(8.0) as EdgeInsetsGeometry;
mainFont({required double fontSize, Color color=Colors.teal,FontWeight fontWeight=FontWeight.normal}){
  return GoogleFonts.roboto(fontSize: fontSize,color: color,fontWeight:fontWeight);
}