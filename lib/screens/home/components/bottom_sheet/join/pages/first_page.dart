import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirsPageJoin extends StatefulWidget {
  const FirsPageJoin({required this.controller});

  final PageController controller;

  @override
  State<FirsPageJoin> createState() => _FirsPageJoinState();
}

class _FirsPageJoinState extends State<FirsPageJoin> {
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
              TextFieldModelHome(
                controller: joinGroupProvider.controllerGroupCode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context).pleaseEnterGroupCode;
                  }
                  return null;
                },
                header: AppLocalizations.of(context).groupCode,
                hint: AppLocalizations.of(context).enterGroupCode,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              StaticText(
                text: AppLocalizations.of(context).feeNotRefundable,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
