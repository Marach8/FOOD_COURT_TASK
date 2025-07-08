import 'package:carousel_slider/carousel_slider.dart';
import '../../../../global_export.dart';


class FCCarouselSlidingCities extends ConsumerWidget {
  const FCCarouselSlidingCities({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FCApiState<List<City>> asyncSelectedCities = ref.watch(selectedCitiesProvider);
    final CarouselSliderController cSCntrl = ref.watch(carouselCntrlProvider);

    return switch (asyncSelectedCities) {
      Loading<List<City>>() || Initial<List<City>>() => Center(
        child: FCLoadingIndicator(
          color: Theme.of(context).textTheme.headlineLarge?.color,
          size: 50,
        )
      ),
      Failure<List<City>>(message: _) => Center(
        child: FCRefreshWidget(
          onPressed: () => ref.read(allCitiesProvider.notifier).fetchAllCities(),
        ),
      ),
      Success<List<City>>(data: final List<City> cities) => SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: CarouselSlider.builder(
          carouselController: cSCntrl,
          itemCount: cities.length,
          itemBuilder: (_, int pageIndex, __) {
            final City city = cities.elementAt(pageIndex);
            return CityWeatherCardWidget(city: city);
          },
          options: CarouselOptions(
            scrollPhysics: const BouncingScrollPhysics(),
            enlargeCenterPage: true,
            aspectRatio: context.screenWidth / context.screenHeight,
            onPageChanged: (int indexOfCityInView, _) {
              ref.read(selectedCityIndexProvider.notifier).state = indexOfCityInView;
            },
          ),
        ),
      ),
    };
  }
}


final Provider<CarouselSliderController> carouselCntrlProvider 
  = Provider<CarouselSliderController>((_) => CarouselSliderController());