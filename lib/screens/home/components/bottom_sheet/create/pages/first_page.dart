// ignore_for_file: constant_identifier_names

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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Currencies {
  AND(0.3),
  AWG(0.3),
  AZN(0.3),
  BAM(0.3),
  BBD(0.3),
  BMD(0.3),
  BND(0.3),
  BSD(0.3),
  BZD(0.3),
  FKP(0.3),
  GBP(0.3),
  GIP(0.3),
  KYD(0.3),
  PAB(0.3),
  USD(0.5),
  AUD(0.5),
  BRL(0.5),
  BYN(0.5),
  CAD(0.5),
  CHF(0.5),
  EUR(0.5),
  FJD(0.5),
  GEL(0.5),
  HRK(0.5),
  ILS(0.5),
  INR(0.5),
  NZD(0.5),
  PEN(0.5),
  PGK(0.5),
  QAR(0.5),
  SGD(0.5),
  SAR(0.5),
  TJS(0.5),
  TOP(0.5),
  WST(0.5),
  XCD(0.5),
  BGN(1),
  BOB(1),
  CNY(1),
  GTQ(1),
  MOP(1),
  SBD(1),
  SHP(1),
  TTD(1),
  BWP(1.5),
  MAD(1.5),
  AED(2),
  LSL(2),
  MYR(2),
  PLN(2),
  RON(2),
  SCR(2),
  SZL(2),
  ZAR(2),
  DKK(2.5),
  MDL(2.5),
  MVR(2.5),
  NAD(2.5),
  NOK(3),
  SEK(3),
  TRY(3),
  ZMW(3),
  EGP(5),
  HKD(5),
  HNL(5),
  MRO(5),
  NIO(5),
  SRD(5),
  TWD(5),
  UAH(5),
  UYU(5),
  PHP(7.5),
  DOP(10),
  ETB(10),
  GMD(10),
  MKD(10),
  MUR(10),
  MXN(10),
  MZN(10),
  THB(10),
  RUB(10),
  AFN(12),
  ALL(12),
  BDT(15),
  CZK(15),
  CVE(15),
  KES(15),
  KGS(15),
  NPR(15),
  RSD(15),
  XPF(15),
  DZD(20),
  ISK(20),
  JMD(20),
  HTG(20),
  LRD(20),
  VUV(20),
  ARS(25),
  DJF(25),
  GYD(25),
  SLE(25),
  PKR(30),
  YER(30),
  AMD(45),
  SLL(45),
  JPY(50),
  KMF(50),
  KZT(50),
  LKR(50),
  AOA(55),
  NGN(55),
  CRC(75),
  SOS(75),
  XAF(75),
  XOF(75),
  CLP(100),
  HUF(100),
  KRW(150),
  MWK(150),
  RWF(150),
  BIF(250),
  CDF(250),
  MMK(250),
  TZS(250),
  COP(475),
  MNT(475),
  UGX(475),
  KHR(500),
  MGA(500),
  GNF(1000),
  PYG(1000),
  UZS(1250),
  IDR(1750),
  LBP(1750),
  LAK(2000),
  STD(2500),
  VND(2500);

  final double minValue;

  const Currencies(this.minValue);
}

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
    final appLocalizations = AppLocalizations.of(context);
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
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextFieldModelHome(
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
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      StaticText(
                        text: appLocalizations.currency,
                        fontSize: TextSize.lBody,
                      ),
                      const SizedBox(height: Insets.xs),
                      ButtonCommonStyle(
                        onPressed: () {
                          showCurrencyPicker(
                            context: context,
                            showFlag: true,
                            searchHint: appLocalizations.searchCountry,
                            showCurrencyName: true,
                            showCurrencyCode: true,
                            favorite: [
                              'USD',
                              'BRL',
                              'EUR',
                              'GBP',
                            ],
                            currencyFilter: [
                              'USD',
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
                              createGroupProvider.controllerReward.clear();
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
                        double minValueCurrencies = Currencies.values
                            .firstWhere(
                              (element) =>
                                  element.name ==
                                  createGroupProvider.groupCurrencyCode,
                            )
                            .minValue;
                        if ((double.tryParse(value!) ?? 0) <
                                minValueCurrencies &&
                            (double.tryParse(value) ?? 0) > 0) {
                          return appLocalizations.feeGreaterThan(
                              minValueCurrencies.toStringAsFixed(2));
                        } else {
                          return null;
                        }
                      },
                      header: appLocalizations.groupFee,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: StaticText(
                text:
                    appLocalizations.groupFeeDescription,
                maxLines: 4,
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
