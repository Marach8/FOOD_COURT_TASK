import 'dart:math';
import 'dart:ui' show Color;
import 'package:food_court/src/config/utils/colors.dart';
import 'package:food_court/src/config/utils/strings.dart';
import 'package:geolocator/geolocator.dart';

class FCHelperFuncs{
  const FCHelperFuncs._();

  
  static int getRandomNumber(double ceiling){
    final int number = Random().nextInt(ceiling.toInt()) + 1;
    if(number < 100){
      return 100 + number;
    }
    return number;
  }

  static List<Color> getGradientColors(String desc) {

    if (desc.contains('clear')) {
      return <Color>[FCColors.hexFFA726, FCColors.hexF4511E];
    }
    else if (desc.contains('cloud')) {
      return <Color>[FCColors.hex78909C, FCColors.hex455A64];
    }
    else if (desc.contains('rain')) {
      return <Color>[FCColors.hex42A5F5, FCColors.hex1976D2];
    }
    else if (desc.contains('thunder')) {
      return <Color>[FCColors.hex7E57C2, FCColors.hex512DA8];
    }
    else if (desc.contains('light')) {
      return <Color>[FCColors.hexE0E0E0, FCColors.hexBDBDBD];
    }
    else {
      return <Color>[FCColors.hex42A5F5, FCColors.hex2196F3];
    }
  }


  static Future<(double? lat, double? lng, String? err)> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return (null, null, null);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return (null, null, FCStrings.ENABLE_LOCATION);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return (null, null, FCStrings.ENABLE_LOCATION);
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      return (position.latitude, position.longitude, null);
    } 
    catch (e) {
      return (null, null, e.toString());
    }
  }
}