import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onTap,
      ],
      child: GestureDetector(
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                hintStyle: const TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: TextSize.lBody,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Insets.l),
                  borderSide: const BorderSide(color: kSecondaryColor),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}