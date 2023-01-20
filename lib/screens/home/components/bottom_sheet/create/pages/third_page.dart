import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ThirdPageCreate extends StatelessWidget {
  const ThirdPageCreate({super.key});

  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    if (createGroupProvider.isCreatingGroup) {
      return const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.035),
          SvgPicture.asset(
            'assets/icons/completed.svg',
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.height * 0.2,
            color: kPrimaryColor,
          ),
          const SizedBox(height: kDefaultPadding),
          const StandardTextStyle(
            text: 'Completed',
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 28,
            color: kPrimaryColor,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.035),
          Row(
            children: [
              const SizedBox(
                width: 180,
                child: StandardTextStyle(
                  text: 'Group code',
                  fontSize: TextSize.lBody,
                ),
              ),
              const Spacer(),
              ShareButton(
                text: createGroupProvider.newGroup.groupCode,
                onPressed: () async {
                  await Share.share(
                    'Join my group ${createGroupProvider.newGroup.projectName} on GroupUp! \nThe code is ${createGroupProvider.newGroup.groupCode}',
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
