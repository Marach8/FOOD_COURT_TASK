import '../../../global_export.dart';

class FCTextTheme{
  const FCTextTheme._();

  static TextTheme lightTextTheme = TextTheme( 
    headlineLarge: TextStyle(
      color: FCColors.hex1B1B1B,
      fontSize: FCFontSizes.size28,
      fontWeight: FCFontWeights.w700,
      overflow: TextOverflow.ellipsis,
    ),


    headlineMedium: TextStyle(
      color: FCColors.hex1B1B1B,
      fontSize: FCFontSizes.size20,
      fontWeight: FCFontWeights.w700,
      overflow: TextOverflow.ellipsis,
    ),


    titleSmall: TextStyle(
      color: FCColors.hex1B1B1B,
      fontSize: FCFontSizes.size16,
      fontWeight: FCFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),

    
    bodySmall: TextStyle(
      color: FCColors.hex1B1B1B,
      fontSize: FCFontSizes.size14,
      fontWeight: FCFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
    
    labelMedium: TextStyle(
      color: FCColors.hex1B1B1B,
      fontSize: FCFontSizes.size12,
      fontWeight: FCFontWeights.w400,
      overflow: TextOverflow.ellipsis,
    ),
  );



  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle(
      color: FCColors.white,
      fontSize: FCFontSizes.size28,
      fontWeight: FCFontWeights.w700,
      overflow: TextOverflow.ellipsis,
    ),

    headlineMedium: TextStyle(
      color: FCColors.white,
      fontSize: FCFontSizes.size20,
      fontWeight: FCFontWeights.w700,
      overflow: TextOverflow.ellipsis,
    ),

    titleSmall: TextStyle(
      color: FCColors.white,
      fontSize: FCFontSizes.size16,
      fontWeight: FCFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),

    bodySmall: TextStyle(
      color: FCColors.white,
      fontSize: FCFontSizes.size14,
      fontWeight: FCFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),

    labelMedium: TextStyle(
      color: FCColors.white,
      fontSize: FCFontSizes.size10,
      fontWeight: FCFontWeights.w400,
      overflow: TextOverflow.ellipsis,
    ),
  );
}