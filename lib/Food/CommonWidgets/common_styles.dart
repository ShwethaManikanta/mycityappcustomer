import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonStyles {
  CommonStyles._();

  static textFieldStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      letterSpacing: 0.3,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ));
  }

  static whiteText15BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static black1254thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.w400));
  }

  static enterYourNumberTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[600],
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }

  static otpVerificationMessage() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[800],
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w500,
    ));
  }

  static whiteText12BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static whiteText10BoldW400() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static whiteText8BoldW400() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static whiteText16BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static blueText12BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.19,
            color: Colors.blue,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static black57S18() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black54));
  }

  static blackS15() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black));
  }

  static black57S14() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black45));
  }

  static black57S12W500() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black45));
  }

  static black12() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black));
  }

  static black11() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 11, color: Colors.black));
  }

  static blue11() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 10, color: Colors.blue));
  }

  static blue13() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.blue));
  }

  static blue14Accent() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.blueAccent));
  }

  static green9() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 9, color: Colors.green));
  }

  static black13() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black));
  }

  static black13Thin() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black));
  }

  static black10LineThrough() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: Colors.black,
            decoration: TextDecoration.lineThrough));
  }

  static black10Thin() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      color: Colors.black,
    ));
  }

  static black54s10Thin() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      color: Colors.black54,
    ));
  }

  static red12() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: Colors.red));
  }

  static black12thin() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black54));
  }

  static blue12thin() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.blue));
  }

  static blackw54s9Thin() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 9,
      color: Colors.black54,
    ));
  }

  static blackw54s20Thin() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color.fromARGB(255, 36, 22, 22),
    ));
  }

  static blackw54s9ThinUnderline() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 9,
            color: Colors.black54,
            decoration: TextDecoration.underline));
  }

  static loginTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.5,
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat'));
  }

  static submitTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[900],
      letterSpacing: 0.2,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ));
  }

  static bold18TextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown,
      letterSpacing: 0.2,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ));
  }

  static genderTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[900],
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ));
  }

  static sendOTPButtonTextStyle() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 0.15,
      // backgroundColor: Colors.transparent,
      fontSize: 16,
      fontWeight: FontWeight.w900,
    ));
  }

  static errorTextStyleStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 13,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static normalText() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static labelTextSyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[600],
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }

  static labelTextSyleWhite() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }
}
