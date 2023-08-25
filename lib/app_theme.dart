import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
       color: Colors.black
        ),
      ),
    ),
  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
       color: Colors.black
        ),
      ),
    ),
  );

}
