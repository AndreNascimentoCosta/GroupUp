import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/design-system.dart';

Future<void> gpModalBottomSheet(
  BuildContext context,
  double height,
  Widget child, {
  bool isDismissible = true,
  bool withBorder = true,
  bool enableDrag = true,
}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    context: context,
    shape: withBorder
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Insets.m,
            ),
          )
        : null,
    builder: (context) {
      return Padding(
        padding: context.screenViewInsets,
        child: Wrap(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: height,
                  child: child,
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
