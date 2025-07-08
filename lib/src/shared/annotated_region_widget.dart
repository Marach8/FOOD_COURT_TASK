import 'package:flutter/services.dart';
import '../global_export.dart';

class FCAnnotatedRegion extends StatelessWidget {
  const FCAnnotatedRegion({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool inDarkMode = context.inDarkMode;
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: inDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: inDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: child
    );
  }
}