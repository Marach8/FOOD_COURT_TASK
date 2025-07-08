import '../../../../global_export.dart';

class CityCardErrorWidget extends StatelessWidget {
  const CityCardErrorWidget({
    super.key,
    required this.city,
  });

  final City city;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 15, right: 15,
          child: IconButton(
            icon: Icon(Icons.close, color: FCColors.white, size: 20),
            onPressed: () =>context.ref.read(selectedCitiesProvider.notifier).removeCity(city.id),
            style: IconButton.styleFrom(
              backgroundColor: FCColors.black.withValues(alpha: 0.2),
              padding: const EdgeInsets.all(4),
            ),
          ),
        ),

        Center(
          child: FCRefreshWidget(
            onPressed: (){
              context.ref.read(eachCityProvider(city.id).notifier)
                .fetchCityWeatherDetails(latitude: city.latitude, longitude: city.longitude);
            }
          ),
        )
      ],
    );
  }
}


