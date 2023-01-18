import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/individual_group_settings/components/exit_group.dart';
import 'package:groupup/screens/individual_group_settings/components/number_participants.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/screens/individual_group_settings/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BodySettings extends StatelessWidget {
  const BodySettings({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final createGroupProvider =
        Provider.of<CreateGroupProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(
                  width: 250,
                  child: LargeBody(
                    text: 'Everyone can edit group picture',
                    maxLines: 2,
                  )),
              const Spacer(),
              SwitchButton(
                onChanged: (value) {
                  createGroupProvider.updateAllowEditImage(value);
                },
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 1.5),
          Row(
            children: [
              const SizedBox(
                width: 250,
                child: LargeBody(text: 'Allow refund request'),
              ),
              const Spacer(),
              SwitchButton(
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 1.5),
          Row(
            children: [
              const SizedBox(
                width: 250,
                child: LargeBody(
                  text: 'Maximum number of participants',
                  maxLines: 2,
                ),
              ),
              const Spacer(),
              ButtonCommonStyle(
                child: SizedBox(
                  width: 60,
                  child: LargeBody(
                    text: (groups.maxParticipants).toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
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
                                    height: 200,
                                    child: MaxNumberParticipants(
                                      groups: groups,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const SizedBox(
                width: 150,
                child: LargeBody(text: 'Group code'),
              ),
              const Spacer(),
              ShareButton(
                text: groups.groupCode,
                onPressed: () async {
                  await Share.share(groups.groupCode);
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.125),
          OtherOptions(
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
                              children: const [
                                SizedBox(height: 150, child: ExitGroup()),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              text: 'Exit group'),
          const SizedBox(height: Insets.l),
          OtherOptions(
              onPressed: () {
                createGroupProvider.confirmDeleteGroup(context, groups.id);
              }, text: 'Delete group', color: Colors.red),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }
}
