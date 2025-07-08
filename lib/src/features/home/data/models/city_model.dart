
//I use integers for IDs in this case for simplicity.
//If data is synchronized with backend, IDs either come from backend
//or generated via the uuid package.

import 'package:food_court/src/features/features_export.dart';

class City {
  const City({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.weatherData,
    this.isCurrentLocation = false,
  });

  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final WeatherResponseModel? weatherData;
  final bool isCurrentLocation;

  City copyWith({
    String? name,
    double? latitude,
    double? longitude,
    WeatherResponseModel? weatherData,
    bool? isSelected,
  }) {
    return City(
      id: id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      weatherData: weatherData ?? this.weatherData,
      isCurrentLocation: isSelected ?? isCurrentLocation,
    );
  }

  @override
  String toString() {
    return 'City{id: $id, name: $name, latitude: $latitude, '
        'longitude: $longitude, weatherData: $weatherData, '
        'isSelected: $isCurrentLocation}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          weatherData == other.weatherData &&
          isCurrentLocation == other.isCurrentLocation;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      weatherData.hashCode ^
      isCurrentLocation.hashCode;
}