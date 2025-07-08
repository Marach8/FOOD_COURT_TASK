import '../global_export.dart';

class FCDivider extends StatelessWidget {
  const FCDivider({
    super.key,
    this.axis = AxisType.horizontal,
    this.height
  });

  final AxisType? axis;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final bool isHorizontal = axis == AxisType.horizontal;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.3),
      height: isHorizontal ? 0.5 : height,
      width: isHorizontal ? context.screenWidth : 0.5,
      child: const SizedBox.shrink(),
    );
  }
}

enum AxisType {vertical, horizontal}