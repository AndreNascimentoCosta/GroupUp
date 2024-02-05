import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/widgets/text_field/gp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JoinGroupFirstPage extends StatefulWidget {
  const JoinGroupFirstPage({required this.controller});

  final PageController controller;

  @override
  State<JoinGroupFirstPage> createState() => _JoinGroupFirstPageState();
}

class _JoinGroupFirstPageState extends State<JoinGroupFirstPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
                    return appLocalizations.pleaseEnterGroupCode;
                  }
                  return null;
                },
                header: appLocalizations.groupCode,
                hint: appLocalizations.enterGroupCode,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
              ),
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
