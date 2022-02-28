import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

custom_textStyle(double size,[Color? color,FontWeight? fontWeight]){

  return GoogleFonts.poppins(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
    decoration: TextDecoration.none,
  );

}