import 'package:flutter/cupertino.dart';
import '../../../../global_export.dart';

Future<bool?> showAllCitiesForSelection(BuildContext context){
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        minChildSize: 0.5,
        builder: (_, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.fromLTRB(15, kToolbarHeight, 15, 15),
            height: context.screenHeight,
            width: context.screenWidth,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Consumer(
              builder: (_, WidgetRef ref, __){
                final FCApiState<List<City>> asyncCities = ref.watch(allCitiesProvider);
                
                return Column(
                  children: <Widget>[
                    Text(
                      FCStrings.NIGERIAN_CITIES,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    switch(asyncCities){
                      Initial<List<City>>() || Loading<List<City>>() => const Center(child: FCLoadingIndicator()),
                      Failure<List<City>>(message: _) => const Icon(Icons.refresh),
                      Success<List<City>>(data: final List<City> cities) => Expanded(
                        child: FCScrollBar(
                          scrollController: scrollController,
                          child: ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.only(right: 20),
                            itemCount: cities.length,
                            itemBuilder: (_, int index){
                              final City city = cities.elementAt(index);
                              return _RenderCity(city: city);
                            },
                          ),
                        ),
                      )
                    },
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}



class _RenderCity extends StatelessWidget {
  const _RenderCity({required this.city});

  final City city;

  @override
  Widget build(BuildContext context) {
    return FCContainer(
      color: Theme.of(context).scaffoldBackgroundColor,
      radius: 8,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      border: Border.all(
        width: 0.2,
        color: Theme.of(context).textTheme.headlineMedium?.color ?? FCColors.hex1B1B1B
      ),
      child: Row(
        children: <Widget>[
          const Icon(CupertinoIcons.placemark,),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  city.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'lat:${city.latitude} || lng:${city.longitude}',
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
          ),
          const SizedBox(width: 20),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final bool isSelected = ref.watch(
                eachCityProvider(city.id).select(((FCApiState<WeatherResponseModel?>, bool) st) => st.$2)
              );

              return IconButton(
                onPressed: (){
                  if(isSelected){
                    ref.read(selectedCitiesProvider.notifier).removeCity(city.id);
                  }
                  else{
                    ref.read(selectedCitiesProvider.notifier).addCity(city: city, shouldCache: true);
                  }
                  ref.read(eachCityProvider(city.id).notifier).isASelectedCity(
                    isSelected ? false : true
                  );
                },
                icon: Icon(
                  isSelected ? Icons.remove : Icons.add,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).textTheme.headlineLarge?.color?.withValues(alpha: 0.1),
                  padding: const EdgeInsets.all(4),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
