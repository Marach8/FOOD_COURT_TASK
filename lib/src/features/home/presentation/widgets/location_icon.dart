import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:food_court/src/global_export.dart';

class LocationIcon extends StatefulWidget {
  const LocationIcon({super.key});

  @override
  State<LocationIcon> createState() => _LocationIconState();
}

class _LocationIconState extends State<LocationIcon> {
  bool isDone = false;
  static const double initialSize = 50;
  static const double finalSize = 40;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 1),
      tween: Tween<double>(
        begin: isDone ? finalSize : initialSize,
        end: isDone ? initialSize : finalSize,
      ),
      onEnd: () => setState(() => isDone = !isDone),
      builder: (_, double size, __) {
        return Icon(
          CupertinoIcons.placemark_fill, size: size,
          color: FCColors.red
        );
      }
    );
  }
}