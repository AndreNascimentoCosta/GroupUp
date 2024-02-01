import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/core/widgets/text_field/gp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddUsername extends StatelessWidget {
  const AddUsername({required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 2),
            child: GPTextHeader(
              text: appLocalizations.name,
              textAlign: TextAlign.center,
              fontSize: 28,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  child: GPTextField(
                    controller: phoneProvider.nameController,
                    autoFocus: true,
                    validator: (value) {
                      if (value!.isNotEmpty && value.length < 3) {
                        return appLocalizations.nameValidatorAtLeast3Chars;
                      } else {
                        return null;
                      }
                    },
                    header: appLocalizations.name,
                    hint: appLocalizations.enterName,
                    autoFillHints: const [AutofillHints.name],
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    inputFormatters: [
                      if (phoneProvider.nameController.text.isEmpty)
                        FilteringTextInputFormatter.deny(
                          RegExp(r' '),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          GPButton(
            onPressed: phoneProvider.nextPressedName(context),
          ),
          const SizedBox(height: kDefaultPadding / 4)
        ],
      ),
    );
  }
}
