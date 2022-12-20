import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/text.dart';
import 'package:intl/intl.dart';

class AddInput extends StatefulWidget {
  const AddInput({super.key});

  @override
  State<AddInput> createState() => _AddInputState();
}

class _AddInputState extends State<AddInput> {
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.addListener(() {
      setState(() {});
    });
  }

  String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
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
              const StandardTextStyle(
                  text: 'Data',
                  textAlign: TextAlign.center,
                  fontSize: TextSize.subTitle),
              const SizedBox(height: Insets.l),
              Row(
                children: [
                  const StandardTextStyle(
                      text: 'Date:', fontSize: TextSize.lBody),
                  const SizedBox(width: Insets.l),
                  StandardTextStyle(
                      text: currentDate,
                      fontSize: TextSize.lBody,
                      color: kSecondaryColor),
                ],
              ),
              const SizedBox(height: Insets.l),
              Row(
                children: [
                  const StandardTextStyle(
                      text: 'Add data:', fontSize: TextSize.lBody),
                  const SizedBox(width: Insets.l),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontFamily: 'Montserrat-Regular',
                          fontSize: TextSize.lBody,
                          color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter data',
                        suffixIcon: nameController.text.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  nameController.clear();
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
                onPressed: (() {
                  Navigator.pop(context);
                }),
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
