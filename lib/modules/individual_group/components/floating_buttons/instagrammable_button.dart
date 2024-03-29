import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/modules/individual_group/components/instagrammable/instagrammable.dart';
import 'package:provider/provider.dart';

class InstagrammableButton extends StatelessWidget {
  const InstagrammableButton({super.key});

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return const GPLoading();
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
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const InstagrammableScreen(),
              ),
            );
          },
          backgroundColor: GPColors.primaryColor,
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
