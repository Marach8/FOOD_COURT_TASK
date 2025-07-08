import '../../../../global_export.dart';

class WeatherDetailsRow extends StatelessWidget {
  const WeatherDetailsRow({
    super.key,
    required this.weather,
    required this.isLoading,
  });

  final bool isLoading;
  final WeatherResponseModel? weather;

  @override
  Widget build(BuildContext context) {
    if(!isLoading && weather == null) return const SizedBox.shrink();
    
    return FCContainer(
      padding: const EdgeInsets.all(16),
      radius: 16,
      color: Theme.of(context).textTheme.headlineLarge?.color?.withValues(alpha: 0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _DetailColumn(
            isLoading: isLoading,
            label: FCStrings.FEELS_LIKE,
            icon: Icons.thermostat_outlined, 
            value: '${weather?.main?.feelsLike?.round()}°C',
          ),

          _DetailColumn(
            isLoading: isLoading,
            label: FCStrings.HUMIDITY,
            icon: Icons.water_drop_outlined,
            value: '${weather?.main?.humidity?.round()}%',
          ),

          _DetailColumn(
            isLoading: isLoading,
            label: FCStrings.WIND,
            icon: Icons.air_outlined, 
            value: '${weather?.wind?.speed} m/s',
          ),
        ],
      ),
    );
  }
}



class _DetailColumn extends StatelessWidget {
  const _DetailColumn({
    required this.label,
    required this.icon,
    required this.value,
    required this.isLoading,
  });
  
  final String label, value;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 15,
      children: <Widget>[
        isLoading ? const FCShimmer(height: 30, width: 20, radius: 5,) : Icon(
          icon, size: 30,
          color: Theme.of(context).textTheme.headlineLarge?.color,
        ),
        isLoading ? const FCShimmer(height: 15, width: 40, radius: 5,) : Text(
          value,
          style: Theme.of(context).textTheme.bodySmall
        ),
        isLoading ? const FCShimmer(height: 10, width: 70, radius: 5,) : Text(
          label,
          style: Theme.of(context).textTheme.labelMedium
        ),
      ],
    );
  }
}