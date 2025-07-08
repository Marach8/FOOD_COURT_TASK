import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'src/global_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (_) => const ProviderScope(child: FCApp())
  //   ),
  // );
  
  runApp(const ProviderScope(child: FCApp()));
}


class FCApp extends StatelessWidget {
  const FCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: FCThemeData.darkTheme,
        theme: FCThemeData.lightTheme,
        home: const FCHomeScreen(),
      ),
    );
  }
}