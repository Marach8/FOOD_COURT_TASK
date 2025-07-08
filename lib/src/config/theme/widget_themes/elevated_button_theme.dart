
import '../../../global_export.dart';

class FCElevatedButtonTheme{
  const FCElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: FCColors.white,
      backgroundColor: FCColors.hex1B1B1B,
      disabledForegroundColor: FCColors.white.withValues(alpha: 0.3),
      disabledBackgroundColor: FCColors.transparent,
      textStyle: const TextStyle(
        fontFamily: FCStrings.IBM_PLEX_SANS,
        fontSize: FCFontSizes.size18,
        fontWeight: FCFontWeights.w600
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
    )
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: FCColors.hex1B1B1B,
      backgroundColor: FCColors.white,
      disabledForegroundColor: FCColors.hex1B1B1B.withValues(alpha: 0.3),
      disabledBackgroundColor: FCColors.transparent,
      textStyle: const TextStyle(
        fontFamily: FCStrings.IBM_PLEX_SANS,
        fontSize: FCFontSizes.size18,
        fontWeight: FCFontWeights.w600
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
    )
  );
}