import '../../../../global_export.dart';

class HomeDotIndicator extends ConsumerWidget {
  const HomeDotIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<City> cities = ref.watch(
      selectedCitiesProvider.select(SelectedCitiesNotifier.listen2SelectedCities)
    );

    final int selectedCityIndex = ref.watch(selectedCityIndexProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        cities.length,
        (int index) {
          final bool isSelected = index == selectedCityIndex;

          return FCContainer(
            margin: const EdgeInsets.only(right: 4),
            color: Theme.of(context).textTheme.headlineLarge?.color?.withValues(
              alpha: isSelected ? 1 : 0.6
            ),
            height: 5, radius: 5,
            width: isSelected ? 30 : 4,
            child: const SizedBox.shrink(),
          );
        }
      )
    );
  }
}



final StateProvider<int> selectedCityIndexProvider = StateProvider<int>(
  (_,) => 0
);
