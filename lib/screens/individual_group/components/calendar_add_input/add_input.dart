import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/providers/mix_panel_provider.dart';
import '../../../create_group/pages/first_page.dart';

class AddInput extends StatefulWidget {
  const AddInput({super.key});

  @override
  State<AddInput> createState() => _AddInputState();
}

class _AddInputState extends State<AddInput> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final String currentDate = DateFormat.yMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(
      DateTime.now(),
    );
    Future pickImage(ImageSource source) async {
      final navigatorState = context;
      final addInputProvider =
          Provider.of<AddInputProvider>(context, listen: false);
      try {
        addInputProvider.isLoading = true;
        final story = await ImagePicker().pickImage(
          source: source,
          imageQuality: 15,
        );
        if (story == null) {
          addInputProvider.isLoading = false;
          return;
        }
        addInputProvider.story = File(story.path);
        if (!mounted) return;
        final groupId =
            Provider.of<IndividualGroupProvider>(context, listen: false)
                .group
                ?.id;
        if (groupId == null) return;
        await addInputProvider.addInput(context, groupId);
        addInputProvider.isLoading = false;
        if (addInputProvider.isClosed == true) {
          return;
        } else {
          navigatorState.pop();
        }
      } on PlatformException catch (e) {
        if (e.message == 'The user did not allow photo access.') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.allowPhotoAccess),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.failedPickImage),
              duration: const Duration(seconds: 2),
            ),
          );
        }
        addInputProvider.isLoading = false;
        context.pop();
        debugPrint('Failed to pick image: ${e.message}');
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
              GPTextHeader(
                text: appLocalizations.data,
                textAlign: TextAlign.center,
                fontFamily: 'MontSerrat-Medium',
              ),
              const SizedBox(height: Insets.l),
              Row(
                children: [
                  GPTextBody(
                    text: appLocalizations.dateAddData,
                    fontSize: 16,
                  ),
                  const SizedBox(width: Insets.l),
                  GPTextBody(
                    text: currentDate,
                    color: GPColors.secondaryColor,
                    fontSize: 16,
                  ),
                ],
              ),
              const SizedBox(height: Insets.l),
              Row(
                children: [
                  GPTextBody(
                    text: appLocalizations.dataAddData,
                    fontSize: 16,
                  ),
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
                          color: GPColors.black),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintText: appLocalizations.enterData,
                        suffixIcon: addInputProvider
                                .inputController.text.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: GPColors.black,
                                ),
                                onPressed: () {
                                  Provider.of<MixPanelProvider>(context,
                                          listen: false)
                                      .logEvent(eventName: 'Clear input field');
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
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(eventName: 'Add Media');
                    try {
                      addInputProvider.confirm(context, () {
                        context.pop();
                        pickImage(ImageSource.gallery);
                      }, () {
                        context.pop();
                        pickImage(ImageSource.camera);
                      }, group.id);
                    } catch (e) {
                      context.pop();
                      addInputProvider.isLoading = false;
                    }
                  },
                  child: addInputProvider.isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : GPTextBody(
                          text: 'OK',
                          textAlign: TextAlign.center,
                          color:
                              addInputProvider.inputController.text.isEmpty ||
                                      int.tryParse(addInputProvider
                                              .inputController.text) ==
                                          0
                                  ? GPColors.secondaryColor
                                  : GPColors.primaryColor,
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
