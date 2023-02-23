import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/instagrammable.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';

class InstagrammableButton extends StatelessWidget {
  const InstagrammableButton({super.key});

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    }
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: 'btn9',
          onPressed: () {
            Provider.of<MixPanelProvider>(context, listen: false)
                .logEvent(eventName: 'Instagrammable Screen');
            Provider.of<InstagrammableProvider>(context, listen: false)
                .setPlaceholderImages(
              'https://firebasestorage.googleapis.com/v0/b/groupup-432b8.appspot.com/o/choosePicture.png?alt=media&token=25743fdd-a3b1-4439-9a2a-ae477238a640',
            );
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const InstagrammableScreen(),
              ),
            );
          },
          backgroundColor: kPrimaryColor,
          highlightElevation: 0,
          elevation: 0,
          child: const Icon(
            Icons.mobile_screen_share_rounded,
            size: 30,
          ),
        ),
      ),
    );
  }
}
