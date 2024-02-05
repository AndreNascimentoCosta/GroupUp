// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/text_field/gp_text_field.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateGroupFirsPage extends StatefulWidget {
  const CreateGroupFirsPage({required this.controller});

  final PageController controller;

  @override
  State<CreateGroupFirsPage> createState() => _CreateGroupFirsPageState();
}

class _CreateGroupFirsPageState extends State<CreateGroupFirsPage> {
  final node1 = FocusNode();
  final node2 = FocusNode();
  final node3 = FocusNode();
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: context.screenHeight * 0.035),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  GPTextHeader(
                    text: appLocalizations.important.toUpperCase(),
                    fontSize: 14,
                  ),
                  const SizedBox(height: 10),
                  GPTextBody(
                    text: appLocalizations.groupDescription,
                    maxLines: 15,
                  ),
                ],
              ),
            ),
            SizedBox(height: context.screenHeight * 0.02),
            GPTextField(
              focusNode: node1,
              controller: createGroupProvider.controllerProjectName,
              submitted: (String value) {
                FocusScope.of(context).nextFocus();
              },
              header: appLocalizations.projectName,
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return appLocalizations.projectNameValidatorMinChars;
                } else if (value.length >= 20) {
                  return appLocalizations.projectNameValidatorMaxChars;
                } else {
                  return null;
                }
              },
              maxLength: 20,
              textInputAction: TextInputAction.next,
              hint: appLocalizations.enterProjectName,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              inputFormatters: [
                if (createGroupProvider.controllerProjectName.text.isEmpty)
                  FilteringTextInputFormatter.deny(
                    RegExp(r' '),
                  )
              ],
            ),
            SizedBox(height: context.screenHeight * 0.035),
            GPTextField(
              focusNode: node2,
              controller: createGroupProvider.controllerObjective,
              header: appLocalizations.objective,
              submitted: (String value) {
                FocusScope.of(context).nextFocus();
              },
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return appLocalizations.objectiveValidatorMinChars;
                } else if (value.length >= 50) {
                  return appLocalizations.objectiveValidatorMaxChars;
                } else {
                  return null;
                }
              },
              maxLength: 50,
              hint: appLocalizations.enterObjective,
              textInputAction: TextInputAction.next,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              inputFormatters: [
                if (createGroupProvider.controllerObjective.text.isEmpty)
                  FilteringTextInputFormatter.deny(
                    RegExp(r' '),
                  )
              ],
            ),
            SizedBox(height: context.screenHeight * 0.035),
            Padding(
              padding: const EdgeInsets.only(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GPTextField(
                      focusNode: node3,
                      controller: createGroupProvider.controllerReward,
                      textInputAction: TextInputAction.done,
                      maxLength: 50,
                      validator: (value) {
                        if (value!.isNotEmpty && value.length < 3) {
                          return appLocalizations.rewardValidatorMinChars;
                        } else if (value.length >= 50) {
                          return appLocalizations.rewardValidatorMaxChars;
                        } else {
                          return null;
                        }
                      },
                      header: appLocalizations.reward,
                      hint: appLocalizations.enterReward,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Insets.s),
          ],
        ),
      ),
    );
  }
}

class ReplaceCommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(',', '.'),
      selection: newValue.selection,
    );
  }
}
