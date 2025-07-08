import 'package:food_court/src/global_export.dart';

class FCHomeScreen extends StatelessWidget {
  const FCHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.ref.read(allCitiesProvider.notifier).fetchAllCities()
    );

    return FCAnnotatedRegion(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            FCStrings.SELECTED_CITIES,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: const SafeArea(child: FCCarouselSlidingCities()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              UseCurrentLocationFAB(),
              AddCityFAB(),
            ],
          ),
        ),
        extendBody: true,

        bottomSheet: const SizedBox(
          height: 50,
          child: HomeDotIndicator()
        )
      ),
    );
  }
}
