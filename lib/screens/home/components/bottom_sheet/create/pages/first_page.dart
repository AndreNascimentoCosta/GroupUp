import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';
import 'package:currency_picker/currency_picker.dart';

class FirsPageCreate extends StatefulWidget {
  const FirsPageCreate({required this.controller});

  final PageController controller;

  @override
  State<FirsPageCreate> createState() => _FirsPageCreateState();
}

class _FirsPageCreateState extends State<FirsPageCreate> {
  String currency2 = '\$';
  final node1 = FocusNode();
  final node2 = FocusNode();
  final node3 = FocusNode();
  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    return GestureDetector(
      // onTap: () {
      //   FocusScopeNode currentFocus = FocusScope.of(context);
      //   if (!currentFocus.hasPrimaryFocus) {
      //     currentFocus.unfocus();
      //   }
      // },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextFieldModelHome(
              focusNode: node1,
              controller: createGroupProvider.controllerProjectName,
              submitted: (String value) {
                FocusScope.of(context).nextFocus();
              },
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
              focusNode: node2,
              controller: createGroupProvider.controllerObjective,
              header: 'Objective',
              submitted: (String value) {
                FocusScope.of(context).nextFocus();
              },
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
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const StandardTextStyle(
                        text: 'Currency',
                        fontSize: TextSize.lBody,
                      ),
                      const SizedBox(height: Insets.xs),
                      ButtonCommonStyle(
                        onPressed: () {
                          showCurrencyPicker(
                            context: context,
                            showFlag: true,
                            showCurrencyName: true,
                            showCurrencyCode: true,
                            onSelect: (Currency currency) {
                              setState(
                                () {
                                  currency2 = currency.symbol;
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kSecondaryColor,
                            ),
                            borderRadius: BorderRadius.circular(Insets.s),
                          ),
                          child: MediumBody(
                            text: currency2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFieldModelHome(
                      focusNode: node3,
                      controller: createGroupProvider.controllerReward,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            (double.tryParse(value) ?? 0) <= 0.0) {
                          return 'Reward must be greater than 0';
                        } else {
                          return null;
                        }
                      },
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
                  ),
                ],
              ),
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
