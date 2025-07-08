import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_court/src/global_export.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepo extends Mock implements HomeRepo {}
class MockRef extends Mock implements Ref {}


final WeatherResponseModel mockWeather = WeatherResponseModel();
final City mockCity = City(id: 1, latitude: 0, longitude: 0, name: 'Test', weatherData: mockWeather);

void main() {
  late EachCityNotifier notifier;
  late MockHomeRepo mockHomeRepo;
  late MockRef mockRef;

  setUp(
    () {
      mockHomeRepo = MockHomeRepo();
      mockRef = MockRef();

      when(() => mockRef.read(homeRepoImplProvider)).thenReturn(mockHomeRepo);
      
      notifier = EachCityNotifier(
        mockRef, 1, FCApiState<WeatherResponseModel?>.success(mockWeather),
      );
    }
  );

  tearDown(() => reset(mockHomeRepo));

  group(
    'Initial State tests',
      () {
      test(
        'A city is initialy unselected and the weather is the same as passed when created', 
        () {
          expect(notifier.state, isA<(Success<WeatherResponseModel?>, bool)>());
          expect(notifier.cityId, equals(1));
        }
      );
    }
  );

  group(
    'Get weather tests',
    () {
      test(
        'getCurrentWeather method returns a weather on success state',
        () {
          notifier.state = (FCApiState<WeatherResponseModel>.success(mockWeather), false);
          expect(notifier.getCurrentWeather(), equals(mockWeather));
        }
      );

      test(
        'getCurrentWeather method returns a null on loading state',
          () {
          notifier.state = (FCApiState<WeatherResponseModel>.loading(), false);
          expect(notifier.getCurrentWeather(), isNull);
        }
      );
    }
  );

  group(
    'City selection flag',
    () {
      test(
        'Correctly marks that a city has been selected',
        () {
          notifier.isASelectedCity(true);
          expect(notifier.state.$2, isTrue);
          
          notifier.isASelectedCity(false);
          expect(notifier.state.$2, isFalse);
        }
      );
    }
  );

  group(
    'Fetching weather data functionality',
    () {
      test(
        'On successful fetch, a weather model is available inside a success state',
        () async {
          when(
            () => mockHomeRepo.fetchWeatherDetails(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
            )
          ).thenAnswer((_) async => Successful<WeatherResponseModel>(data: mockWeather));

          await notifier.fetchCityWeatherDetails(latitude: 0, longitude: 0);
          
          expect(notifier.state.$1, isA<Success<WeatherResponseModel?>>());
          expect(notifier.getCurrentWeather(), equals(mockWeather));
        }
      );

      test(
        'Failure preserves old data',
        () async {
          notifier.state = (FCApiState<WeatherResponseModel?>.success(mockWeather), false);
          when(() => mockHomeRepo.fetchWeatherDetails(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          )).thenAnswer((_) async => Unsuccessful<WeatherResponseModel>(
            error: FCException.getException(const SocketException(''))));

          await notifier.fetchCityWeatherDetails(latitude: 0, longitude: 0);
          
          expect(notifier.state.$1, isA<Failure<WeatherResponseModel?>>());
          expect(notifier.getCurrentWeather(), equals(mockWeather));
        }
      );
    }
  );
}