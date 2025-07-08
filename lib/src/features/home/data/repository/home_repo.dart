import 'package:food_court/src/config/api_response.dart';
import 'package:food_court/src/features/features_export.dart';

abstract class HomeRepo {
  
  //Future<ApiResponse<dynamic>> getWeatherResponseModelByCity(String cityName);
  
  Future<ApiResponse<WeatherResponseModel>> fetchWeatherByCoordinates({
    required double latitude,
    required double longitude,
  });

}