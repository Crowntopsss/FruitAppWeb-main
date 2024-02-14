import "package:flutter/material.dart";

//0xFF05B8CC
class ColorPath {
  static const MAIN_COLOR = Colors.black;
  static  const DARK_COLOR = Color(0xFFF1C40F);
  static  const DARK_COLOR_TWO = Color(0xFFF1C40F);
  static const ACCENT_COLOR = Color(0xFFA8AAAC);


  static const OFF_WHITE = Color(0xffF9FAFB);
  static const BLACK = Colors.black;
  static const GREY = Colors.grey;
  static const GREEN = Color(0xFFCED5C7);
  static const BLUE = Color(0xFFA76AF3);
  static const YELLOW = Color(0xFFF2C94C);
  static const BRICK  = Color(0xFF163A21);

  static const TEXT_FIELD_BACKGROUND = Color(0xFFF6F6F7);


  static const grey3 = Color(0xffC4D5ED);
  static const grey4 = Color(0xffD8E3F3);
  static const grey6 = Color(0xffF7F9FD);

  static const MaterialColor WHITE_CUSTOM = MaterialColor(
    _whitePrimaryValue,
    <int, Color>{
      50: Color(0xffffffff),
      100: Color(0xffffffff),
      200: Color(0xffffffff),
      300: Color(0xffffffff),
      400: Color(0xffffffff),
      500: Color(_whitePrimaryValue),
      600: Color(0xffffffff),
      700: Color(0xffffffff),
      800: Color(0xffffffff),
      900: Color(0xffffffff),
    },
  );
  static const WHITE = Color(0xffffffff);
  static const int _whitePrimaryValue = 0xFFFFFFFF;

  static const MaterialColor BLACK_CUSTOM = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int _blackPrimaryValue = 0xFF000000;
}


