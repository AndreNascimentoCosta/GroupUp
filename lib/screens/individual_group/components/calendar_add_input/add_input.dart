import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:groupup/styles/text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../home/components/bottom_sheet/create/pages/first_page.dart';

class AddInput extends StatefulWidget {
  const AddInput({super.key});

  @override
  State<AddInput> createState() => _AddInputState();
}

class _AddInputState extends State<AddInput> {
  final String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
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
              const Header(
                text: 'Data',
                textAlign: TextAlign.center,
                fontFamily: 'MontSerrat-Medium',
              ),
              const SizedBox(height: Insets.l),
              Row(
                children: [
                  const LargeBody(text: 'Date:'),
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
                  const LargeBody(text: 'Data:'),
                  const SizedBox(width: Insets.l),
                  SizedBox(
                    width: 200,
                    child: TextField(
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
                        hintText: 'Enter data',
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
              TextButton(
                onPressed: () {
                  // final groupId = Provider.of<IndividualGroupProvider>(context,
                  //         listen: false)
                  //     .group
                  //     ?.id;
                  // Navigator.pop(context);
                  // if (groupId == null) return;
                  // addInputProvider.addInput(context, groupId);
                  addInputProvider.confirm(context, () {
                    pickImage(ImageSource.gallery);
                  }, () {
                    pickImage(ImageSource.camera);
                  }, group.id);
                },
                child: const StandardTextStyle(
                  text: 'OK',
                  fontSize: TextSize.mBody,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
