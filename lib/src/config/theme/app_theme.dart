import '../../global_export.dart';

class FCThemeData{
  const FCThemeData._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: FCStrings.IBM_PLEX_SANS,
    brightness: Brightness.light,
    scaffoldBackgroundColor: FCColors.white,
    textTheme: FCTextTheme.lightTextTheme,
    inputDecorationTheme: FCInputDecorationTheme.lightInputDecorationTheme,
    appBarTheme: FCAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: FCColors.transparent),
    elevatedButtonTheme: FCElevatedButtonTheme.lightElevatedButtonTheme
  );


  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: FCStrings.IBM_PLEX_SANS,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: FCColors.black,
    textTheme: FCTextTheme.darkTextTheme,
    inputDecorationTheme: FCInputDecorationTheme.darkInputDecorationTheme,
    appBarTheme: FCAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: FCColors.transparent),
    elevatedButtonTheme: FCElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
