import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:provider/provider.dart';

class FirsPageCreate extends StatefulWidget {
  const FirsPageCreate({required this.controller});

  final PageController controller;

  @override
  State<FirsPageCreate> createState() => _FirsPageCreateState();
}

class _FirsPageCreateState extends State<FirsPageCreate> {
  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextFieldModelHome(
              controller: createGroupProvider.controllerProjectName,
              header: 'Project name',
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return 'Project name must be at least 3 characters';
                } else {
                  return null;
                }
              },
              textInputAction: TextInputAction.next,
              hint: 'Enter project name',
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextFieldModelHome(
              controller: createGroupProvider.controllerObjective,
              header: 'Objective',
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return 'Objective must be at least 3 characters';
                } else {
                  return null;
                }
              },
              hint: 'Enter objective',
              textInputAction: TextInputAction.next,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextFieldModelHome(
              controller: createGroupProvider.controllerReward,
              textInputAction: TextInputAction.done,
              prefixIcon: const SizedBox(
                height: 20,
                width: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: MediumBody(
                    text: 'R\$',
                  ),
                ),
              ),
              header: 'Reward',
              hint: '0,00',
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              inputFormatters: [
                ReplaceCommaFormatter(),
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,2}'),
                ),
              ],
            ),
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
