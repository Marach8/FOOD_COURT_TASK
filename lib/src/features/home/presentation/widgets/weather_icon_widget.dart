import '../../../../global_export.dart';

class WeatherIconWidget extends StatelessWidget {
  const WeatherIconWidget({
    super.key,
    required this.iconCode
  });

  final String iconCode;

  @override
  Widget build(BuildContext context) {
    late IconData iconData;

    switch (iconCode) {
      case '01d':
      case '01n':
        iconData = Icons.wb_sunny;
      case '02d':
      case '02n':
      case '03d':
      case '03n':
        iconData = Icons.wb_cloudy;
      case '04d':
      case '04n':
        iconData = Icons.cloud;
      case '09d':
      case '09n':
      case '10d':
      case '10n':
        iconData = Icons.grain;
      case '11d':
      case '11n':
        iconData = Icons.flash_on;
      case '13d':
      case '13n':
        iconData = Icons.ac_unit;
      case '50d':
      case '50n':
        iconData = Icons.foggy;
      default:
        iconData = Icons.wb_sunny;
    }

    return Icon(
      iconData,
      size: 80,
      color: Theme.of(context).textTheme.headlineLarge?.color,
    );
  }
}