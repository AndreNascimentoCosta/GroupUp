import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';

class MaxNumberParticipants extends StatelessWidget {
  const MaxNumberParticipants({required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPrimaryColor,
            elevation: 0,
            child: SvgPicture.asset(
              'assets/icons/minus.svg',
              height: Insets.xs,
              width: Insets.xs,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: Insets.l * 2),
          // TextFieldModel(hint: (groupModel.userInformation.length + 1).toString(), maxLength: 2),
          SizedBox(
            width: 35,
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: TextSize.subTitle,
                  color: Colors.black),
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: (groupModel.userInformation.length + 1).toString(),
                  hintStyle: const TextStyle(
                      fontFamily: 'Montserrat-Medium',
                      fontSize: TextSize.subTitle,
                      color: Colors.black)),
            ),
          ),
          const SizedBox(width: Insets.l * 2),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPrimaryColor,
            elevation: 0,
            child: SvgPicture.asset(
                'assets/icons/plus.svg',
              height: Insets.l * 1.5,
              width: Insets.l * 1.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
