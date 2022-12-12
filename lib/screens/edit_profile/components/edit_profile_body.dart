import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/edit_profile/components/profile_picture.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/styles/standard_text.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30,
          ),
          const ProfilePicture(),
          const SizedBox(height: kDefaultPadding * 2),
          Container(
            height: 50,
            width: 400,
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: kSecondaryColor, width: 0.5))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  child: StandardTextStyle(
                    text: 'Name',
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                const TextFieldModel(
                    hint: 'Name',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: kSecondaryColor,
                      width: 0.5,
                    ))),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            width: 400,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  child: StandardTextStyle(
                    text: 'Username',
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                const TextFieldModel(
                    hint: 'Username',
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: kSecondaryColor, width: 0.5))),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 400,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: kSecondaryColor, width: 0.5))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  child: StandardTextStyle(
                    text: 'E-mail',
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                const TextFieldModel(
                  hint: 'E-mail',
                  border: InputBorder.none,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
