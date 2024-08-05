import 'package:flutter/material.dart';

part 'color_constant.dart';
part 'grid_constants.dart';
part 'text_constants.dart';

class AppTheme {
  AppTheme._();

  static const fontFamily = "FCIconic";

  static ThemeData defaultTheme = ThemeData(
    textTheme: _textTheme,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: ColorConstant.primaryBackground,
    iconTheme: _iconTheme,
  );

  //text Theme
  static final TextTheme _textTheme = TextConstants.textTheme;

  //icon Theme
  static const _iconTheme = IconThemeData(
    color: ColorConstant.textStrongOnDark,
  );
}
