import 'package:dio/dio.dart';
import 'package:food_court/src/global_export.dart';

final Provider<HomeRepo> homeRepoImplProvider = Provider<HomeRepo>(
  (Ref ref){
    final DioServiceImpl service = ref.read(dioServiceImplProvider);
    return HomeRepoImpl(service);
  }
);


class HomeRepoImpl implements HomeRepo{

  HomeRepoImpl(this.service);

  final NetworkService service;

  static const String apiKey = String.fromEnvironment('API_KEY');
  
  @override
  Future<ApiResponse<WeatherResponseModel>> fetchWeatherDetails(
    {required double latitude, required double longitude}) async{
    try{
      final Response<dynamic> response = await service.get(
        FCEndpoints.WEATHER,
        queryParameters: <String, dynamic>{
          'lat': latitude,
          'lon': longitude,
          'appid': apiKey,
        }
      );
      
      return Successful<WeatherResponseModel>(
        data: WeatherResponseModel.fromJson(response.data));
    }
    catch(e){
      return Unsuccessful<WeatherResponseModel>(error: FCException.getException(e));
    }
  }
}