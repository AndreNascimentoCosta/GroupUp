import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> items = ['Money', 'Others'];
  String? selectedItem = 'Money';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StaticText(text: 'Type', fontSize: TextSize.lBody),
        const SizedBox(height: Insets.s),
        SizedBox(
          width: 120,
          child: Listener(
            onPointerDown: ((event) {
              FocusScope.of(context).unfocus();
            }),
            child: DropdownButtonFormField2(
              buttonHeight: 50,
              buttonWidth: 120,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Insets.s),
                  borderSide: const BorderSide(color: kSecondaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Insets.s),
                  borderSide: const BorderSide(color: kSecondaryColor),
                ),
              ),
              value: selectedItem,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: StaticText(
                        text: item,
                        fontFamily: 'Montserrat-Regular',
                        fontSize: TextSize.mBody,
                      ),))
                  .toList(),
              onChanged: (item) {
                return setState(() {
                  selectedItem = item;
                });
              },
              itemHeight: 50,
            ),
          ),
        ),
      ],
    );
  }
}
