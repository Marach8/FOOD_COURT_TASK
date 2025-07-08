import '../../../../global_export.dart';

class AddCityFAB extends StatelessWidget {
  const AddCityFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return FloatingActionButton(
          backgroundColor: Theme.of(context).textTheme.headlineMedium?.color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () => showAllCitiesForSelection(context),
          child: Icon(Icons.add, color: Theme.of(context).scaffoldBackgroundColor,),
        );
      }
    );
  }
}



