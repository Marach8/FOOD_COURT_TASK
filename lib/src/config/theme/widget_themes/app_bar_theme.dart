import '../../../global_export.dart';

class FCAppBarTheme{
  const FCAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: FCColors.white,
    titleTextStyle: TextStyle(
      color: FCColors.hex1B1B1B,
      fontSize: FCFontSizes.size16,
      fontWeight: FCFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
  );


  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: FCColors.black,
    titleTextStyle: TextStyle(
      color: FCColors.white,
      fontSize: FCFontSizes.size16,
      fontWeight: FCFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
