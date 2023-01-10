import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/profile_picture.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';

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
                  child: LargeBody(text: 'Name'),
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
                  child: LargeBody(text: 'Username'),
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
            height: 48,
            width: 400,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: kSecondaryColor, width: 0.5))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding * 0.75, left: kDefaultPadding * 0.5),
                  child: LargeBody(text: 'E-mail'),
                ),
                Spacer(),
                TextFieldModel(
                  hint: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
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
