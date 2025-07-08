import '../../../global_export.dart';

final StateNotifierProvider<AllCitiesNotifier, FCApiState<List<City>>> 
  allCitiesProvider = StateNotifierProvider<AllCitiesNotifier, FCApiState<List<City>>>(
  (_) => AllCitiesNotifier(),
);

class AllCitiesNotifier extends StateNotifier<FCApiState<List<City>>> {  
  AllCitiesNotifier() : super(FCApiState<List<City>>.initial());

  bool shouldThrowTestError = false;

  List<City> getCurrentCities() => switch (state) {
    Success<List<City>>(data: final List<City> cities) => cities,
    Failure<List<City>>(oldData: final List<City>? oldData) => oldData ?? <City>[],
    _ => <City>[]
  };
  
  Future<void> fetchAllCities()async{
    final List<City> currentData = getCurrentCities();

    state = FCApiState<List<City>>.loading();

    //Simulate an api call to fetch cities
    await Future<void>.delayed(const Duration(seconds: 1));

    try{
      if(shouldThrowTestError){
        throw('Test Error');
      }

      final List<City> cities = const <City>[
        City(id: 0, name: "Lagos", latitude: 6.4550, longitude: 3.3841),
        City(id: 1, name: "Abuja", latitude: 9.0667, longitude: 7.4833),
        City(id: 2, name: "Port Harcourt", latitude: 4.8242, longitude: 7.0336,),
        City(id: 3, name: "Ibadan", latitude: 7.3964, longitude: 3.9167),
        City(id: 4, name: "Kano", latitude: 12.0000, longitude: 8.5167),
        City(id: 5, name: "Benin City", latitude: 6.3333, longitude: 5.6222),
        City(id: 6, name: "Maiduguri", latitude: 11.8333, longitude: 13.1500),
        City(id: 7, name: "Aba", latitude: 5.1167, longitude: 7.3667),
        City(id: 8, name: "Onitsha", latitude: 6.1667, longitude: 6.7833),
        City(id: 9, name: "Owerri", latitude: 5.4850, longitude: 7.0350),
        City(id: 10, name: "Sokoto", latitude: 13.0622, longitude: 5.2339),
        City(id: 11, name: "Minna", latitude: 9.6139, longitude: 6.5569),
        City(id: 12, name: "Ogbomoso", latitude: 8.1333, longitude: 4.2500),
        City(id: 13, name: "Ikeja", latitude: 6.6000, longitude: 3.3500),
        City(id: 14, name: "Awka", latitude: 6.2069, longitude: 7.0678),
      ];

      state = FCApiState<List<City>>.success(cities);
    }
    catch (e){
      state = FCApiState<List<City>>.failure(e.toString(), oldData: currentData);
    }
  }
}