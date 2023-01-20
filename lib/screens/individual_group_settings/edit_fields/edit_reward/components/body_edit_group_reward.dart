import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/pages/first_page.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_reward/edit_group_reward_provider.dart';
import 'package:provider/provider.dart';

class EditGroupRewardBody extends StatefulWidget {
  const EditGroupRewardBody({super.key});

  @override
  State<EditGroupRewardBody> createState() => _EditGroupRewardBodyState();
}

class _EditGroupRewardBodyState extends State<EditGroupRewardBody> {
  String currency2 = '\$';
  @override
  Widget build(BuildContext context) {
    final groupRewardController =
        Provider.of<EditGroupRewardProvider>(context).groupRewardController;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
                child: ButtonCommonStyle(
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
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                    child: MediumBody(
                      text: currency2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Insets.l),
              SizedBox(
                width: 250,
                child: TextFieldModel(
                  controller: groupRewardController,
                  hint: '',
                  validator: (value) {
                    if (value!.isEmpty &&
                        (double.tryParse(value) ?? 0) <= 0.0) {
                      return 'Reward must be greater than 0';
                    } else {
                      return null;
                    }
                  },
                  maxLength: 30,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kSecondaryColor,
                      width: 0.5,
                    ),
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
          const StaticText(
              text: 'Change group reward', fontSize: TextSize.mBody),
        ],
      ),
    );
  }
}
