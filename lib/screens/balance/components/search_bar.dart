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
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                hintStyle: const TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: TextSize.lBody,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Insets.m),
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