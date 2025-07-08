import '../../../../global_export.dart';

class CityWeatherCardWidget extends ConsumerWidget {
  const CityWeatherCardWidget({
    super.key,
    required this.city,
  });

  final City city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final FCApiState<WeatherResponseModel?> asyncWeatherData = ref.watch(
      eachCityProvider(city.id).select(((FCApiState<WeatherResponseModel?>, bool) st) => st.$1)
    );

    final WeatherResponseModel? weatherData = ref.read(
      eachCityProvider(city.id).notifier
    ).getCurrentWeather();

    final bool hasError = asyncWeatherData is Failure<WeatherResponseModel?>; 
    final bool isLoading = asyncWeatherData is Loading<WeatherResponseModel?>; 

    return FCContainer(
      radius: 20,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: FCHelperFuncs.getGradientColors(weatherData?.weather?.first.description ?? '')
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: FCColors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
      child: hasError ? CityCardErrorWidget(city: city) : SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.close, color: FCColors.white, size: 20),
                onPressed: () => ref.read(selectedCitiesProvider.notifier).removeCity(city.id),
                style: IconButton.styleFrom(
                  backgroundColor: FCColors.black.withValues(alpha: 0.2),
                  padding: const EdgeInsets.all(4),
                ),
              ),
            ),

            if(city.isCurrentLocation) const LocationIcon(),
            
            Text(
              city.name,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
        
            const SizedBox(height: 50,),
            isLoading ? const FCShimmer(
              height: 80, width: 80,
              radius: 50,
            ) : FCContainer(
              padding: const EdgeInsets.all(16),
              radius: 50,
              color: Theme.of(context).textTheme.headlineLarge?.color?.withValues(alpha: 0.2),
              child: WeatherIconWidget(iconCode: weatherData?.weather?.first.icon ?? ''),
            ),
            
            const SizedBox(height: 50,),
        
            isLoading ? const FCShimmer(height: 40, width: 100, radius: 8,)
            : Text(
              textAlign: TextAlign.center,
              '${weatherData?.main?.averageTemp}°C',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: FCFontSizes.size50
              )
            ),
            
            const SizedBox(height: 40,),
            isLoading ?const FCShimmer(height: 20, width: 150, radius: 8,) : Text(
              textAlign: TextAlign.center,
              weatherData?.weather?.first.description?.toUpperCase() ?? '',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
        
            const SizedBox(height: 100,),
            
            WeatherDetailsRow(weather: weatherData, isLoading: isLoading,),
          ],
        ),
      ),
    );
  }
}
