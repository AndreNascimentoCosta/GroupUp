import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/individual_group_settings/components/exit_group.dart';
import 'package:groupup/screens/individual_group_settings/components/number_participants.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/screens/individual_group_settings/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:share_plus/share_plus.dart';

class BodySettings extends StatelessWidget {
  const BodySettings({required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
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
            children: const [
              SizedBox(
                  width: 250,
                  child: LargeBody(
                    text: 'Everyone can edit group picture',
                    maxLines: 2,
                  )),
              Spacer(),
              SwitchButton(),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 1.5),
          Row(
            children: const [
              SizedBox(
                width: 250,
                child: LargeBody(text: 'Allow refund request'),
              ),
              Spacer(),
              SwitchButton(),
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
                    text: (groupModel.userInformation.length + 1).toString(),
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
                                      groupModel: groupModel,
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
                onPressed: () async {
                  await Share.share('846264');
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
              onPressed: () {}, text: 'Delete group', color: Colors.red),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }
}
