import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/body_instagrammable.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/share_instagrammable_button.dart';

class InstagrammableScreen extends StatefulWidget {
  const InstagrammableScreen({super.key});

  @override
  State<InstagrammableScreen> createState() => _InstagrammableScreenState();
}

class _InstagrammableScreenState extends State<InstagrammableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const BodyInstagrammable(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: 'btn11',
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: kPrimaryColor,
                  highlightElevation: 0,
                  elevation: 0,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 40,
                  ),
                ),
              ),
            ),
            const ShareInstagrammableButton(),
          ],
        ),
      ),
    );
  }
}
