import 'package:flutter/animation.dart';

class ColorUtils {
  Color darkBlueColor = HexColor('#020044');
  Color orangeColor = HexColor('#ff6666');
  Color lightBlueColor = HexColor('#3a366f');
  Color buttonBorderColor = HexColor('#4b487b');
  Color subTitleColor = HexColor('#aeadc5');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
