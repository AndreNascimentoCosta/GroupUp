import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/modules/edit_profile/screens/edit_profile.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/mix_panel_provider.dart';

class AppBarRefundRequests extends StatelessWidget implements PreferredSizeWidget {
  const AppBarRefundRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: context.screenWidth,
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.2,
                      color: Color(0xffa1a1a1),
                    ),
                  ),
                ),
                alignment: AlignmentDirectional.center,
                child: const GPTextHeader(text: 'Refund requests'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: ButtonCommonStyle(
                  child: const GPIcon(
                    GPIcons.arrowLeft,
                    color: GPColors.black,
                    height: Insets.l * 1.25,
                    width: Insets.l * 1.25,
                  ),
                  onPressed: () {
                    Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                        eventName:
                            'Back to Edit Profile Screen from Refund Requests Screen');
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                        settings: const RouteSettings(name: 'Edit_Profile'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
