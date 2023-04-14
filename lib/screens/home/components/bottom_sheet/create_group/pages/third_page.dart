import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/providers/mix_panel_provider.dart';

class ThirdPageCreate extends StatelessWidget {
  const ThirdPageCreate({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    if (createGroupProvider.isCreatingGroup) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: context.screenHeight * 0.035),
          SvgPicture.asset(
            'assets/icons/completed.svg',
            height: context.screenHeight * 0.2,
            width: context.screenHeight * 0.2,
            color: kPrimaryColor,
          ),
          const SizedBox(height: kDefaultPadding),
          StaticText(
            text: appLocalizations.completed,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 28,
            color: kPrimaryColor,
          ),
          SizedBox(height: context.screenHeight * 0.035),
          Row(
            children: [
              SizedBox(
                width: 180,
                child: StaticText(
                  text: appLocalizations.groupCode,
                  fontSize: TextSize.lBody,
                ),
              ),
              const Spacer(),
              ShareButton(
                text: createGroupProvider.newGroup.groupCode,
                onPressed: () async {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Share Group Code');
                  await Share.share(
                    appLocalizations.shareGroupCodeText(
                      createGroupProvider.newGroup.projectName,
                      createGroupProvider.newGroup.groupCode,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
