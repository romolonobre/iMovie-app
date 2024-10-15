import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IUIText {
  static Widget heading(String label,
      {double fontsize = 16,
      bool isNumber = false,
      Color color = Colors.white,
      FontWeight fontWeight = FontWeight.w500,
      TextAlign textAlign = TextAlign.left,
      int? maxLines,
      TextOverflow? overflow}) {
    return Text(
      label,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: fontsize,
          fontWeight: fontWeight,
          color: color,
          overflow: overflow,
        ),
      ),
    );
  }

  static Widget title(
    String label, {
    double fontsize = 26,
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.w600,
    TextAlign textAlign = TextAlign.left,
  }) {
    return Text(
      label,
      textAlign: textAlign,
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: fontsize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
