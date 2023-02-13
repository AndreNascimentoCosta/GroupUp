import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NameAdd extends StatefulWidget {
  const NameAdd({required this.controller});

  final PageController controller;

  @override
  State<NameAdd> createState() => _NameAddState();
}

class _NameAddState extends State<NameAdd> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 2),
            child: StaticText(
              text: AppLocalizations.of(context).name,
              textAlign: TextAlign.center,
              fontFamily: 'Montserrat-SemiBold',
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
                  child: TextFieldModelHome(
                    controller: phoneProvider.nameController,
                    autoFocus: true,
                    validator: (value) {
                      if (value!.isNotEmpty && value.length < 3) {
                        return AppLocalizations.of(context).nameValidatorAtLeast3Chars;
                      } else {
                        return null;
                      }
                    },
                    header: AppLocalizations.of(context).name,
                    hint: AppLocalizations.of(context).enterName,
                    autoFillHints: const [AutofillHints.name],
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                  ),
                ),
              ),
            ),
          ),
          NextButton(
            onPressed: phoneProvider.nextPressedName(context),
          ),
          const SizedBox(height: kDefaultPadding / 4)
        ],
      ),
    );
  }
}
