import 'package:flutter_test/flutter_test.dart';
import 'package:food_court/src/global_export.dart';
import 'package:mocktail/mocktail.dart';

class MockRef extends Mock implements Ref {}
class MockStorage extends Mock implements FCStorageImpl {}
class MockCityNotifier extends Mock implements EachCityNotifier {}
class MockProviderSubscription extends Mock implements ProviderSubscription<FCApiState<List<City>>> {}

final City testCity = const City(id: 20, name: 'TestCity', latitude: 4.0, longitude: 3.6);

final List<City> testCities = List<City>.generate(
  4, 
  (int i) => City(id: i, name: 'City$i', latitude: 0.0, longitude: 0.1)
);

void main() {
  late SelectedCitiesNotifier notifier;
  late MockRef mockRef;
  late MockStorage mockStorage;
  late MockCityNotifier mockCityNotifier;
  late MockProviderSubscription mockSubscription;

  setUp(
    () {
      mockRef = MockRef();
      mockStorage = MockStorage();
      mockCityNotifier = MockCityNotifier();
      mockSubscription = MockProviderSubscription();

      when(() => mockRef.read(storageProvider)).thenReturn(mockStorage);

      for (final City city in testCities) {
        when(
          () => mockRef.read(eachCityProvider(city.id).notifier)
        ).thenReturn(mockCityNotifier);
      }

      when(
        () => mockRef.read(eachCityProvider(testCity.id).notifier)
      ).thenReturn(mockCityNotifier);
      
      when(
        () => mockStorage.getObject<List<dynamic>>(FCStrings.SELECTED_CITIES_IDS)
      ).thenAnswer((_) async => null);

      when(() => mockStorage.setObject<List<dynamic>>(any(), any())).thenAnswer((_) async {});

      when(
        () => mockCityNotifier.fetchCityWeatherDetails(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude')
        )
      ).thenAnswer((_) async {});

      when(() => mockCityNotifier.isCitySelected(any())).thenReturn(null);

      when(
        () => mockRef.listen<FCApiState<List<City>>>(
          allCitiesProvider,
          any(),
          fireImmediately: any(named: 'fireImmediately'),
        )
      ).thenAnswer((Invocation invocation) {
        final Function(FCApiState<List<City>>?, FCApiState<List<City>>) callback = 
          invocation.positionalArguments[1] as void Function(FCApiState<List<City>>?, FCApiState<List<City>>);
        
        Future<Null>.microtask(() {
          callback(null, FCApiState<List<City>>.success(testCities));
        });
        
        return mockSubscription;
      });
    }
  );

  test(
    'Ensure that SelectedCitiesNotifier always starts with a loading state',
      () {
      final SelectedCitiesNotifier testNotifier = SelectedCitiesNotifier.test(mockRef);
      expect(testNotifier.state, isA<Loading<List<City>>>());
    }
  );

  group(
    'Core notifier operations',
    () {
      setUp(() {
        notifier = SelectedCitiesNotifier(mockRef);
      });

      test(
        'Adding a city goes successfully',
        () async {
          await pumpEventQueue();
          
          final int index = await notifier.addCity(city: testCity);
          expect(index, greaterThanOrEqualTo(0));
          expect((notifier.state as Success<List<City>>).data, contains(testCity));
        }
      );

      test(
        'Removal of a city goes successfully',
        () async {
          await pumpEventQueue();
          
          await notifier.addCity(city: testCity);
          
          await notifier.removeCity(testCity.id);
          expect((notifier.state as Success<List<City>>).data, 
                 isNot(contains(testCity)));
        }
      );

      test(
        'getSelectedCities returns current cities',
        () async {
          await pumpEventQueue();
          
          final List<City> cities = notifier.getSelectedCities();
          expect(cities, isA<List<City>>());
        }
      );
    }
  );

  group(
    'Caching Operations inside SelectedCityNotifier',
    () {
      test(
        'Adding a city with shouldCache=true successfully saves to storage and updates the state',
        () async {
          await pumpEventQueue();
          
          await notifier.addCity(city: testCity, shouldCache: true);
          
          verify(
            () => mockStorage.setObject<List<dynamic>>(
              FCStrings.SELECTED_CITIES_IDS,
              any(),
            )
          ).called(greaterThanOrEqualTo(1));

          expect(notifier.state, isA<Success<List<City>>>());
          expect((notifier.state as Success<List<City>>).data, isNotEmpty);
        }
      );

      test(
        'Ensure City removal is successfull both from cache and state',
        () async {
          await pumpEventQueue();
          
          await notifier.addCity(city: testCity, shouldCache: true);
          
          await notifier.removeCity(testCity.id);

          verify(
            () => mockStorage.setObject<List<dynamic>>(
              FCStrings.SELECTED_CITIES_IDS,
              any(),
            )
          ).called(greaterThanOrEqualTo(1));

          expect(notifier.state, isA<Success<List<City>>>());
        }
      );

      test(
        'Ensure we select first 3 cities if cache is empty (when we start the app)',
        () async {
          when(
            () => mockStorage.getObject<List<dynamic>>(FCStrings.SELECTED_CITIES_IDS)
          ).thenAnswer((_) async => null);
          
          notifier = SelectedCitiesNotifier(mockRef);
          await pumpEventQueue();

          expect(notifier.state, isA<Success<List<City>>>());
          expect((notifier.state as Success<List<City>>).data.length, 3);
        }
      );

      test(
        'Ensure we use cached cities when cache contains IDs (cache is not empty)',
        () async {
          final List<int> cachedCityIds = <int>[1, 3];
          when(
            () => mockStorage.getObject<List<dynamic>>(FCStrings.SELECTED_CITIES_IDS)
          ).thenAnswer((_) async => cachedCityIds);

          notifier = SelectedCitiesNotifier(mockRef);
          await pumpEventQueue();

          expect(notifier.state, isA<Success<List<City>>>());
          expect(
            (notifier.state as Success<List<City>>).data.map((City cty) => cty.id), 
            containsAll(<int>[1, 3])
          );
        }
      );
    }
  );
}