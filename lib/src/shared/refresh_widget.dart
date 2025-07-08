import 'dart:ui' show ImageFilter;
import '../global_export.dart';

class FCRefreshWidget extends StatelessWidget {
  const FCRefreshWidget({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: FCContainer(
          border: Border.all(
            color: Theme.of(context).textTheme.headlineLarge?.color ?? FCColors.hex1B1B1B,
          ),
          onTap: onPressed,
          radius: 10, width: 50, height: 50,
          child: const Icon(Icons.rotate_right_outlined, size: 35),
        ),
      ),
    );
  }
}
