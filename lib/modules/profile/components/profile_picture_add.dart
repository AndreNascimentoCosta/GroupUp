import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class ProfilePictureShow extends StatelessWidget {
  const ProfilePictureShow({
    required this.onPressedGallery,
    required this.onPressedCamera,
    required this.child,
  });

  final void Function() onPressedGallery;
  final void Function() onPressedCamera;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          CircleAvatar(
            radius: context.screenHeight * 0.06,
            backgroundColor: const Color(0XFFE1E1E1),
            child: child,
          ),
        ],
      ),
    );
  }
}
