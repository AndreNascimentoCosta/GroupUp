import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/body_instagrammable.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/share_instagrammable_button.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/mix_panel_provider.dart';

class InstagrammableScreen extends StatefulWidget {
  const InstagrammableScreen({super.key});

  @override
  State<InstagrammableScreen> createState() => _InstagrammableScreenState();
}

class _InstagrammableScreenState extends State<InstagrammableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GPColors.white,
      body: const BodyInstagrammable(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
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
                        Provider.of<MixPanelProvider>(context, listen: false)
                            .logEvent(eventName: 'Close Instagrammable');
                        context.pop();
                      },
                      backgroundColor: GPColors.primaryColor,
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
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
