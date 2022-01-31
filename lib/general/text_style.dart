
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle generalTextStyle({color, fontSize, fontStyle, fontWeight, fontFamily}) {
    return TextStyle(
        color: color,
        fontSize: fontSize ?? 14.0,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? 'PT Sans'
    );
  }
}