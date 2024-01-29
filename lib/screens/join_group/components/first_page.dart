import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/widgets/text_field/gp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstPageJoin extends StatefulWidget {
  const FirstPageJoin({required this.controller});

  final PageController controller;

  @override
  State<FirstPageJoin> createState() => _FirstPageJoinState();
}

class _FirstPageJoinState extends State<FirstPageJoin> {
  @override
  Widget build(BuildContext context) {
    final joinGroupProvider = Provider.of<JoinGroupProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GPTextField(
                  controller: joinGroupProvider.controllerGroupCode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterGroupCode;
                    }
                    return null;
                  },
                  header: AppLocalizations.of(context)!.groupCode,
                  hint: AppLocalizations.of(context)!.enterGroupCode,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ]),
              // const SizedBox(height: kDefaultPadding / 2),
              // StaticText(
              //   text: AppLocalizations.of(context)!.feeNotRefundable,
              //   maxLines: 2,
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
