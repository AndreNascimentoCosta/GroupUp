import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/add_input_provider.dart';
import 'package:groupup/screens/individual_group/components/individual_group_provider.dart';
import 'package:groupup/styles/text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddInput extends StatelessWidget {
  AddInput({super.key});

  final String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final addInputProvider = Provider.of<AddInputProvider>(context);
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
                      keyboardType: TextInputType.number,
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
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  final groupId = Provider.of<IndividualGroupProvider>(context,
                          listen: false)
                      .group
                      ?.id;
                  Navigator.pop(context);
                  if (groupId == null) return;
                  addInputProvider.addInput(context, groupId);
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
