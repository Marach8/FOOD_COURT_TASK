import 'dart:async' show unawaited;
import '../../../global_export.dart';

final StateNotifierProvider<SelectedCitiesNotifier, FCApiState<List<City>>> 
  selectedCitiesProvider = StateNotifierProvider<SelectedCitiesNotifier, FCApiState<List<City>>>(
  (Ref ref){
    return SelectedCitiesNotifier(ref,);
  }
);

class SelectedCitiesNotifier extends StateNotifier<FCApiState<List<City>>> {  
  SelectedCitiesNotifier(this.ref) : super(FCApiState<List<City>>.loading()){
    _getInitialCities();
  }

  SelectedCitiesNotifier.test(this.ref) : super(FCApiState<List<City>>.loading());

  final Ref ref;

  void _getInitialCities()async{
    final List<dynamic>? dynamicList = await ref.read(storageProvider)
      .getObject<List<dynamic>>(FCStrings.SELECTED_CITIES_IDS);

    final List<int>? cachedCitiesIDs = dynamicList?.cast<int>();

    ref.listen(
      allCitiesProvider,
      fireImmediately: true,
      (_, FCApiState<List<City>> next)async{
        if(next is Success<List<City>>){
          late List<City> initialCities;

          if(cachedCitiesIDs == null || cachedCitiesIDs.isEmpty){
            initialCities = next.data.take(3).toList();
          }
          else{
            initialCities = next.data.where(
              (City city) => cachedCitiesIDs.contains(city.id)).toList();            
          }

          for(City city in initialCities){
            ref.read(eachCityProvider(city.id).notifier).isASelectedCity(true);
            unawaited(
              ref.read(eachCityProvider(city.id).notifier).fetchCityWeatherDetails(
                latitude: city.latitude, longitude: city.longitude
              )
            );
            await _addCityId2Cache(city.id);
          }

          state = FCApiState<List<City>>.success(initialCities);
        }
        else if(next is Failure<List<City>>){
          state = FCApiState<List<City>>.failure(next.message);
        }
      }
    );
  }

  static List<City> listen2SelectedCities(FCApiState<List<City>> st) => switch (st) {
    Success<List<City>>(data: final List<City> cities) => cities,
    Failure<List<City>>(oldData: final List<City>? oldCities) => oldCities ?? <City>[],
    _ => <City>[]
  };

  List<City> getSelectedCities() => switch (state) {
    Success<List<City>>(data: final List<City> cities) => cities,
    Failure<List<City>>(oldData: final List<City>? oldData) => oldData ?? <City>[],
    _ => <City>[]
  };


  Future<int> addCity({
    required City city,
    bool? shouldCache
  })async{
    final List<City> currentCities = getSelectedCities();
    final int index = currentCities.indexWhere((City cty) => cty.id == city.id);

    if(index >= 0){
      currentCities.removeAt(index);
    }

    if(shouldCache ?? false){
      await _addCityId2Cache(city.id);
    }

    ref.read(eachCityProvider(city.id).notifier).isASelectedCity(true);
    
    final List<City> newCities = List<City>.from(currentCities)..add(city);
    state = FCApiState<List<City>>.success(newCities);

    if(city.weatherData == null){
      unawaited (
        ref.read(eachCityProvider(city.id).notifier).fetchCityWeatherDetails(
          latitude: city.latitude,
          longitude: city.longitude
        )
      );
    }

    return newCities.indexOf(city);
  }

  Future<void> removeCity(int id)async{
    final List<City> currentCities = getSelectedCities();
    await _removeCityId4rmCache(id);
    ref.read(eachCityProvider(id).notifier).isASelectedCity(false);

    if(currentCities.length > 1){
      final List<City> newCities = currentCities.where((City city) => city.id != id).toList();
      state = FCApiState<List<City>>.success(newCities);
    }
  }


  Future<void> _addCityId2Cache(int id) async {
    final List<dynamic>? dynamicIds = await ref.read(storageProvider)
      .getObject<List<dynamic>>(FCStrings.SELECTED_CITIES_IDS);
      
    final List<int> newIDs = dynamicIds?.cast<int>() ?? <int>[];
    if(!(newIDs).contains(id)){
      newIDs.add(id);
    }

    await ref.read(storageProvider).setObject<List<dynamic>>(
      FCStrings.SELECTED_CITIES_IDS,
      newIDs,
    );
  }


  Future<void> _removeCityId4rmCache(int id) async {
    final List<dynamic>? initialIds = await ref.read(storageProvider)
      .getObject<List<dynamic>>(FCStrings.SELECTED_CITIES_IDS);
    
    if (initialIds == null) return;
    
    final List<int> newIds = initialIds.cast<int>()
      .where((int existingId) => existingId != id).toList();

    await ref.read(storageProvider).setObject<List<dynamic>>(
      FCStrings.SELECTED_CITIES_IDS,
      newIds
    );
  }
}