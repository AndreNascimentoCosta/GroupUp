import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';

class ProfilePictureAdd extends StatelessWidget {
  const ProfilePictureAdd({
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
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.m),
          ),
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding * 1.75),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonCommonStyle(
                                  onPressed: onPressedGallery,
                                  child: const LargeBody(
                                    text: 'Choose from gallery',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: Insets.l * 1.75),
                                ButtonCommonStyle(
                                  onPressed: onPressedCamera,
                                  child: const LargeBody(
                                    text: 'Take photo',
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.06,
              backgroundColor: const Color(0XFFE1E1E1),
              child: child),
        ],
      ),
    );
  }
}
