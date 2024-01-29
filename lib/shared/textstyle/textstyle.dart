import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

class TextStyleConstant {
  static TextStyle textPurple =
      GoogleFonts.poppins(color: ColorConstant.purple);
  static TextStyle textBlack = GoogleFonts.poppins(color: ColorConstant.black);
  static TextStyle textYellow =
      GoogleFonts.poppins(color: ColorConstant.yellow);
  static TextStyle textWhite = GoogleFonts.poppins(color: ColorConstant.white);
  static TextStyle textRed = GoogleFonts.poppins(color: ColorConstant.red);
  static TextStyle textBlue = GoogleFonts.poppins(color: ColorConstant.blue);
  static TextStyle textGreen = GoogleFonts.poppins(color: ColorConstant.green);
}
