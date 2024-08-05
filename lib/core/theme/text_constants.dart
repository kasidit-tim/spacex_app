part of "theme.dart";

class TextConstants {
  TextConstants._();

  static final TextTheme textTheme = TextTheme(
    displayLarge: _displayLarge,
    displayMedium: _displayMedium,
    displaySmall: _displaySmall,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
    bodySmall: _bodySmall,
    labelLarge: _labelLarge,
    labelMedium: _labelMedium,
    labelSmall: _labelSmall,
    titleLarge: _titleLarge,
    titleMedium: _titleMedium,
    titleSmall: _titleSmall,
    headlineLarge: _headlineLarge,
    headlineMedium: _headlineMedium,
    headlineSmall: _headlineSmall,
  );

  static const fontFamily = "FCIconic";

  static const _displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 44,
    fontWeight: FontWeight.w500,
    color: ColorConstant.textStrongOnDark,
  );
  static final _displayMedium = _displayLarge.copyWith(fontSize: 40);
  static final _displaySmall = _displayLarge.copyWith(fontSize: 36);

  static const _headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: ColorConstant.textStrongOnDark,
  );
  static final _headlineMedium = _headlineLarge.copyWith(fontSize: 28);
  static final _headlineSmall = _headlineLarge.copyWith(fontSize: 24);

  static const _titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: ColorConstant.textStrongOnDark,
  );
  static final _titleMedium = _titleLarge.copyWith(fontSize: 20);
  static final _titleSmall = _titleLarge.copyWith(fontSize: 16);

  static const _bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: ColorConstant.textStrongOnDark,
  );
  static final _bodyMedium = _bodyLarge.copyWith(fontSize: 14);
  static final _bodySmall = _bodyLarge.copyWith(fontSize: 12);

  static const _labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorConstant.textStrongOnDark,
  );
  static final _labelMedium = _labelLarge.copyWith(fontSize: 14);
  static final _labelSmall = _labelLarge.copyWith(fontSize: 12);
}
