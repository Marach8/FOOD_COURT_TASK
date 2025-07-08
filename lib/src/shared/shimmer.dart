import 'package:shimmer/shimmer.dart';
import '../global_export.dart';

class FCShimmer extends StatelessWidget {
  const FCShimmer({
    super.key,
    this.height,
    this.width,
    this.color,
    this.margin,
    this.radius
  });

  final double? height, width, radius;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: (color ?? FCColors.hex9098A3).withValues(alpha: 0.8),
      highlightColor: (color ?? FCColors.hex9098A3).withValues(alpha: 0.7),
      child: FCContainer(
        margin: margin,
        height: height ?? 40, radius: radius ?? 5,
        color: (color ?? FCColors.hex9098A3).withValues(alpha: 0.8),
        width: width ?? context.screenWidth,
        child: const SizedBox.shrink(),
      )
    );
  }
}
