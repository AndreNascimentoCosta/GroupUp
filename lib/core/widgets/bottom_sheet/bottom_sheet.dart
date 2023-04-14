import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';

class BuilderBottomSheet extends StatelessWidget {
  const BuilderBottomSheet({required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
  }
}
