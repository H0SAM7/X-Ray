import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  static TextStyle poppinsStylebold20 = TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold);


 static TextStyle style12=TextStyle(
      fontSize: 12,
      color: Colors.black.withOpacity(.5),
      fontFamily: GoogleFonts.poppins().fontFamily,
    );  
    static TextStyle styleMeduim24=TextStyle(
      fontSize: 24,
    fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.rubik().fontFamily,
    );  
       
}
