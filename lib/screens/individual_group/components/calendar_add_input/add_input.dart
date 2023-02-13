import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../home/components/bottom_sheet/create/pages/first_page.dart';

class AddInput extends StatefulWidget {
  const AddInput({super.key});

  @override
  State<AddInput> createState() => _AddInputState();
}

class _AddInputState extends State<AddInput> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final String currentDate = DateFormat.yMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(
      DateTime.now(),
    );
    Future pickImage(ImageSource source) async {
      Navigator.pop(context);
      final addInputProvider =
          Provider.of<AddInputProvider>(context, listen: false);
      try {
        final story = await ImagePicker().pickImage(
          source: source,
          imageQuality: 15,
        );
        if (story == null) return;

        addInputProvider.story = File(story.path);
        if (!mounted) return;
        final groupId =
            Provider.of<IndividualGroupProvider>(context, listen: false)
                .group
                ?.id;
        Navigator.pop(context);
        if (groupId == null) return;
        await addInputProvider.addInput(context, groupId);
      } on PlatformException catch (e) {
        // ignore: avoid_print
        print('Failed to pick image: $e');
      }
    }

    final addInputProvider = Provider.of<AddInputProvider>(context);
    final group =
        Provider.of<IndividualGroupProvider>(context, listen: false).group;
    if (group == null) return const SizedBox();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Insets.l),
              Header(
                text: appLocalizations.data,
                textAlign: TextAlign.center,
                fontFamily: 'MontSerrat-Medium',
              ),
              const SizedBox(height: Insets.l),
              Row(
                children: [
                  LargeBody(text: appLocalizations.dateAddData),
                  const SizedBox(width: Insets.l),
                  LargeBody(
                    text: currentDate,
                    color: kSecondaryColor,
                  ),
                ],
              ),
              const SizedBox(height: Insets.l),
              Row(
                children: [
                  LargeBody(text: appLocalizations.dataAddData),
                  const SizedBox(width: Insets.l),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: addInputProvider.inputController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                          fontFamily: 'Montserrat-Regular',
                          fontSize: TextSize.lBody,
                          color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintText: appLocalizations.enterData,
                        suffixIcon:
                            addInputProvider.inputController.text.isEmpty
                                ? null
                                : IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      addInputProvider.inputController.clear();
                                    },
                                  ),
                        hintStyle: const TextStyle(
                          fontFamily: 'Montserrat-Regular',
                          fontSize: TextSize.lBody,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        if ((int.tryParse(value!) ?? 0) > 99999) {
                          return appLocalizations.dataValidatorMaxNum;
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        ReplaceCommaFormatter(),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,3}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: Insets.s),
                child: ButtonCommonStyle(
                  onPressed: () {
                    addInputProvider.confirm(context, () {
                      pickImage(ImageSource.gallery);
                    }, () {
                      pickImage(ImageSource.camera);
                    }, group.id);
                  },
                  child: addInputProvider.isLoading
                      ? const CircularProgressIndicator(
                          color: kPrimaryColor,
                        )
                      : StaticText(
                          text: 'OK',
                          textAlign: TextAlign.center,
                          fontSize: TextSize.mBody,
                          color:
                              addInputProvider.inputController.text.isEmpty ||
                                      int.tryParse(addInputProvider
                                              .inputController.text) ==
                                          0
                                  ? kSecondaryColor
                                  : kPrimaryColor,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
