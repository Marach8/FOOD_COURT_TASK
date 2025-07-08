import 'package:flutter_test/flutter_test.dart';
import 'package:food_court/src/global_export.dart';

void main() {
  late AllCitiesNotifier notifier;

  setUp(() => notifier = AllCitiesNotifier());

  group(
    'Intial State tests', 
    () {
      test(
        'Check that the initial state is correct', 
        () {
          expect(notifier.state, isA<FCApiState<List<City>>>());
          expect(notifier.state, isA<Initial<List<City>>>());
        }
      );

      test(
        'Check that getAvailableCities method returns an empty list initially',
        () => expect(notifier.getCurrentCities(), isEmpty),
      );
    }
  );

  group(
    'Loading state tests',
    (){
      test(
        'Confirm that fetchAllCities changes state to loading state',
        () async {
          final Future<void> future = notifier.fetchAllCities();
          expect(notifier.state, isA<Loading<List<City>>>());
          await future;
        }
      );
    }
  );

  group(
    'Data state tests',
    (){
      test(
        'fetchAllCities successfully loads cities',
          () async {
          await notifier.fetchAllCities();
          expect(notifier.state, isA<Success<List<City>>>());
          expect(notifier.getCurrentCities(), hasLength(15));
        }
      );

      test(
        'Confirm that Lagos, Abuja and Port harcourt are returned initially',
        () async {
          await notifier.fetchAllCities();
          final List<City> cities = notifier.getCurrentCities();
          expect(cities[0].name, equals('Lagos'));
          expect(cities[1].name, equals('Abuja'));
          expect(cities[2].name, equals('Port Harcourt'));
        }
      );
    }
  );

  group(
    'Error state tests',
    (){
      test(
        'Confirm that an error is caught on Failure',
        () async {
          notifier.shouldThrowTestError = true;
          await notifier.fetchAllCities();

          expect(notifier.state, isA<Failure<List<City>>>());

          final Failure<List<City>> errorState = notifier.state as Failure<List<City>>;
          expect(errorState.message, contains('Test Error'));
        }
      );

      test(
        'Ensure that old data is preserved on failure',
        () async {
          await notifier.fetchAllCities();
          
          notifier.shouldThrowTestError = true;
          await notifier.fetchAllCities();
          
          expect(notifier.state, isA<Failure<List<City>>>());
          final List<City>? oldData = (notifier.state as Failure<List<City>>).oldData;
          expect(oldData, isNotNull);
          expect(oldData?.length, greaterThan(0));
        }
      );
    }
  );
}