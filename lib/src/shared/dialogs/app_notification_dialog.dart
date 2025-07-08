import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import '../../global_export.dart';

Future<dynamic> showAppNotification({
  required BuildContext context,
  required String text,
  required bool isSuccess,
  int? duration,
}) async {
  late Flushbar<dynamic> flushbar;

  flushbar = Flushbar<dynamic>(
    backgroundColor: FCColors.transparent,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(milliseconds: duration ?? 2000),
    messageText: Center(
      child: CustomPaint(
        painter: _LeftBorderPainter(
          color: isSuccess ? FCColors.hex10B981 : FCColors.red,
        ),
        child: FCContainer(
          margin: const EdgeInsets.only(left: 5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 24,
              spreadRadius: 0,
              offset: const Offset(0, 16),
              color: (Theme.of(context).textTheme.headlineMedium?.color ?? FCColors.black).withValues(alpha: 0.5),
            ),
          ],
          radius: 8,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(isSuccess) Icon(CupertinoIcons.checkmark_alt_circle, color: FCColors.hex10B981,)
              else Icon(Icons.warning_rounded, color: FCColors.red,),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  text, maxLines: 3,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(width: 50,),
              GestureDetector(
                onTap: () => flushbar.dismiss(),
                child: Icon(Icons.close, color: Theme.of(context).textTheme.bodySmall?.color),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  return flushbar.show(context);
}


class _LeftBorderPainter extends CustomPainter {
  
  _LeftBorderPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    const double curveWidth = 15;
    const double startPoint = 13;

    path.moveTo(startPoint, 0);
    path.quadraticBezierTo(0, 0, 0, curveWidth);
    path.lineTo(0, size.height - curveWidth);
    path.quadraticBezierTo(0, size.height, startPoint, size.height);
    path.lineTo(curveWidth, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
