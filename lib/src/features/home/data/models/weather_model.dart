// class WeatherResponseModel {
//   WeatherResponseModel({
//     required this.cityName,
//     required this.temperature,
//     required this.description,
//     required this.icon,
//     required this.humidity,
//     required this.windSpeed,
//     required this.feelsLike,
//     required this.pressure,
//     DateTime? dateTime,
//   }) : dateTime = dateTime ?? DateTime.now();

//   final String cityName;
//   final double temperature;
//   final String description;
//   final String icon;
//   final double humidity;
//   final double windSpeed;
//   final double feelsLike;
//   final int pressure;
//   final DateTime dateTime;


//   // Factory constructor to create WeatherModel from API JSON response
//   factory WeatherResponseModel.fromJson(Map<String, dynamic> json) {
//     return WeatherResponseModel(
//       cityName: json['name'] ?? 'Unknown City',
//       temperature: (json['main']['temp'] ?? 0.0).toDouble(),
//       description: json['weather'][0]['description'] ?? 'No description',
//       icon: json['weather'][0]['icon'] ?? '01d',
//       humidity: (json['main']['humidity'] ?? 0.0).toDouble(),
//       windSpeed: (json['wind']?['speed'] ?? 0.0).toDouble(),
//       feelsLike: (json['main']['feels_like'] ?? 0.0).toDouble(),
//       pressure: json['main']['pressure'] ?? 0,
//       dateTime: DateTime.now(),
//     );
//   }

//   // Helper method to get human-readable time
//   String get formattedTime {
//     final hour = dateTime.hour;
//     final minute = dateTime.minute;
//     final ampm = hour >= 12 ? 'PM' : 'AM';
//     final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
//     return '$displayHour:${minute.toString().padLeft(2, '0')} $ampm';
//   }

//   // Copy method for updating specific fields
//   WeatherResponseModel copyWith({
//     String? cityName,
//     double? temperature,
//     String? description,
//     String? icon,
//     double? humidity,
//     double? windSpeed,
//     double? feelsLike,
//     int? pressure,
//     DateTime? dateTime,
//   }) {
//     return WeatherResponseModel(
//       cityName: cityName ?? this.cityName,
//       temperature: temperature ?? this.temperature,
//       description: description ?? this.description,
//       icon: icon ?? this.icon,
//       humidity: humidity ?? this.humidity,
//       windSpeed: windSpeed ?? this.windSpeed,
//       feelsLike: feelsLike ?? this.feelsLike,
//       pressure: pressure ?? this.pressure,
//       dateTime: dateTime ?? this.dateTime,
//     );
//   }

//   @override
//   String toString() {
//     return 'WeatherModel(cityName: $cityName, temperature: $temperature°C, description: $description, humidity: $humidity%, windSpeed: $windSpeed m/s)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is WeatherResponseModel &&
//         other.cityName == cityName &&
//         other.temperature == temperature &&
//         other.description == description &&
//         other.icon == icon &&
//         other.humidity == humidity &&
//         other.windSpeed == windSpeed &&
//         other.feelsLike == feelsLike &&
//         other.pressure == pressure;
//   }

//   @override
//   int get hashCode {
//     return cityName.hashCode ^
//         temperature.hashCode ^
//         description.hashCode ^
//         icon.hashCode ^
//         humidity.hashCode ^
//         windSpeed.hashCode ^
//         feelsLike.hashCode ^
//         pressure.hashCode;
//   }
// }

// // Example usage and sample data for testing
// class WeatherModelExample {
//   static WeatherResponseModel sampleLagosWeather() {
//     return WeatherResponseModel(
//       cityName: 'Lagos',
//       temperature: 28.5,
//       description: 'partly cloudy',
//       icon: '02d',
//       humidity: 75.0,
//       windSpeed: 3.2,
//       feelsLike: 31.0,
//       pressure: 1013,
//     );
//   }

//   static WeatherResponseModel sampleAbujaWeather() {
//     return WeatherResponseModel(
//       cityName: 'Abuja',
//       temperature: 26.0,
//       description: 'clear sky',
//       icon: '01d',
//       humidity: 60.0,
//       windSpeed: 2.1,
//       feelsLike: 28.0,
//       pressure: 1015,
//     );
//   }

//   static List<WeatherResponseModel> sampleWeatherList() {
//     return [
//       sampleLagosWeather(),
//       sampleAbujaWeather(),
//       WeatherResponseModel(
//         cityName: 'Port Harcourt',
//         temperature: 30.2,
//         description: 'light rain',
//         icon: '10d',
//         humidity: 85.0,
//         windSpeed: 4.5,
//         feelsLike: 34.0,
//         pressure: 1011,
//       ),
//     ];
//   }
// }










class WeatherResponseModel {
  WeatherResponseModel({
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) => WeatherResponseModel(
    weather: json['weather'] != null 
      ? List<WeatherData>.from(json['weather'].map((dynamic x) => WeatherData.fromJson(x))) 
      : null,
    base: json['base'],
    main: json['main'] != null ? MainData.fromJson(json['main']) : null,
    visibility: json['visibility'],
    wind: json['wind'] != null ? WindData.fromJson(json['wind']) : null,
    rain: json['rain'] != null ? RainData.fromJson(json['rain']) : null,
    clouds: json['clouds'] != null ? CloudsData.fromJson(json['clouds']) : null,
    dt: json['dt'],
    sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
    timezone: json['timezone'],
    id: json['id'],
    name: json['name'],
    cod: json['cod'],
  );

  final List<WeatherData>? weather;
  final String? base;
  final MainData? main;
  final int? visibility;
  final WindData? wind;
  final RainData? rain;
  final CloudsData? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;
}


class WeatherData {
  WeatherData({this.id, this.main, this.description, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    id: json['id'],
    main: json['main'],
    description: json['description'],
    icon: json['icon'],
  );

  final int? id;
  final String? main;
  final String? description;
  final String? icon;
}

class MainData {
  MainData({
    this.averageTemp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
    averageTemp: json['temp']?.toDouble(),
    feelsLike: json['feels_like']?.toDouble(),
    tempMin: json['temp_min']?.toDouble(),
    tempMax: json['temp_max']?.toDouble(),
    pressure: json['pressure'],
    humidity: json['humidity'],
    seaLevel: json['sea_level'],
    grndLevel: json['grnd_level'],
  );

  final double? averageTemp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;
}

class WindData {
  WindData({this.speed, this.deg, this.gust});

  factory WindData.fromJson(Map<String, dynamic> json) => WindData(
    speed: json['speed']?.toDouble(),
    deg: json['deg'],
    gust: json['gust']?.toDouble(),
  );

  final double? speed;
  final int? deg;
  final double? gust;
}

class RainData {
  RainData({this.oneHour});

  factory RainData.fromJson(Map<String, dynamic> json) => RainData(
    oneHour: json['1h']?.toDouble(),
  );

  final double? oneHour;
}

class CloudsData {
  CloudsData({this.all});

  factory CloudsData.fromJson(Map<String, dynamic> json) => CloudsData(
    all: json['all'],
  );

  final int? all;
}

class Sys {
  Sys({this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    country: json['country'],
    sunrise: json['sunrise'],
    sunset: json['sunset'],
  );

  final String? country;
  final int? sunrise;
  final int? sunset;
}