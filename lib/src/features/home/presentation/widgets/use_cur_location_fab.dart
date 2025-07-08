import 'dart:async' show unawaited;
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import '../../../../global_export.dart';

class UseCurrentLocationFAB extends ConsumerStatefulWidget {
  const UseCurrentLocationFAB({super.key});

  @override
  ConsumerState<UseCurrentLocationFAB> createState() => _UseCurrentLocationFABState();
}

class _UseCurrentLocationFABState extends ConsumerState<UseCurrentLocationFAB> {
  bool isDone = false;
  static const double initialSize = 60;
  static const double finalSize = 50;
  static const int currentCityId = 15;

  @override
  Widget build(BuildContext context) {
    final FCApiState<WeatherResponseModel?> asyncWeatherData = ref.watch(
      eachCityProvider(currentCityId).select(((FCApiState<WeatherResponseModel?>, bool) st) => st.$1)
    );
    
    final bool isLoading = asyncWeatherData is Loading<WeatherResponseModel?>;

    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 1),
      tween: Tween<double>(
        begin: isDone ? finalSize : initialSize,
        end: isDone ? initialSize : finalSize,
      ),
      onEnd: () => setState(() => isDone = !isDone),
      builder: (_, double size, __) {
        return SizedBox(
          height: size, width: size,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).textTheme.headlineMedium?.color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: isLoading ? null : ()async{
              final (double?, double?, String?) result = await FCHelperFuncs.getCurrentLocation();
              if(context.mounted && result.$3 != null){
                unawaited(
                  showAppNotification(context: context, text: result.$3!, isSuccess: false)
                );
              }
              if(result.$1 != null && result.$2 != null){
                await ref.read(eachCityProvider(currentCityId).notifier).fetchCityWeatherDetails(
                  latitude: result.$1!, longitude: result.$2!
                );
                final WeatherResponseModel? weatherData = ref.read(eachCityProvider(currentCityId).notifier)
                  .getCurrentWeather();
          
                if(weatherData != null){
                  final City currentCity = City(
                    id: currentCityId,
                    name: weatherData.name ?? '',
                    latitude: result.$1!,
                    isCurrentLocation: true,
                    longitude: result.$2!,
                    weatherData: weatherData
                  );
                  final int indexOfCurCity = await ref.read(selectedCitiesProvider.notifier)
                    .addCity(city: currentCity);
                  await Future<void>.delayed(const Duration(seconds: 1));
                  unawaited(
                    ref.read(carouselCntrlProvider).animateToPage(
                      indexOfCurCity, curve: Curves.decelerate,
                      duration: const Duration(milliseconds: 500),
                    )
                  );
                }
              }
            },
            child: isLoading ? const FCLoadingIndicator()
              : Icon(CupertinoIcons.placemark, color: Theme.of(context).scaffoldBackgroundColor,),
          ),
        );
      }
    );
  }
}
