import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';

class ProfilePictureBottomSheet extends StatelessWidget {
  const ProfilePictureBottomSheet({required this.gallery, required this.photo});

  final void Function() gallery;
  final void Function() photo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonCommonStyle(
            onPressed: () {
              gallery;
            },
            child: const LargeBody(
              text: 'Choose from gallery',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () {
              photo;
            },
            child: const LargeBody(
              text: 'Take photo',
              textAlign: TextAlign.center,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
