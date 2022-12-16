import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/profile_picture.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/styles/text.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Insets.l * 1.5),
          const ProfilePicture(),
          const SizedBox(height: kDefaultPadding * 2),
          Container(
            height: 50,
            width: 400,
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: kSecondaryColor, width: 0.5))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding * 0.75, left: kDefaultPadding * 0.5),
                  child: StandardTextStyle(
                    text: 'Name',
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                TextFieldModel(
                    hint: 'Name',
                    maxLength: 30,
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
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding * 0.75, left: kDefaultPadding * 0.5),
                  child: StandardTextStyle(
                    text: 'Username',
                    fontSize: TextSize.lBody,
                  ),
                ),
                Spacer(),
                TextFieldModel(
                    hint: 'Username',
                    maxLength: 20,
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
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding * 0.75, left: kDefaultPadding * 0.5),
                  child: StandardTextStyle(
                    text: 'E-mail',
                    fontSize: TextSize.lBody,
                  ),
                ),
                Spacer(),
                TextFieldModel(
                  hint: 'E-mail',
                  maxLength: TextField.noMaxLength,
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
