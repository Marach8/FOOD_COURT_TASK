import '../../../global_export.dart';

class FCInputDecorationTheme{
  const FCInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 1,
    isDense: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    fillColor: FCColors.transparent,
    filled: true,
    hintStyle: TextStyle(
      color: FCColors.black.withValues(alpha: 0.5),
      fontSize: FCFontSizes.size14,
      fontWeight: FCFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
    errorStyle: TextStyle(
      color: FCColors.red.withValues(alpha: 0.6),
      fontSize: FCFontSizes.size12,
      fontWeight: FCFontWeights.w400,
      overflow: TextOverflow.ellipsis,
    ),

    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: FCColors.hex1B1B1B
      )
    ),

    disabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: FCColors.hex1B1B1B.withValues(alpha: 0.2)
      )
    ),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: FCColors.red.withValues(alpha: 0.6)
      )
    ),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        color: FCColors.red.withValues(alpha: 0.8)
      )
    ),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        color: FCColors.hex1B1B1B
      )
    ),
  );



  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 1,
    isDense: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    fillColor: FCColors.transparent,
    filled: true,
    hintStyle: TextStyle(
      color: FCColors.white.withValues(alpha: 0.5),
      fontSize: FCFontSizes.size14,
      fontWeight: FCFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: FCColors.white.withValues(alpha: 0.5)
      )
    ),

    errorStyle: TextStyle(
      color: FCColors.red.withValues(alpha: 0.6),
      fontSize: FCFontSizes.size12,
      fontWeight: FCFontWeights.w400,
      overflow: TextOverflow.ellipsis,
    ),


    disabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: FCColors.white.withValues(alpha: 0.2)
      )
    ),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: FCColors.red.withValues(alpha: 0.6)
      )
    ),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        color: FCColors.red.withValues(alpha: 0.8)
      )
    ),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        color: FCColors.white
      )
    ),
  );
}