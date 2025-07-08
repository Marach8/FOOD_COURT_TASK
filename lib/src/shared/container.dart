import '../global_export.dart';

class FCContainer extends StatelessWidget {
  const FCContainer({
    super.key,
    this.padding,
    this.color,
    this.height,
    this.width,
    this.radius,
    this.border,
    this.margin,
    this.gradient,
    this.boxShape,
    this.constraints,
    this.alignment,
    this.duration,
    this.decorationImageFit,
    this.decorationImagePath,
    this.child,
    this.clipBehavior = Clip.none,
    this.boxShadow,
    this.curve = Curves.linear,
    this.onTap,
    this.onLongPress
  });

  final EdgeInsetsGeometry? padding, margin;
  final Color? color;
  final double? height, width, radius;
  final BoxBorder? border;
  final Widget? child;
  final BoxShape? boxShape;
  final BoxConstraints? constraints;
  final Gradient? gradient;
  final AlignmentGeometry? alignment;
  final String? decorationImagePath;
  final BoxFit? decorationImageFit;
  final int? duration;
  final Clip clipBehavior;
  final List<BoxShadow>? boxShadow;
  final Curve curve;
  final VoidCallback? onTap, onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        curve: curve,
        clipBehavior: clipBehavior,
        duration: Duration(milliseconds: duration ?? 500),
        alignment: alignment,
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        constraints: constraints,
        decoration: BoxDecoration(
          image: decorationImagePath != null ? DecorationImage(
            fit: decorationImageFit ?? BoxFit.cover,
            image: AssetImage(decorationImagePath!)
          ) : null,
          gradient: gradient,
          shape: boxShape ?? BoxShape.rectangle,
          color: color,
          border: border,
          boxShadow: boxShadow,
          borderRadius: boxShape == null ? BorderRadius.circular(radius ?? 0) : null
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}