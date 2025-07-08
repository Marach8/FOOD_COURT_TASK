import '../../../global_export.dart';

final StateNotifierProviderFamily<EachCityNotifier, (FCApiState<WeatherResponseModel?>, bool), int> 
  eachCityProvider = StateNotifierProvider.family<EachCityNotifier, (FCApiState<WeatherResponseModel?>, bool), int>(
  (Ref ref, int cityId){
    final List<City> cities = ref.read(allCitiesProvider.notifier).getCurrentCities();
    final City currCity = cities.firstWhere(
      (City city) => city.id == cityId,
      orElse: () => const City(id: 100, latitude: 0, longitude: 0, name: ''),
    );
    return EachCityNotifier(
      ref, cityId, currCity.isCurrentLocation,
      FCApiState<WeatherResponseModel?>.success(currCity.weatherData)
    );
  }
);


class EachCityNotifier extends StateNotifier<(FCApiState<WeatherResponseModel?>, bool)>{
  EachCityNotifier(
    this.ref, 
    this.cityId,
    bool? isSelected,
    FCApiState<WeatherResponseModel?> cityState,
  ): 
  _homeRepo = ref.read(homeRepoImplProvider),
  super((cityState, isSelected ?? false));

  final Ref ref;
  final int cityId;
  final HomeRepo _homeRepo;

  WeatherResponseModel? getCurrentWeather() => switch (state.$1) {
    Success<WeatherResponseModel?>(data: final WeatherResponseModel? cities) => cities,
    Failure<WeatherResponseModel?>(oldData: final WeatherResponseModel? oldData) => oldData,
    _ => null,
  };

  void isCitySelected(bool status) => state = (state.$1, status);


  Future<void> fetchCityWeatherDetails({
    required double latitude,
    required double longitude,
  })async{
    final WeatherResponseModel? intialWeatherData = getCurrentWeather();
    state = (FCApiState<WeatherResponseModel?>.loading(), state.$2);

    try{
      final ApiResponse<WeatherResponseModel> response = await _homeRepo.fetchWeatherByCoordinates(
        latitude: latitude, longitude: longitude
      );

      response.when(
        successful: (Successful<WeatherResponseModel> data){
          state = (
            FCApiState<WeatherResponseModel?>.success(data.data),
            state.$2
          );
        },
        unSuccessful: (Unsuccessful<WeatherResponseModel> error){
          state = (
            FCApiState<WeatherResponseModel?>.failure(error.error.message, oldData: intialWeatherData),
            state.$2
          );
        }
      );
    }
    catch (e){
      state = (
        FCApiState<WeatherResponseModel?>.failure(e.toString(), oldData: intialWeatherData),
        state.$2
      );
    }
  }
}
