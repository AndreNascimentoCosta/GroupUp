import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:provider/provider.dart';
import 'package:currency_picker/currency_picker.dart';

class FirsPageCreate extends StatefulWidget {
  const FirsPageCreate({required this.controller});

  final PageController controller;

  @override
  State<FirsPageCreate> createState() => _FirsPageCreateState();
}

class _FirsPageCreateState extends State<FirsPageCreate> {
  String groupCurrencySymbol = '\$';
  final node1 = FocusNode();
  final node2 = FocusNode();
  final node3 = FocusNode();
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
              focusNode: node1,
              controller: createGroupProvider.controllerProjectName,
              submitted: (String value) {
                FocusScope.of(context).nextFocus();
              },
              header: 'Project name',
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return 'Project name must be at least 3 characters';
                } else if (value.length >= 20) {
                  return 'Project name must be less than 20 characters';
                } else {
                  return null;
                }
              },
              maxLength: 20,
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
                } else if (value.length >= 50) {
                  return 'Objective must be less than 50 characters';
                } else {
                  return null;
                }
              },
              maxLength: 50,
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
                      const StaticText(
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
                            currencyFilter: [
                              'USD'
                              'AED',
                              'AFN',
                              'ALL',
                              'AMD',
                              'ANG',
                              'AOA',
                              'ARS',
                              'AUD',
                              'AWG',
                              'AZN',
                              'BAM',
                              'BBD',
                              'BDT',
                              'BGN',
                              'BIF',
                              'BMD',
                              'BND',
                              'BOB',
                              'BRL',
                              'BSD',
                              'BWP',
                              'BYN',
                              'BZD',
                              'CAD',
                              'CDF',
                              'CHF',
                              'CLP',
                              'CNY',
                              'COP',
                              'CRC',
                              'CVE',
                              'CZK',
                              'DJF',
                              'DKK',
                              'DOP',
                              'DZD',
                              'EGP',
                              'ETB',
                              'EUR',
                              'FJD',
                              'FKP',
                              'GBP',
                              'GEL',
                              'GIP',
                              'GMD',
                              'GNF',
                              'GTQ',
                              'GYD',
                              'HKD',
                              'HNL',
                              'HRK',
                              'HTG',
                              'HUF',
                              'IDR',
                              'ILS',
                              'INR',
                              'ISK',
                              'JMD',
                              'JPY',
                              'KES',
                              'KGS',
                              'KHR',
                              'KMF',
                              'KRW',
                              'KYD',
                              'KZT',
                              'LAK',
                              'LBP',
                              'LKR',
                              'LRD',
                              'LSL',
                              'MAD',
                              'MDL',
                              'MGA',
                              'MKD',
                              'MMK',
                              'MNT',
                              'MOP',
                              'MRO',
                              'MUR',
                              'MVR',
                              'MWK',
                              'MXN',
                              'MYR',
                              'MZN',
                              'NAD',
                              'NGN',
                              'NIO',
                              'NOK',
                              'NPR',
                              'NZD',
                              'PAB',
                              'PEN',
                              'PGK',
                              'PHP',
                              'PKR',
                              'PLN',
                              'PYG',
                              'QAR',
                              'RON',
                              'RSD',
                              'RUB',
                              'RWF',
                              'SAR',
                              'SBD',
                              'SCR',
                              'SEK',
                              'SGD',
                              'SHP',
                              'SLE',
                              'SLL',
                              'SOS',
                              'SRD',
                              'STD',
                              'SZL',
                              'THB',
                              'TJS',
                              'TOP',
                              'TRY',
                              'TTD',
                              'TWD',
                              'TZS',
                              'UAH',
                              'UGX',
                              'UYU',
                              'UZS',
                              'VND',
                              'VUV',
                              'WST',
                              'XAF',
                              'XCD',
                              'XOF',
                              'XPF',
                              'YER',
                              'ZAR',
                              'ZMW',
                            ],
                            onSelect: (Currency currency) {
                              setState(
                                () {
                                  groupCurrencySymbol = currency.symbol;
                                  createGroupProvider.groupCurrencyCode =
                                      currency.code;
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
                            text: groupCurrencySymbol,
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
                      header: 'Group fee*',
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
            const SizedBox(height: Insets.s),
            const Padding(
              padding: EdgeInsets.only(
                left: 130,
                right: 20,
              ),
              child: StaticText(
                text:
                    '*Each participant will pay the fee and the total amount will be used as the group reward.',
                maxLines: 3,
              ),
            )
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
