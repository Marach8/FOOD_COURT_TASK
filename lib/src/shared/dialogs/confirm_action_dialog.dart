import '../../global_export.dart';

Future<bool?> confirmActionDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String yesString,
  required String noString
}) async{
  return await showDialog<bool?>(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).textTheme.headlineMedium?.color,
      contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              title, maxLines: 3, textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.7)
              ),
            ),
          ),
          if(content.isNotEmpty)Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              content, maxLines: 3, textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.7)
              ),
            ),
          ),
          const AfriDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context, true),
                child: Text(
                  yesString,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.7)
                  ),
                ),
              ),
              const AfriDivider(axis: AxisType.vertical, height: 50),
              GestureDetector(
                onTap: () => Navigator.pop(context, false),
                child: Text(
                  noString,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.7)
                  ),
                ),
              ),
            ],
          )
        ],
      )
    )
  );
}
